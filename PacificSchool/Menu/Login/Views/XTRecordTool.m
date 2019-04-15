//
//  XTRecordTool.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/14.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTRecordTool.h"
#import <AVFoundation/AVFoundation.h>
#import "LameTool.h"

static NSString *const MP3SaveFilePath = @"MP3File";

@interface XTRecordTool ()
<
    AVAudioRecorderDelegate
>

@property(nonatomic,strong) AVAudioRecorder *record;
@property(nonatomic,strong)NSString *cafPath;
@property(nonatomic,strong)NSString *recordName;

@end

@implementation XTRecordTool

- (void)startRecord {
    
    [self.record record];
    
}

- (void)removeFilePath {
    
    NSFileManager *fileManeger = [NSFileManager defaultManager];
    
    NSString *folderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:MP3SaveFilePath];
    if ([fileManeger fileExistsAtPath:folderPath]) {
        BOOL isSuccess = [fileManeger removeItemAtPath:folderPath error:nil];
        NSLog(@"删除 %@",isSuccess == YES? @"成功":@"失败");
    }
}


- (void)endRecord {
    
    [self.record stop];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSLog(@"  文件路径 %@",self.cafPath);
    if (![fm fileExistsAtPath:self.cafPath]) {
        NSLog(@"文件不存在");
    }else {
        NSLog(@"存在");
    }
}


#pragma mark - 确定
- (void)doneRecordNotice {
    NSLog(@"确定");
    [self endRecord];
    if (self.eventBlock) {
        
//        NSString *newPath = [LameTool audioToMP3:self.cafPath isDeleteSourchFile:YES];
        self.recordName = [self.cafPath lastPathComponent];
        NSLog(@"录音地址 %@ 文件名字 %@",self.cafPath,self.recordName);
        
        self.eventBlock(self.cafPath, self.recordName);
        
    }
}


- (AVAudioRecorder *)record {
    if (!_record) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        if(sessionError){
            NSLog(@"Error creating session: %@", [sessionError description]);
        }
        else{
            [session setActive:YES error:nil];
        }
        
        //创建录音文件保存路径
        NSURL *url= [self getCafPath];
        //创建录音参数
        NSDictionary *setting = [self getAudioSetting];
        NSError *error=nil;
        _record = [[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        _record.delegate = self;
        _record.meteringEnabled=YES;
        [_record prepareToRecord];
        if (error) {
            NSLog(@"创建AVAudioRecorder Error：%@",error.localizedDescription);
            return nil;
        }
    }
    return _record;
}

-(NSURL *)getCafPath{
    //  在Documents目录下创建一个名为FileData的文件夹
    NSString *folderPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:MP3SaveFilePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:folderPath]) {
        BOOL isSuccess = [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (isSuccess) {
            NSLog(@"创建录音目录成功");
        }else {
            NSLog(@"创建录音目录失败");
        }
    }
    self.recordName = [self getRecordNameBaseCurrentTime];
    self.cafPath = [folderPath stringByAppendingPathComponent:self.recordName];
    NSURL *url=[NSURL fileURLWithPath:self.cafPath];
    return url;
}

- (void)clearCafFile {
    if (self.cafPath) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = FALSE;
        BOOL isDirExist = [fileManager fileExistsAtPath:self.cafPath isDirectory:&isDir];
        if (isDirExist) {
            [fileManager removeItemAtPath:self.cafPath error:nil];
            NSLog(@"清除上一次的Caf文件");
        }
    }
}

- (NSDictionary *)getAudioSetting {
    
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    [dicM setObject:@(16000) forKey:AVSampleRateKey]; //44.1khz的采样率
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    [dicM setObject:@(16) forKey:AVLinearPCMBitDepthKey]; //16bit的PCM数据
    [dicM setObject:[NSNumber numberWithInt:AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    
    return dicM;
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"1-----录音");
    }
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error {
    NSLog(@"2----- %@",error);
}

//以当前时间合成录音名称
- (NSString *)getRecordNameBaseCurrentTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    return [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingString:@".pcm"];
}

@end
