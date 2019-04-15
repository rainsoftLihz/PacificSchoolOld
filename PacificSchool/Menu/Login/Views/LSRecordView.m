//
//  LSRecordView.m
//  RecordVoiceDemo
//
//  Created by Jonny on 2019/2/25.
//  Copyright © 2019 allison. All rights reserved.
//

#import "LSRecordView.h"
#import <AVFoundation/AVFoundation.h>
#import "LameTool.h"

static NSString *const MP3SaveFilePath = @"MP3File";

@interface LSRecordView ()
<
    AVAudioRecorderDelegate
>
{
    dispatch_source_t _timer;
}

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *recordBtn;
@property(nonatomic,strong) AVAudioRecorder *record;
@property(nonatomic,strong)NSString *cafPath;
@property(nonatomic,strong)NSString *recordName;

@end
@implementation LSRecordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        [self initUI];
        
    }
    return self;
}

- (void)initData {
    
}

- (void)initUI {
    
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 156)];
    _titleLabel.font = [UIFont systemFontOfSize:70];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"3:00";
    [self addSubview:_titleLabel];
    
    _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recordBtn.frame = CGRectMake(0, 156, 300, 44);
    [_recordBtn setTitle:@"按下录音" forState:0];
    _recordBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_recordBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_recordBtn addTarget:self action:@selector(startRecordNotice) forControlEvents:(UIControlEventTouchDown)];
    _recordBtn.backgroundColor = kMainColor;
    [_recordBtn addTarget:self action:@selector(stopRecordNotice) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_recordBtn];
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 156, 300, 44)];
    _bottomView.hidden = YES;
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, 149, 44);
    [cancelBtn addTarget:self action:@selector(cancelRecordNotice) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setImage:[UIImage imageNamed:@"cuo"] forState:0];
    cancelBtn.backgroundColor = kMainColor;
    [_bottomView addSubview:cancelBtn];
    
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(151, 0, 150, 44);
    [doneBtn addTarget:self action:@selector(doneRecordNotice) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setImage:[UIImage imageNamed:@"duihao"] forState:0];
    doneBtn.backgroundColor = kMainColor;
    [_bottomView addSubview:doneBtn];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
}

- (void)startRecordNotice {
    
    NSLog(@"按下");
    [self countDown];
    
    [self startRecord];
}

- (void)stopRecordNotice {
    NSLog(@"抬起");
    [self  pauseTimer];
    self->_bottomView.hidden = NO;
    [self endRecord];
}

- (void)cancelRecordNotice {
    NSLog(@"取消");
    
    [self clearCafFile];
    
    [self hidenView];
    
    [self removeFromSuperview];
}

#pragma mark - 确定
- (void)doneRecordNotice {
    NSLog(@"确定");
    [self stopTimer];
    
    if (self.eventBlock) {
        
        NSString *newPath = [LameTool audioToMP3:self.cafPath isDeleteSourchFile:YES];
        self.recordName = [newPath lastPathComponent];
        NSLog(@"录音新地址 %@ 文件名字 %@",newPath,self.recordName);

        self.eventBlock(newPath, self.recordName);
        
    }
    [self hidenView];
}

- (void)hidenView {
    
    if (self.hiddenEventBlock) {
        self.hiddenEventBlock();
    }
    
    [self removeFromSuperview];
}

- (void)countDownTimer {
    [self stopTimer];
}

- (void)startRecord {
    
    [self.record record];
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


- (void)countDown {
    
    __block NSInteger timeout = 180; // 倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            //倒计时结束，关闭
            dispatch_source_cancel(self->_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self->_titleLabel.text = @"0:00";
                self->_bottomView.hidden = NO;
            });
        } else {
            
            NSInteger minutes = timeout / 60;
            NSInteger seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%ld:%.2ld",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self->_titleLabel.text = strTime;
                self->_bottomView.hidden = YES;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)pauseTimer{
    if(_timer){
        dispatch_suspend(_timer);
    }
}

- (void)resumeTimer{
    if(_timer){
        dispatch_resume(_timer);
    }
}

- (void)stopTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
//        _timer = nil;
        NSLog(@" timer === %@",_timer);
    }
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
    return [[dateFormatter stringFromDate:[NSDate date]] stringByAppendingString:@".caf"];
}
@end


