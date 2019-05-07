//
//  ZCNoneiFLYTEK.m
//  JK_BLB
//
//  Created by shiyang on 16/1/5.
//  Copyright © 2015年 com.application.qiyun. All rights reserved.
//

#import "FlyVoiceManager.h"
#import "IATConfig.h"
#import "ISRDataHelper.h"

@implementation FlyVoiceManager
static FlyVoiceManager *manager=nil;
-(id)init
{
    if (self=[super init]) {
        
    }
    return self;
}
+(id)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager==nil) {
            manager=[[self alloc]init];
        }
    });
    return manager;
}



-(void)startSpeaking{
    if(_iFlySpeechRecognizer == nil)
    {
        [self initRecognizer];
    }
    isAutoStop = 0;
    
    _resultStr = @"";
    
    [_iFlySpeechRecognizer cancel];
    
    //设置音频来源为麦克风
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iFlySpeechRecognizer setDelegate:self];
    
    [_iFlySpeechRecognizer startListening];

}

/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        //单例模式，无UI的实例
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
            
            [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        }
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //设置最长录音时间
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }
}


-(void)stopSpeaking:(void(^)(NSString *))a{
    isAutoStop = 1;
    [_iFlySpeechRecognizer stopListening];
    self.onResult=a;
    _resultStr = @"";
}

-(void)cancleSpeaking:(void(^)(NSString *))a{
    isAutoStop = 2;
    [_iFlySpeechRecognizer stopListening];
    self.onResult=a;
    _resultStr = @"";
}

- (void)cancelSpeaking{
    [_iFlySpeechRecognizer cancel];
}


#pragma mark 语音识别代理

/*
 * 音量变化回调
 * 在录音过程中，回调音频的音量。
 * @param volume -[out] 音量，范围从1-100
 */
- (void) onVolumeChanged: (int)volume{
	if (self.volumeDelegate && [self.volumeDelegate respondsToSelector:@selector(onVolumeChanged:)])
	{
		[self.volumeDelegate onVolumeChanged:volume];
	}
}

/*
 * 开始录音回调
 * 当调用了`startListening`函数之后，如果没有发生错误则会回调此函数。如果发生错误则回调onError:函数
 */
- (void) onBeginOfSpeech{
    
}

/*
 * 停止录音回调
 * 当调用了`stopListening`函数或者引擎内部自动检测到断点，如果没有发生错误则回调此函数。如果发生错误则回调onError:函数
 */
- (void) onEndOfSpeech{
    
}

/*
 * 识别结果回调
 * 在进行语音识别过程中的任何时刻都有可能回调此函数，你可以根据errorCode进行相应的处理，当errorCode没有错误时，表示此次会话正常结束，否则，表示此次会话有错误发生。特别的当调用`cancel`函数时，引擎不会自动结束，需要等到回调此函数，才表示此次会话结束。在没有回调此函数之前如果重新调用了`startListenging`函数则会报错误。
 * @param errorCode 错误描述类，
 */
- (void) onError:(IFlySpeechError *) error{
    NSString *text;
    if (error.errorCode == 0 ) {
        text = @"识别结束";
        SAVE_VALUE(@"CurrentVoiceText", @"");
        //视图退出
        [[NSNotificationCenter defaultCenter] postNotificationName:kVoiceError object:nil];
        
    }else {
        text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
    }
    NSLog(@"%@",text);
}

/*
 * 识别结果回调
 * 在识别过程中可能会多次回调此函数，你最好不要在此回调函数中进行界面的更改等操作，只需要将回调的结果保存起来。
 * @param   result  -[out] 识别结果，NSArray的第一个元素为NSDictionary，NSDictionary的key为识别结果，value为置信度。
 */
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    _resultStr = resultFromJson;
    if (isAutoStop==1 || isAutoStop==2) {
        isAutoStop = 0;
        if (self.onResult) {
            self.onResult(_resultStr);
        }
    }else{//自动停止,提醒界面显示文字
        if (!isLast) {
            SAVE_VALUE(@"CurrentVoiceText", [LOAD_VALUE(@"CurrentVoiceText") stringByAppendingString:_resultStr]);
            [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshTheDrugConsultTextField object:_resultStr];
        }
    }
}

/*
 * 取消识别回调
 * 当调用了`cancel`函数之后，会回调此函数，在调用了cancel函数和回调onError之前会有一个短暂时间，您可以在此函数中实现对这段时间的界面显示。
 */
- (void) onCancel{
    
}
    
- (void)onCompleted:(IFlySpeechError *)errorCode { 
    
}
    

@end
