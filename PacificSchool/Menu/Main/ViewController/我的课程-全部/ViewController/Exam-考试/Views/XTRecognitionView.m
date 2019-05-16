//
//  XTRecognitionView.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/16.
//  Copyright © 2019 Jonny. All rights reserved.
//

 #import <AVFoundation/AVFoundation.h>
#import "XTRecognitionView.h"
#import "XTRecognitionManager.h"
#import "XTMainViewModel.h"
#import "JFRWebSocket.h"
#import "SocketRocket.h"
#import "VoiceRecognizeRequest.h"
#import "VoiceRecognizeResponse.h"
#import <AIPIFlyMSC/AIPIFlyRecordHelper.h>

@interface XTRecognitionView ()
<
SRWebSocketDelegate,
AIPIFlyRecordDelegate
>
@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,copy)NSString *recordString; ///< 记录录音数据
@property(nonatomic,strong)UILabel *msgLabel;
@property(nonatomic,strong)UILabel *matchingLabel;

@property(nonatomic, strong)SRWebSocket *websocket;
//@property(nonatomic, strong)IFlyPcmRecorder  *pcmRecorder;
@property(nonatomic, strong) NSMutableDictionary *dict;
@property(nonatomic, strong) AIPIFlyRecordHelper *aIPIFlyRecor;
@property(nonatomic, strong)VoiceRecognizeRequest *request;
@property(nonatomic, assign) BOOL isStart;
    
@end

@implementation XTRecognitionView

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
    self.isStart = NO;
    self.dict = [NSMutableDictionary dictionaryWithDictionary:@{@"token":@"ca5eafd0fc574a2cafe3f9481603a102",
                                    @"appId":@"df0c498c847149d3aa4488b39f1e27f5",
                                    @"bizNo":@"",
                                    @"reqNo":@"",
                                    @"rate":@"16k",
                                    @"audioStatus":@"1",
                                    }];
}


