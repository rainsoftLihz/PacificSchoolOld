//
//  XTRecognitionView.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/16.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTRecognitionView.h"
#import "XTRecognitionManager.h"
#import "XTMainViewModel.h"
#import "JFRWebSocket.h"
#import "SocketRocket.h"
#import "VoiceRecognizeRequest.h"
#import "VoiceRecognizeResponse.h"
@interface XTRecognitionView ()<SRWebSocketDelegate>
@property(nonatomic,strong) XTRecognitionManager *manager;
@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,copy)NSString *recordString; ///< 记录录音数据
@property(nonatomic,strong)UILabel *msgLabel;
@property(nonatomic,strong)UILabel *matchingLabel;

//@property(nonatomic, strong)SRWebSocket *websocket;
//@property(nonatomic, strong)IFlyPcmRecorder  *pcmRecorder;
@property(nonatomic, strong)VoiceRecognizeRequest *request;
    
@end

@implementation XTRecognitionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

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
    self.recordString = @"";
    
//    self.manager = [[XTRecognitionManager alloc]init];
//    __weak typeof(self) __weakSelf = self;
//    self.manager.resultBlock = ^(NSString *result) {
//
//        __weakSelf.textView.text = [NSString stringWithFormat:@"%@%@",__weakSelf.recordString,result];
//    };


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textBack:) name:kRefreshTheDrugConsultTextField object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(voiceError) name:kVoiceError object:nil];
    
    //[self.socket connect];
    //[self.websocket open];
    
//    NSString*filePath = [[NSBundle mainBundle] pathForResource:@"rainsoft" ofType:@"pcm"];
//    
//    NSData* data= [NSData dataWithContentsOfFile:filePath];
    
}

#pragma mark --- lazy
//-(SRWebSocket *)websocket{
//    if (!_websocket) {
//        _websocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"wss://aiskillsit.cpic.com.cn/websocket/voiceRecognize/online"]];
//        _websocket.delegate = self;
//    }
//    return _websocket;
//}
//
//-(VoiceRecognizeRequest *)request{
//    if (!_request) {
//        _request = [[VoiceRecognizeRequest alloc] initWith:@"9585b61fb61c4f9fb0129c7152b4d191" appId:@"e22cceb74ada4364b76313a44ed52049" reqNo:@"" rate:@"16k" audioStatus:@"1"];
//        _request.language = @"1";
//    }
//    return _request;
//}
//
//
//-(IFlyPcmRecorder *)pcmRecorder{
//    if (!_pcmRecorder) {
//        _pcmRecorder = [IFlyPcmRecorder sharedInstance];
//        _pcmRecorder.delegate = self;
//        [_pcmRecorder setSample:@"16000"];
//    }
//    return _pcmRecorder;
//}

#pragma mark --- swwebsocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
//    [self.websocket open];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"WebSocket Received \"%@\"", message);
    
//    VoiceRecognizeResponse* response = [VoiceRecognizeResponse mj_objectWithKeyValues:message];
//    NSLog(@"reqNo: %@",response.content.reqNo);
//    if (response.content.reqNo) {
//        self.request.reqNo = response.content.reqNo;
//    }
//    self.textView.text = [self.textView.text stringByAppendingString:response.content.voiceMessage];
//
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
//    [self.websocket open];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"Websocket received pong");
}



#pragma mark --- 讯飞通知回调
-(void)voiceError{
    [[FlyVoiceManager shareManager] cancleSpeaking:^(NSString *str){
        NSLog(@"canceltemp====%@",str);
    }];
}

-(void)textBack:(NSNotification*)info{
    NSString *tempStr = info.object;
    NSLog(@"temp====%@",tempStr);
    self.textView.text = [self.textView.text stringByAppendingString:tempStr];
}



- (void)startRecordEvent:(UIButton *)btn {
    
    NSLog(@"按下");
    
    [[FlyVoiceManager shareManager] startSpeaking];

//    BOOL flag = [self.pcmRecorder start];
//    if (flag) {
//        NSLog(@"startRecord result is %d",flag);
//    }
//    NSLog(@"--->websoket State %ld",(long)self.websocket.readyState);
//    if (self.websocket.readyState != SR_OPEN) {
//        self.websocket = nil;
//        [self.websocket open];
//    }
    
    _msgLabel.text = @"松开停止录音";
}

