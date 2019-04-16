//
//  XTMeViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/24.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMeViewController.h"
#import "XTMeHeadView.h"
#import "XTMeSubTableViewCell.h"
#import "XTMeTableViewCell.h"
#import "XTSettingViewController.h"
#import "UIView+Gradient.h"
#import "XTMeSubTableViewCell.h"
#import "XTRankViewController.h"
#import "XTCompleteCourseViewController.h"
#import "XTMainViewModel.h"
#import "SpiderWebView.h"
#import "LQRadarChart.h"
#import "XTHistoryViewController.h"

@interface XTMeViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    LQRadarChartDataSource,
    LQRadarChartDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *models;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,strong)XTMeHeadView *headView;
@property (nonatomic,strong)NSMutableArray *socres;
@property (nonatomic,strong)NSMutableArray *titles;
@property (nonatomic,assign)NSInteger rankNo;
@end

@implementation XTMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}


- (void)initData {
    
    self.models = @[@[@"智能测评"],@[@"通关考历史记录",@"已完成的课程"],@[@"我的积分",@"消息中心"],@[@"关于智学院"]];
    self.images = @[@[@"intelligence_testing"],@[@"examination_record",@"complete_course"],@[@"integral",@"msg_center"],@[@"test_Histroy"]];
    self.titles = [NSMutableArray array];
    self.socres = [NSMutableArray array];
    
     __weak typeof(self) __weakSelf = self;
    [XTMainViewModel getUserCPIC:^(NSDictionary * _Nonnull result) {
        NSLog(@"result==== %@",result);
        
        [__weakSelf configRadarMap:result[@"data"][@"evaluateUserCategoryList"]];
        
    }];
    
    [XTMainViewModel getDetail:^(NSDictionary * _Nonnull result) {
        // 本次排名
        NSString *rankNo = [NSString stringWithFormat:@"%@",result[@"data"][@"frontUserStatistics"][@"rankNo"]];
        
        NSLog(@" 本次排名 %@",result);
        if ([rankNo isEqual:[NSNull null]] || rankNo == nil) {
            rankNo = @"0";
        }
        // 综合排名
        NSString *rankScore = [NSString stringWithFormat:@"%@",result[@"data"][@"frontUserStatistics"][@"rankScore"]];
        NSLog(@" 综合排名 %@",[rankScore class]);

        if ([rankScore isEqual:[NSNull null]] || rankScore == nil|| [rankScore isEqualToString:@"(null)"]) {
            rankScore = @"0";
        }
        // 上次排名
        NSString *rankNoPre = [NSString stringWithFormat:@"%@",result[@"data"][@"frontUserStatistics"][@"rankNoPre"]];
        if ([rankNoPre isEqual:[NSNull null]] || rankNoPre == nil) {
            rankNoPre = @"0";
        }
        __weakSelf.headView.rankLabel.text = rankNo;
        
        __weakSelf.rankNo = rankNo.integerValue;
        
        __weakSelf.headView.scoreLabel.text = rankScore;
        NSLog(@" === %@ === %@",[rankNo class],rankScore);
        
        if ([rankNoPre intValue] > [rankNo intValue]) {
            // 下降
            __weakSelf.headView.netImageView.image = [UIImage imageNamed:@"down.jpg"];
            
        }else if([rankNoPre intValue] == [rankNo intValue]) {
            
            // 等于
            __weakSelf.headView.netImageView.image = [UIImage imageNamed:@"equal.jpg"];
            
        }else {
            // 排名
            __weakSelf.headView.netImageView.image = [UIImage imageNamed:@"rank"];
        }
        
    }];
}

- (void)configRadarMap:(NSArray *)result {
    
    
    for (NSDictionary *dic in result ) {

        NSString *title = dic[@"categoryTitle"];
        float score = [dic[@"getScore"] floatValue];
        float totalScore = [dic[@"totalScore"] floatValue];
        if (score == 0) {
            score = 50;
        }
        float rank = score / totalScore * 100;
        NSString *scoreS = [NSString stringWithFormat:@"%.2f",rank];
        NSLog(@" 分数 == %.2f == %.2f== %.2f",rank,score,totalScore);
        [self.titles addObject:title];
        [self.socres addObject:scoreS];
    }
    
    CGFloat w = 100;
    LQRadarChart * chart = [[LQRadarChart alloc]initWithFrame:CGRectMake(0, 0, w, w)];
    chart.radius = w / 3;
    chart.delegate = self;
    chart.dataSource = self;
    chart.maxValue = 100;
    chart.minValue = 1;
    chart.showPoint=NO;
    [chart reloadData];
    [_headView.dadar addSubview:chart];

}