#pragma mark - AIPIFlyRecordDelegate
// result录音数据 epStatus 0没有检测到端点，1有效音频，2检测到前端点，3检测到后端点
- (void)onRecordResult:(NSData *)result epStatus:(int) epStatus {
    if (epStatus != 0) {
        NSLog(@"epStatus:%d,size:%ld", epStatus, result.length);
    }
    
    if (epStatus == 2) {
        // 第一段
        // NOTE: 此处需要剪裁,不然socket报1001.其他场景建议测试后,确定是否需要
        long A_RECEIVE = 1024*2;
        NSMutableArray *videoDataArray = [[NSMutableArray alloc] init];
        int lastIValue = 0;
        for (int i = 0; i<= [result length]-A_RECEIVE; i+=A_RECEIVE) {
            lastIValue  = i+A_RECEIVE;
            NSString *rangeStr = [NSString stringWithFormat:@"%i,%i",i,A_RECEIVE];
            NSData *subData = [result subdataWithRange:NSRangeFromString(rangeStr)];
            [videoDataArray addObject:subData];
            if (self.isStart) {
                self.dict[@"audioStatus"]= @"1";
                self.isStart = NO;
            } else {
                self.dict[@"audioStatus"]= @"2";
            }
            NSString *base64String = [subData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            self.dict[@"voiceData"] = base64String;
            NSData *jsonData= [NSJSONSerialization dataWithJSONObject:self.dict options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [self.websocket send:jsonStr];
            [NSThread sleepForTimeInterval:0.01];
        }
    } else if (epStatus == 1) {
        // 中间
        self.dict[@"audioStatus"]= @"2";
        NSString *base64String = [result base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        self.dict[@"voiceData"] = base64String;
        NSData *jsonData= [NSJSONSerialization dataWithJSONObject:self.dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self.websocket send:jsonStr];
    }  else if (epStatus == 3) {
        // 结束
        self.dict[@"audioStatus"]= @"2";
        NSString *base64String = [result base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        self.dict[@"voiceData"] = base64String;
        NSData *jsonData= [NSJSONSerialization dataWithJSONObject:self.dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self.websocket send:jsonStr];
    }
}
- (void) onError:(int) code {
    NSLog(@"code:%d", code);
}

#pragma mark --- swwebsocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    NSString *reqNo = self.dict[@"reqNo"];
    if (nil == reqNo || [reqNo isEqualToString:@""]) {
        // 初次使用空值换取有效 reqNO
        NSData *data= [NSJSONSerialization dataWithJSONObject:self.dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        NSLog(@"%@", self.dict);
        [webSocket send:jsonStr];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"WebSocket Received \"%@\"", message);
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (nil != dic[@"content"] && [NSNull null] != dic[@"content"]
        && nil != dic[@"content"][@"reqNo"] && [NSNull null] != dic[@"content"][@"reqNo"]) {
        NSString *reqNo = dic[@"content"][@"reqNo"];
        self.dict[@"reqNo"] = reqNo;
    }
    if (nil != dic[@"content"] && [NSNull null] != dic[@"content"]
        && nil != dic[@"content"][@"voiceMessage"] && [NSNull null] != dic[@"content"][@"voiceMessage"]) {
        NSString *voiceMessage = dic[@"content"][@"voiceMessage"];
        self.textView.text = [self.textView.text stringByAppendingString:voiceMessage];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    self.dict[@"reqNo"] = @"";
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"Websocket received pong");
}
#pragma mark - touch event
- (void)startRecordEvent:(UIButton *)btn {
    NSLog(@"按下");
    if (self.websocket) {
        [self.websocket close];
        self.websocket = nil;
    }
    SRWebSocket *webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"wss://aiskill.cpic.com.cn/websocket/voiceRecognize/online"]];
    webSocket.delegate = self;
    self.websocket = webSocket;
    [self.websocket open];

    self.isStart = YES;
    // 初始化语音识别
    NSString *path = [[NSBundle mainBundle] pathForResource:@"meta_vad_16k" ofType:@"jet"];
    self.aIPIFlyRecor = [[AIPIFlyRecordHelper alloc] init:self config:[NSString stringWithFormat:@"vad_res=%@,aue=raw", path]];
    [self.aIPIFlyRecor startRecord];
    
    _msgLabel.text = @"松开停止录音";
}

- (void)stopRecordBtn:(UIButton *)btn {
    [self.aIPIFlyRecor stopRecord];
    [self.websocket close];
    self.websocket = nil;
    self.recordString = self.textView.text;
    _msgLabel.text = @"按下开始录音";
    [self requestMatching];
}

- (void)sendFileData
{
    //文件路径
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"raninsoft" ofType:@"pcm"];
    //计算文件大小
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attriDict = [fileManager attributesOfItemAtPath:filePath error:nil];
    //获取文件大小
    NSString * fileSize = attriDict[NSFileSize];
    NSLog(@"-------总大小%lld",fileSize.longLongValue);
    
    NSInteger bufferSize = 1028;
    //循环次数
    NSInteger times = fileSize.longLongValue/bufferSize;
    //创建句柄
    NSFileHandle* handler = [NSFileHandle fileHandleForReadingAtPath:filePath];
    //开始循环读取
    for (NSInteger index = 0; index < times ; index ++) {
        //设置每次句柄偏移量
        [handler seekToFileOffset:bufferSize *(index + 1)];
        //获取每次读入data
        NSData *data = [handler readDataOfLength:bufferSize];
        NSLog(@"-----%lu",(unsigned long)data.length);
        
        NSString* dataStrf = [data base64EncodedStringWithOptions:0];
        self.request.voiceData = dataStrf;
        
        NSData* tdata = self.request.mj_JSONData;
        NSString* dataStr = [[NSString alloc] initWithData:tdata
                                                  encoding:NSUTF8StringEncoding];
        
        if (self.websocket.readyState != SR_OPEN) {
            self.websocket = nil;
            [self.websocket open];
        }
        [self.websocket send:dataStr];
        sleep(2);
        if (index == times - 1) {
            //关闭句柄
            [handler closeFile];
        }
    }
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
    self.matchingLabel.text = @"";
}

//- (void)onIFlyRecorderBuffer:(const void *)buffer bufferSize:(int)size {
//    self.request.voiceData = [[[NSData alloc]initWithBytes:buffer length:size] base64EncodedStringWithOptions:0];
//    NSData* data = self.request.mj_JSONData;
//    NSString* dataStr = [[NSString alloc] initWithData:data
//                                               encoding:NSUTF8StringEncoding];
//    NSLog(@"dataStr==>>>%@",dataStr)
//
//    [self.websocket send:dataStr];

//
//}
//
//- (void)onIFlyRecorderError:(IFlyPcmRecorder *)recoder theError:(int)error {
//
//}

#pragma mark --- lazy
//-(SRWebSocket *)websocket{
//    if (!_websocket) {
//        // @"wss://aiskill.cpic.com.cn/websocket/voiceRecognize/online"
//        // @"wss://aiskillsit.cpic.com.cn/websocket/voiceRecognize/online"
//        _websocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"wss://aiskill.cpic.com.cn/websocket/voiceRecognize/online"]];
//        _websocket.delegate = self;
//    }
//    return _websocket;
//}

-(VoiceRecognizeRequest *)request{
    if (!_request) {
        _request = [[VoiceRecognizeRequest alloc] initWith:@"9585b61fb61c4f9fb0129c7152b4d191" appId:@"e22cceb74ada4364b76313a44ed52049" reqNo:@"" rate:@"16k" audioStatus:@"1"];
        _request.language = @"1";
    }
    return _request;
}

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
    [recordBtn addTarget:self action:@selector(stopRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:recordBtn];
    
    UILabel *reLabel = [UILabel new];
    reLabel.text = @"停止";
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


-(void)dealloc{
    //[self.websocket close];
}

 @end

