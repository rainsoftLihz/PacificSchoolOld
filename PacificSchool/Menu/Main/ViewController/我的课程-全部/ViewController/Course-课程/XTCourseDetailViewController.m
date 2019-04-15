//
//  XTCourseDetailViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCourseDetailViewController.h"
#import "XTMyCourseModel.h"
#import "XTElnMapJobListModel.h"
#import "XTElnMapUserModel.h"
#import "LTTools.h"
#import "XTMainViewModel.h"
#import "XTCourseDetailModel.h"
#import "XTCoursewareViewController.h"
#import <AVKit/AVKit.h>
#import "LTNetWorkManager.h"
#import "XTCourseExamModel.h"
#import "LSDateTool.h"
//#import "XTCustomsPassViewController.h"
#import "XTSceneExerciseViewController.h"

@interface XTCourseDetailViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) XTCourseDetailModel *model;
@property(nonatomic,strong)AVAudioPlayer *player;
@end

@implementation XTCourseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    
}

- (void)initData {
    
    NSDictionary *param = @{@"mapId":self.mapId};
     WeakSelf
    [XTMainViewModel getCourseDetailSuccess:param success:^(XTCourseDetailModel * _Nonnull result) {
        weakSelf.model = result;
        [weakSelf initUI];
        [weakSelf.tableView reloadData];
    }];
    
}

- (void)initUI {
 
    self.title = @"课程详情";
    self.tableView.tableFooterView = [UIView new ];
    float height =[LTTools rectWidthAndHeightWithStr:[NSString stringWithFormat:@"   课程简介:%@",self.model.elnMap.summary] AndFont:12 WithStrWidth:kScreenW- 16];
    if (height<40) {
        height = 40;
    }
    float countHeight = 120 + 30 + 44 + 16 + height;
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, countHeight)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor whiteColor];

    NSString *urlString = [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,self.model.elnMap.coverImg];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    [headView addSubview:imageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = [NSString stringWithFormat:@"   %@",self.model.elnMap.mapTitle];
    titleLabel.font = [UIFont systemFontOfSize:17 weight:40];
    titleLabel.backgroundColor = [UIColor whiteColor];

    [headView addSubview:titleLabel];
    
    UILabel *detailLabel = [UILabel new];
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.numberOfLines = 0;
    if (self.model.elnMap.summary == nil) {
        self.model.elnMap.summary = @"";
    }
    detailLabel.text = [NSString stringWithFormat:@"   课程简介:%@",self.model.elnMap.summary];
    detailLabel.textColor = [UIColor grayColor];
    detailLabel.backgroundColor = [UIColor whiteColor];
    [headView addSubview:detailLabel];
    
    UILabel *proLabel = [UILabel new];
    proLabel.font = [UIFont systemFontOfSize:15];
    if (self.model.elnMap.jobCountComplete == nil) {
        self.model.elnMap.jobCountComplete = @"0";
    }if (self.model.elnMap.jobCountTotal == nil) {
        self.model.elnMap.jobCountTotal = @"0";

    }
    proLabel.text = [NSString stringWithFormat:@"   完成进度%@/%@",self.model.elnMap.jobCountComplete,self.model.elnMap.jobCount];
    proLabel.textColor = [UIColor darkGrayColor];
    proLabel.backgroundColor = [UIColor whiteColor];
    [headView addSubview:proLabel];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(headView);
        make.height.mas_equalTo(120);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(0);
        make.right.equalTo(imageView).offset(0);
        make.top.equalTo(imageView.mas_bottom);
        make.height.mas_equalTo(height);
    }];
    
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel).offset(0);
        make.right.equalTo(titleLabel).offset(0);
        make.top.equalTo(titleLabel.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    [proLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(0);
        make.right.equalTo(headView).offset(0);
        make.height.mas_equalTo(44);
        make.top.equalTo(detailLabel.mas_bottom).offset(8);
    }];
    
    self.tableView.tableHeaderView = headView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    UIButton *examBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [examBtn setTitle:@"通关考" forState:0];
    examBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    examBtn.backgroundColor = kMainColor;
    [bottomView addSubview:examBtn];
    
    [examBtn addTarget:self action:@selector(examEventBtn:) forControlEvents:UIControlEventTouchUpInside];
    [examBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).offset(40);
        make.right.equalTo(bottomView).offset(-40);
        make.top.equalTo(bottomView).offset(8);
        make.bottom.equalTo(bottomView).offset(-8);
    }];
    
    self.tableView.tableFooterView = bottomView;

    
}

- (void)examEventBtn:(UIButton *)btn {
    
    NSLog(@"考试");
//    NSDictionary *encrypt = [self getEncrypt];
    NSMutableDictionary *allParam = [[NSMutableDictionary alloc]init];
    
    NSString *userid = DEF_PERSISTENT_GET_OBJECT(kUserId);
    NSString *username = DEF_PERSISTENT_GET_OBJECT(kUserName);

    if (self.model.aiExamJobList.count==0) {
        return;
    }
    XTCourseExamModel *model = self.model.aiExamJobList[0];

    
    [allParam setObject:@[
                          @{@"agentId":userid,
                            @"agentName":username
                            
                            }] forKey:@"agentList"];
    [allParam setObject:model.objectId forKey:@"examId"];
    [allParam setObject:model.objectTitle forKey:@"examName"];
    
    
    [allParam setObject:[LSDateTool getUTCStrFormateLocalStr:[LSDateTool get_currentStringDateValue]] forKey:@"startTime"];
    
    NSLog(@"参数 %@",allParam);
    
    [XTMainViewModel getTokenWithParam:allParam success:^(NSDictionary * _Nonnull result) {
    
        XTSceneExerciseViewController *vc = [XTSceneExerciseViewController new];
        vc.examId = result[@"id"];
        vc.examTitle = allParam[@"examName"];
        vc.webType = XTWebExamType;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }];
    
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.normalJobList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    XTElnMapJobListModel *model = self.model.normalJobList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row + 1,model.objectTitle];
    NSLog(@" =========== %@",self.model.normalJobList[indexPath.row]);
    cell.textLabel.font = [UIFont systemFontOfSize:15 weight:40];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTCoursewareViewController *vc = [XTCoursewareViewController new];
    XTElnMapJobListModel *model = self.model.normalJobList[indexPath.row];
    vc.mapModel = model;
    [self.navigationController pushViewController:vc animated:YES];
    
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