- (void)initUI {
    
    _headView = [[[NSBundle mainBundle] loadNibNamed:@"XTMeHeadView" owner:self options:nil]lastObject];
    _headView.frame = CGRectMake(0, 0, kScreenW, 350);
    _headView.bgView.layer.cornerRadius = 5;
    _headView.bgView.layer.masksToBounds = YES;
    
    _headView.headImageView.layer.cornerRadius = 30;
    _headView.headImageView.layer.masksToBounds = YES;
    
    [self updateHeadImage];

    _headView.nameLabel.text = DEF_PERSISTENT_GET_OBJECT(kNickName);

    
    _headView.accountLabel.text = [NSString stringWithFormat:@"P13账号:%@",DEF_PERSISTENT_GET_OBJECT(kUserName)];
    
    [_headView.rankButton addTarget:self action:@selector(heroEvent:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = _headView;
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XTMeSubTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.frame = CGRectMake(0, 0, 44, 44);
    [settingBtn setTitle:@"设置" forState:0];
    [settingBtn setTitleColor:[UIColor blackColor] forState:0];

    [settingBtn addTarget:self action:@selector(settingEvent) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:settingBtn];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self updateHeadImage];
}

- (void)updateHeadImage {
    
    NSString *imageUrl = DEF_PERSISTENT_GET_OBJECT(kHeadImgUrl);
    
    if (imageUrl.length==0) {
        imageUrl =  @"/uploads/cpic/default-head.jpg";
    }
    NSString *complete = [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,imageUrl];
    [_headView.headImageView sd_setImageWithURL:[NSURL URLWithString:complete] placeholderImage:[UIImage imageNamed:@"account_avatar"]];
    
}

#pragma mark - 英雄榜
- (void)heroEvent:(UIButton *)btn {
    
    XTRankViewController *rankVC = [XTRankViewController new];
    rankVC.rankNo = self.rankNo;
    [self.navigationController pushViewController:rankVC animated:YES];
    
}

- (void)settingEvent {
    
    [self.navigationController pushViewController:[XTSettingViewController new] animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *ary = self.models[section];
    return ary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     NSArray *images = self.images [indexPath.section];
    NSArray *titles = self.models[indexPath.section];

    if (indexPath.section == 0 && indexPath.row == 0) {
        
        XTMeSubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.headImageView.image = [UIImage imageNamed:images[indexPath.row]];
        cell.titleLabel.text = titles[indexPath.row];

        return cell;
    }else {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
        cell.textLabel.text = titles[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        
        if ((indexPath.section == 1 && indexPath.row == 1)||(indexPath.section == 1 && indexPath.row == 0)) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
        
    }
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view  =[UIView new];
    view.frame= CGRectMake(0, 0, kScreenW, 10);
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    }return 44;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        XTCompleteCourseViewController *vc = [XTCompleteCourseViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0){
        
        XTHistoryViewController *vc = [XTHistoryViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (NSInteger)numberOfStepForRadarChart:(LQRadarChart *)radarChart
{
    return 5;
}
- (NSInteger)numberOfRowForRadarChart:(LQRadarChart *)radarChart
{
    return self.titles.count;
}
- (NSInteger)numberOfSectionForRadarChart:(LQRadarChart *)radarChart
{
    return 2;
}
- (NSString *)titleOfRowForRadarChart:(LQRadarChart *)radarChart row:(NSInteger)row
{
    return self.titles[row];
}
- (CGFloat)valueOfSectionForRadarChart:(LQRadarChart *)radarChart row:(NSInteger)row section:(NSInteger)section
{
    return [_socres[row] intValue];
}

- (UIColor *)colorOfTitleForRadarChart:(LQRadarChart *)radarChart
{
    return [UIColor blackColor];
    
}
- (UIColor *)colorOfLineForRadarChart:(LQRadarChart *)radarChart
{
    return [UIColor grayColor];
    
}
- (UIColor *)colorOfFillStepForRadarChart:(LQRadarChart *)radarChart step:(NSInteger)step
{
    UIColor * color = [UIColor whiteColor];
    switch (step) {
        case 1:
            color = [UIColor whiteColor];
            break;
        case 2:
            color = [UIColor whiteColor];
            break;
        case 3:
            color = [UIColor whiteColor];
            break;
        case 4:
            color = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
    return color;
}
- (UIColor *)colorOfSectionFillForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
//        return [UIColor greenColor];
        return [UIColor colorWithRed:25/255.f green:126/255.f blue:210/255.f alpha:0.5];
    }else{
        return [UIColor colorWithRed:25/255.f green:100/255.f blue:210/255.f alpha:0.5];
//        return [UIColor groupTableViewBackgroundColor];
    }
}
- (UIColor *)colorOfSectionBorderForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
        return [UIColor yellowColor];
    }else{
        return [UIColor groupTableViewBackgroundColor];
    }
    
}
- (UIFont *)fontOfTitleForRadarChart:(LQRadarChart *)radarChart
{
    return [UIFont systemFontOfSize:6];
    
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
