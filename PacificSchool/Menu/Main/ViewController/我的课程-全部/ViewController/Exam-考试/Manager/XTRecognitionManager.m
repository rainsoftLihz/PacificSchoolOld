//
//  XTRecognitionManager.m
//  SpeechTest
//
//  Created by Jonny on 2019/3/16.
//  Copyright © 2019 Dushu Ou. All rights reserved.
//

#import "XTRecognitionManager.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

@interface XTRecognitionManager ()<

    SFSpeechRecognizerDelegate

>

@property (nonatomic,strong) SFSpeechRecognizer *speechRecognizer; ///< 语音识别器
@property (nonatomic,strong) AVAudioEngine *audioEngine;        ///< 音频引擎
@property (nonatomic,strong) SFSpeechRecognitionTask *recognitionTask;///< 识别任务
@property (nonatomic,strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest; ///< 识别结果

@end

@implementation XTRecognitionManager

+(XTRecognitionManager *)shareManager {

    static XTRecognitionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    
    return manager;
}

// 点击开始录音
- (void)recordButtonClicked {
    
    if (self.audioEngine.isRunning) {
        [self endRecording];
//        [self.recordButton setTitle:@"正在停止" forState:UIControlStateDisabled];
        
        if (self.stopingBlock) {
            self.stopingBlock(@"正在停止");
        }
        
    } else{
        [self startRecording];
//        [self.recordButton setTitle:@"停止录音" forState:UIControlStateNormal];
        if (self.startBlock) {
            self.startBlock(@"停止录音");
        }
    }
}

- (void)endRecording{
    [self.audioEngine stop];
    if (_recognitionRequest) {
        [_recognitionRequest endAudio];
    }
    
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
//    self.recordButton.enabled = NO;
    
//    if ([self.resultStringLable.text isEqualToString:LoadingText]) {
//        self.resultStringLable.text = @"";
//    }
    
    if (self.stopBlock) {
        self.stopBlock(@"");
    }
}

- (void)startRecording {
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    NSParameterAssert(!error);
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    
    _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    NSAssert(inputNode, @"录入设备没有准备好");
    NSAssert(_recognitionRequest, @"请求初始化失败");
    _recognitionRequest.shouldReportPartialResults = YES;
    __weak typeof(self) weakSelf = self;
    _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        BOOL isFinal = NO;
        if (result) {
            
            if (self.resultBlock) {
                self.resultBlock(result.bestTranscription.formattedString);
            }
            NSLog(@"语音识别内容 %@",result.bestTranscription.segments);
//            strongSelf.resultStringLable.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;
        }
        if (error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            strongSelf.recognitionTask = nil;
            strongSelf.recognitionRequest = nil;
//            strongSelf.recordButton.enabled = YES;
//            [strongSelf.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
            if (self.errorBlock) {
                self.errorBlock(@"");
            }
            
        }
        
    }];
    
    AVAudioFormat *recordingFormat = [inputNode outputFormatForBus:0];
    //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
    [inputNode removeTapOnBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.recognitionRequest) {
            [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
        }
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
    if (self.errorBlock) {
        self.errorBlock(@"");
    }
//    self.resultStringLable.text = LoadingText;
}

#pragma mark - property
- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}
- (SFSpeechRecognizer *)speechRecognizer{
    if (!_speechRecognizer) {
        //腰围语音识别对象设置语言，这里设置的是中文
        NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        _speechRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}
#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available{
//    if (available) {
////        self.recordButton.enabled = YES;
////        [self.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
//    }
//    else{
////        self.recordButton.enabled = NO;
////        [self.recordButton setTitle:@"语音识别不可用" forState:UIControlStateDisabled];
//    }
    
    if (self.availableBlock) {
        self.availableBlock(available);
    }
    
}

@end
