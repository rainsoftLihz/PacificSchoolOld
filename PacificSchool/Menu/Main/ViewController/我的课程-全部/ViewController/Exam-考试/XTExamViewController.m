//
//  XTExamViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTExamViewController.h"
#import "XTExamView.h"
#import "XTExamItemListModel.h"
#import "XTCoursewareDetailModel.h"

#define kViewHeight 358

@interface XTExamViewController ()
@property (nonatomic,strong) UIScrollView *scorllView;
@end

@implementation XTExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initUI];
    
}

- (void)initData {
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void)initUI {
        
    self.title = @"随堂练";
    
    _scorllView = [[UIScrollView alloc]init];
    _scorllView.backgroundColor = [UIColor whiteColor];
    _scorllView.pagingEnabled = NO;
    _scorllView.scrollEnabled = YES;
    _scorllView.bouncesZoom = NO;
    _scorllView.alwaysBounceHorizontal = YES;
    _scorllView.alwaysBounceVertical = NO;
    [self.view addSubview:_scorllView];
    _scorllView.frame = CGRectMake(0, 0, kScreenW, kScreenH );
    NSLog(@"位置 %@",NSStringFromCGRect(_scorllView.frame));
//    [_scorllView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(self.view);
//    }];
    
    for (int i = 0;i < self.model.examItemList.count ; i++ ) {
     
        XTExamItemListModel *submodel = self.model.examItemList[i];
        submodel.index = [NSString stringWithFormat:@"%d",i+1];
        submodel.questionCount = self.model.examItemList.count;
        NSLog(@"submodel.index == %@",submodel.index);
        
        XTExamView *examView = [XTExamView new];
//        submodel.itemTitle = @"indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel.indexsubmodel";
        examView.model = submodel;
        examView.frame = CGRectMake(i*kScreenW, 0, kScreenW, kScreenH-64);
        [_scorllView addSubview:examView];
        __weak typeof(self)wkSelf = self;
        examView.block = ^(NSInteger index) {
            if (index == wkSelf.model.examItemList.count) {
                [wkSelf commitAnswer];
            }else {
                [wkSelf.scorllView setContentOffset:CGPointMake((index) * kScreenW,0) animated:YES];
                NSLog(@"位置2 %@",NSStringFromCGRect(wkSelf.scorllView.frame));
            }

        };
        
        float height = [LTTools rectWidthAndHeightWithStr:submodel.itemTitle AndFont:15 WithStrWidth:kScreenW-16];
        
        if (height<40) {
            height = 40;
        }
       float viewHeight = height + kViewHeight + 64;
        
        NSLog(@"height %f",viewHeight);
        // 计算高度
        _scorllView.contentSize = CGSizeMake(kScreenW *self.model.examItemList.count, viewHeight);

        NSLog(@"heightSize %@",NSStringFromCGSize(_scorllView.contentSize));

    }
}

- (void)commitAnswer {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认提交吗" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [controller addAction:actionCancel];
    
    UIAlertAction *actionDone = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [controller addAction:actionDone];
    
    [self presentViewController:controller animated:YES completion:^{
        
    }];
    
}

- (void)dealloc {
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;

    NSLog(@"dealloc ==--->%@",self);
    
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
