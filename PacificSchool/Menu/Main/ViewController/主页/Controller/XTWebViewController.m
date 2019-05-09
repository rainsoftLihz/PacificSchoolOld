//
//  XTWebViewController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/5/8.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "XTWebViewController.h"
#import <WebKit/WebKit.h>
@interface XTWebViewController ()<UIWebViewDelegate,
WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation XTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)initUI {
    
    self.title = @"通关考";
    
    NSString *userid = DEF_PERSISTENT_GET_OBJECT(kUserId);
    NSString *userToken = DEF_PERSISTENT_GET_OBJECT(kUserToken);
    NSString *nickname = DEF_PERSISTENT_GET_OBJECT(kNickName);
    NSString *headimgurl = DEF_PERSISTENT_GET_OBJECT(kHeadImgUrl);

    self.wkWebView.navigationDelegate = self;
    
    [self.view addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
  
    NSString *host = @"http://m.51eln.com/project/cpic/pk/index.html";
    
    NSString *urlString = [NSString stringWithFormat:@"%@?type=1&traningType=1&coopCode=cpic&frontUserId=%@&accessToken=%@&auth=force&headimgurl=%@&nickname=%@",host,userid,userToken,headimgurl,nickname];
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
        configuration.preferences.minimumFontSize = 8.0;
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        _wkWebView.backgroundColor = [UIColor blueColor];
    }
    return _wkWebView;
}

- (void)dealloc {
    
    NSLog(@"释放%@",self);
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
