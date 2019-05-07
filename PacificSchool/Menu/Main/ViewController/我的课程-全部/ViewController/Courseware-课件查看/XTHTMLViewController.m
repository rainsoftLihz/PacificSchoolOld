//
//  XTHTMLViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTHTMLViewController.h"
#import <WebKit/WebKit.h>
#import "XTCourseModel.h"
#import "XTMainViewModel.h"

@interface XTHTMLViewController ()
@property (strong, nonatomic)WKWebView *webView;
@property (strong, nonatomic)UIButton *datebtn;

@property (nonatomic, assign) NSTimeInterval starTime;  ///< 开始时间
@property (nonatomic, assign) NSTimeInterval finishTime;///< 结束时间

@property (strong, nonatomic)NSTimer *timer;
@property (assign, nonatomic)NSInteger studyCount;
@end

@implementation XTHTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
    //监听是否触发home键挂起程序.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
//        name:UIApplicationWillResignActiveNotification object:nil];
//    //监听是否重新进入程序程序.
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
//        name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)initData {
 
    _studyCount = 0;
    _starTime = [[NSDate date] timeIntervalSince1970];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self beginSaveLearnTracking];
    self.webView = nil;
    
}
#pragma mark - 开始保存学习时间
- (void)beginSaveLearnTracking {
    
    _finishTime = [[NSDate date] timeIntervalSince1970];
    [self saveQeustionLearning];
    
}

- (void)saveQeustionLearning {
    
    int countTime = (int)_finishTime-_starTime;
    NSString *studyTime = [NSString stringWithFormat:@"%d",countTime];
    
    NSDictionary *parame = @{@"courseId":self.model.courseId,
                             @"studyTime":studyTime
                             };    
    WeakSelf
    [XTMainViewModel saveCoursewareDateSuccess:parame success:^(NSDictionary * _Nonnull result) {
        [weakSelf showStatus:@"保存成功"];
    }];
    
}

- (void)initUI {
    self.title = @"课件";
    
    self.webView = [[WKWebView alloc]init];
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.linkUrl]]];
    
    _datebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _datebtn.frame = CGRectMake(0, 0, 60, 44);
    _datebtn.titleLabel.font = kFont(12);
    [_datebtn setTitleColor:[UIColor blackColor] forState:0];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_datebtn];;
}

- (void)startTimer {
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(play) userInfo:nil repeats:YES];
//    [_timer fire];
}




- (void)play {
    
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
