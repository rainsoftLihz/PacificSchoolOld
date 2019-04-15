//
//  XTCustomsPassViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/13.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCustomsPassViewController.h"
#import <WebKit/WebKit.h>

@interface XTCustomsPassViewController ()
<
    UIWebViewDelegate,
    WKNavigationDelegate,
    WKScriptMessageHandler

>

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation XTCustomsPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}

- (void)initData {
    
}

- (void)initUI {
 
    self.title = @"通关考";
    
    NSString *userid = DEF_PERSISTENT_GET_OBJECT(kUserId);
    NSString *userToken = DEF_PERSISTENT_GET_OBJECT(kUserToken);
    
    self.wkWebView.navigationDelegate = self;
    
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
//https://learntestweb.wezhuiyi.com/training/client/mobile-microphone/id/标题?type=1&traningType=1" +
//    "&coopCode=" + coopCode +
//    "&frontUserId=" + frontUserId +
//    "&accessToken=" + token +
//    "&auth=force"
    
    
    NSString *host = @"https://learntestweb.wezhuiyi.com/training/client/mobile-microphone/";
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@/%@?type=1&traningType=1&coopCode=cpic&frontUserId=%@&accessToken=%@&auth=force",host,self.examId,self.examTitle,userid,userToken];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@" ===  %@",urlString);
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];

}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//        [userContentController addScriptMessageHandler:self name:@"start"];
//        [userContentController addScriptMessageHandler:self name:@"end"];
//
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        configuration.allowsInlineMediaPlayback = YES;
        configuration.mediaTypesRequiringUserActionForPlayback = false;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        _wkWebView.backgroundColor = [UIColor blueColor];
    }
    return _wkWebView;
}

- (void)dealloc {
    
    NSLog(@"释放");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