- (void)stopRecordBtn:(UIButton *)btn {
    
    WeakSelf
    [[FlyVoiceManager shareManager] stopSpeaking:^(NSString *str) {
        NSLog(@"刚才说的是:%@",str);
        weakSelf.textView.text = [weakSelf.textView.text stringByAppendingString:str];
    }];
//    [self.pcmRecorder stop];
    NSLog(@"抬起");
    //[_manager endRecording];
    _msgLabel.text = @"按下开始录音";
    self.recordString = self.textView.text;
    
    [self requestMatching];

}

- (void)requestMatching {
    
    NSDictionary *param = @{@"voiceWords":self.quetionString,
                           @"examWords":_textView.text
                            };
    NSLog(@" 匹配 %@",param);
    
    [XTMainViewModel getMatchingSuccess:param success:^(NSDictionary * _Nonnull result) {
        self->_matchingLabel.text = [NSString stringWithFormat:@"匹配度:%@",result[@"data"]];
        NSLog(@" 结果 %@",self->_matchingLabel.text);

    }];
    
}


- (void)clearRecordBtn {
    
    self.textView.text = @"";
    self.recordString = @"";
}

//- (void)onIFlyRecorderBuffer:(const void *)buffer bufferSize:(int)size {
//    self.request.voiceData = [[[NSData alloc]initWithBytes:buffer length:size] base64EncodedStringWithOptions:0];
//    //NSLog(@"data==>>>%@",self.request.voiceData)
//
//    NSData* data = self.request.mj_JSONData;
//    NSString* dataStr = [[NSString alloc] initWithData:data
//                                               encoding:NSUTF8StringEncoding];
//    NSLog(@"dataStr==>>>%@",dataStr)
//
////    if (![self.socket isConnected]) {
////        NSLog(@"isConnected==>>>start");
////        [self.socket connect];
////    }
////    NSLog(@"isConnected==>>>over");
//    //[self.socket writeData:data];
////    [self.websocket sendString:dataStr error:nil];
//}
//
//- (void)onIFlyRecorderError:(IFlyPcmRecorder *)recoder theError:(int)error {
//
//}



- (void)initUI {
    
    
    UIView *titleView = [[UIView alloc]init];
    [self addSubview:titleView];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"home_top"];
    [titleView addSubview:imageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"跟读内容";
    titleLabel.font = kFont(15);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [titleView addSubview:titleLabel];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(titleView);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleView);
        make.center.equalTo(titleView);
    }];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(60);
    }];
    
    _textView = [UITextView new];
    _textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textView.text = @"";
    [self addSubview:_textView];
    _textView.editable = NO;
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(titleView.mas_bottom);
        make.height.mas_equalTo(100);
    }];
    
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordBtn setImage:[UIImage imageNamed:@"voice"] forState:0];
    [recordBtn addTarget:self action:@selector(clearRecordBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:recordBtn];
    
    UILabel *reLabel = [UILabel new];
    reLabel.text = @"重读";
    reLabel.textColor = kMainColor;
    reLabel.font = kFont(10);
    reLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:reLabel];
    
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-16);
        make.height.width.mas_equalTo(30);
        make.bottom.equalTo(reLabel.mas_top).offset(5);
        
    }];
    
    [reLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(recordBtn);
        make.height.width.mas_equalTo(30);
        make.bottom.equalTo(self.textView.mas_bottom).offset(5);
        
    }];
    
    UIButton *startRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startRecordBtn setImage:[UIImage imageNamed:@"voice"] forState:0];
    
    [startRecordBtn addTarget:self action:@selector(stopRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [startRecordBtn addTarget:self action:@selector(startRecordEvent:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:startRecordBtn];
    
    _msgLabel = [UILabel new];
    _msgLabel.text = @"按下开始录音";
    _msgLabel.textColor = kMainColor;
    _msgLabel.font = kFont(14);
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_msgLabel];
    
    [_msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.centerX.equalTo(self);
        make.height.mas_equalTo(20);
        make.left.right.equalTo(self);
        make.top.equalTo(self.textView.mas_bottom).offset(8);
        
    }];
    
    [startRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.height.width.mas_equalTo(60);
        make.top.equalTo(self.msgLabel.mas_bottom).offset(8);
        
    }];
    
    _matchingLabel = [UILabel new];
    _matchingLabel.text = @"匹配度:";
    _matchingLabel.textColor = [UIColor grayColor];
    _matchingLabel.font = kFont(12);
    //    _matchingLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_matchingLabel];
    
    [_matchingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
        make.left.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom).offset(8);
        
    }];
    
}

    
 @end
