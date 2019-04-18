//
//  XTSceneExerciseViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/13.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTSceneExerciseViewController.h"
#import "LSDateTool.h"
#import <WebKit/WebKit.h>
#import "AQCapture.h"
#import "XTExamResultViewController.h"

@interface XTSceneExerciseViewController ()
<
    UIWebViewDelegate,
    WKNavigationDelegate,
    AQCaptureDelegate,
    WKScriptMessageHandler,
    WKUIDelegate

>

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) NSURLConnection *urlConnection;

@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) UIButton *stopButton;

@property (nonatomic, strong) AQCapture *capture;

@property (nonatomic,assign)UInt32  bitsPerChannel;
@property (nonatomic,assign)UInt32  bytesPerPacket;
@property (nonatomic,assign)UInt32  sampleRateKey;


@end

@implementation XTSceneExerciseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;

    NSString *userid = DEF_PERSISTENT_GET_OBJECT(kUserId);
    NSString *userToken = DEF_PERSISTENT_GET_OBJECT(kUserToken);
    
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;

    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    
    if (self.webType == XTWebTestType) {
        self.title = @"情景演练";
        
//        NSString *urlString = @"https://learntestweb.wezhuiyi.com/training/client/mobile-exam-list?m=getByAccessToken&coopCode=zykj&accessToken=03e388da09ffdecb45bf1a73db95cf94&frontUserId=admin&timestamp=1551791500248&expire=24&auth=force";
        
        NSString *timeStampValueString = [NSString stringWithFormat:@"%ld",[LSDateTool timeStampValue2]];
        NSString *urlString = [NSString stringWithFormat:@"%@training/client/mobile-exam-list?m=getByAccessToken&coopCode=cpic&accessToken=%@&frontUserId=%@&timestamp=%@&expire=24&auth=force",kZhxy,userToken,userid,timeStampValueString];
        
        NSLog(@"urlString === %@",urlString);
        
        NSURL * url = [[NSURL alloc]initWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.wkWebView loadRequest:request];
        
    }else {
        self.title = @"通关考";
        NSString *host = [NSString stringWithFormat:@"%@training/client/mobile-microphone/",kZhxy];
        NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?type=1&traningType=1&coopCode=cpic&frontUserId=%@&accessToken=%@&auth=force",host,self.examId,self.examTitle,userid,userToken];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSLog(@" 通关考链接===  %@",urlString);
        NSURL *url = [[NSURL alloc]initWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.wkWebView loadRequest:request];

    }
    
}

- (void)clickedStartButtonHandler {
    _capture = nil;
    _capture = [[AQCapture alloc] initWithSampleRateKey:_sampleRateKey bitsPerChannel:_bitsPerChannel bytesPerPacket:_bytesPerPacket];
    
    _capture.delegate = self;
    
    [_capture startRecord];
}

- (void)clickedEndButtonHandler {
    
    [_capture stopRecord];
    
}

#pragma mark - AQCaptureDelegate

- (void)returnData:(NSMutableData *)data {
    
    NSString *dataString = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    //NSLog(@" 录音数据 %@",dataString);
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSString *js = [NSString stringWithFormat:@"recordBufferCallbackIOS('%@')",dataString];
        [self.wkWebView evaluateJavaScript:js completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            if (error) {
                NSLog(@"error == %@",error.description);
            }else {
                NSLog(@"result == %@",result);
            }
        }];
    });
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    /** 此方法是向JS代码传参数 */
    NSString * jsStr = [NSString stringWithFormat:@"getRecordOptionsIOS('%@')",@"OC调用JS"];
    [self.wkWebView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"拿到录音参数参数%@----%@",result, error);
        self->_bitsPerChannel = [result[@"bitsPerChannel"] intValue];
        self->_bytesPerPacket = [result[@"bytesPerPacket"] intValue];
        self->_sampleRateKey = [result[@"sampleRateKey"] intValue];
        
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler  {
    
    NSLog(@" runJavaScriptAlertPanelWithMessage%@",message);
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"message ==== %@ boby===%@",message.name,message.body);
    if ([message.body isEqualToString:@"StartRecord"]) {
        [self clickedStartButtonHandler];
        
    }else if ([message.body isEqualToString:@"EndRecord"]){
        [self clickedEndButtonHandler];
        
    }else if ([message.name isEqualToString:@"endExam"]){
        
        NSLog(@"结束考试");
        [self endExam:message.body];
        
    }
}



- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"start"];
        [userContentController addScriptMessageHandler:self name:@"end"];
        [userContentController addScriptMessageHandler:self name:@"endExam"];

        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        configuration.allowsInlineMediaPlayback = YES;
        configuration.mediaTypesRequiringUserActionForPlayback = false;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        //_wkWebView.backgroundColor = [UIColor blueColor];
    }
    return _wkWebView;
}


- (void)viewWillDisappear:(BOOL)animated {

    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;

    [self clickedEndButtonHandler];
    self.capture = nil;
    _wkWebView = nil;
}


- (void)endExam:(NSString *)examId {

    XTExamResultViewController *exam = [XTExamResultViewController new];
    exam.detailId = examId;
    [self.navigationController pushViewController:exam animated:YES];
    
}

-(void)dealloc{
    NSLog(@"======dealloc========");
}

@end
