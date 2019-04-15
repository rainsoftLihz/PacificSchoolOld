//
//  XTVideoViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTVideoViewController.h"
#import "ZFPlayer.h"
#import "XTCoursewareDetailModel.h"
#import "XTCommonAttachmentListModel.h"
#import "XTMainViewModel.h"
#import "XTCourseModel.h"

@interface XTVideoViewController ()
<
    ZFPlayerDelegate
>
@property (nonatomic, assign) NSTimeInterval starTime;  ///< 开始时间
@property (nonatomic, assign) NSTimeInterval finishTime;///< 结束时间


@property (nonatomic,strong)ZFPlayerModel *playerModel;
@property (nonatomic,strong)ZFPlayerView *playerView;

//@property (nonatomic, strong) ZFPlayerController *player;
//@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation XTVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initUI];
}

- (void)initData {
    
    _starTime = [[NSDate date] timeIntervalSince1970];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self beginSaveLearnTracking];
    
}

- (void)initUI {
 

    _playerModel = [[ZFPlayerModel alloc] init];
    _playerModel.title = self.title;
    
    //本地播放
    
    NSString *url = @"";
    if (self.model.commonAttachmentList.count>0) {
        XTCommonAttachmentListModel *model = self.model.commonAttachmentList[0];
        url = [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,model.filePath];
        self.title = model.fileOriginalName;
    }
    
    _playerModel.videoURL = [NSURL URLWithString:url];
    
    //    _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
    _playerModel.fatherView = self.view;
    _starTime = [[NSDate date] timeIntervalSince1970];
    
    
    _playerView = [ZFPlayerView sharedPlayerView];
    [_playerView playerControlView:nil playerModel:_playerModel];
    
    // 设置代理
    _playerView.delegate = self;
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    // _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
    // 打开下载功能（默认没有这个功能）
    _playerView.hasDownload = NO;
    // 打开预览图
    _playerView.hasPreviewView = NO;
    //    [_playerView autoPlayTheVideo];
    [_playerView autoPlayTheVideo];
    
    [self.view addSubview:self.playerView];
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        // 这里宽高比16：9，可以自定义视频宽高比
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    
}

#pragma mark - ZFPlayerDelegate
- (void)zf_playerBackAction {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate {
    return NO;
}

// 支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

// 页面展示的时候默认屏幕方向（当前ViewController必须是通过模态ViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)dealloc {
    
    [_playerView resetPlayer];
    [self.playerView pause];
    self.playerView = nil;
    NSLog(@"播放视频退出");
}

#pragma mark - 开始保存学习时间
- (void)beginSaveLearnTracking {
    
    _finishTime = [[NSDate date] timeIntervalSince1970];
    [self saveQeustionLearning];
    
}

- (void)saveQeustionLearning {
    
    int countTime = (int)_finishTime-_starTime;
    NSString *studyTime = [NSString stringWithFormat:@"%d",countTime];
    
    NSDictionary *parame = @{@"courseId":self.model.elnCourse.courseId,
                             @"studyTime":studyTime
                             };
    WeakSelf
    [XTMainViewModel saveCoursewareDateSuccess:parame success:^(NSDictionary * _Nonnull result) {
        [weakSelf showStatus:@"保存成功"];
    }];
    
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
