//
//  XTMainViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMainViewController.h"
#import "XTMainHeadView.h"
#import "UIView+Gradient.h"
#import "XTMainViewModel.h"
#import "XTPunchCardViewController.h"
#import "XTMainFootView.h"
#import "XTMainTableViewCell.h"
#import "XTElnTableViewCell.h"
#import "XTCourseModel.h"
#import "XTElnMapListModel.h"
#import "XTMyCourseListViewController.h"
#import "XTHotCourseViewController.h"
#import "XTCourseDetailViewController.h"
#import "XTSceneExerciseViewController.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
@interface XTMainViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    XTMainTableViewCellDelegate,
    XTElnTableViewCellDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *sectionTitles;
@property (nonatomic,strong)NSArray *elnMapListRecommend;
@property (nonatomic,strong)NSArray *elnMapListHot;
@property (nonatomic,strong)NSArray *elnMapList;


@property (nonatomic,strong)XTMainHeadView *mainView;

@end

@implementation XTMainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getMainData];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //AutoLayout布局完成时，在进行添加，否则frame错误
    [_mainView addGradientColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initUI];
}

- (void)initData {
    
    self.sectionTitles = @[@"我的课程",@"热门课程",@"智能推荐课程"];
    
    self.elnMapListHot = [NSArray array];
    self.elnMapListRecommend = [NSArray array];
    self.elnMapList = [NSArray array];
}

- (void)initUI {
 
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.tableFooterView = [UIView new];
    
    _mainView = [[XTMainHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 250)];
    _mainView.backgroundColor = [UIColor darkGrayColor];
    WeakSelf
    _mainView.blockEvent = ^{
        
        XTPunchCardViewController *vc = [XTPunchCardViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [self.view addSubview:_mainView];
    self.tableView.tableHeaderView = _mainView;
    [self.tableView registerNib:[UINib nibWithNibName:@"XTMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XTElnTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
}



- (void)getMainData {
    
    WeakSelf
    [XTMainViewModel postMainDataSuccess:^(NSDictionary * _Nonnull result) {
        
        weakSelf.elnMapList = [XTElnMapListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"elnMapList"]];
        weakSelf.elnMapListRecommend  = [XTElnMapListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"elnMapListRecommend"]];
        weakSelf.elnMapListHot  = [XTElnMapListModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"elnMapListHot"]];
        [weakSelf.tableView reloadData];
        
        [weakSelf configHeadUIData:result[@"data"]];
    }];
    
}

- (void)configHeadUIData:(NSDictionary *)dic  {
    
    // 累计天数
    [_mainView loadData:dic];
    int time = [dic[@"hasStudyTime"] intValue];
    NSString *isSigned = dic[@"isSigned"];
    
    if ([isSigned isEqualToString:@"N"] && (time>=5)) {
         [self sign];
    }
}

- (void)sign {
 
    [XTMainViewModel getSaveSign:^(NSDictionary * _Nonnull result) {
        NSLog(@"打卡 %@",result);
    
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.elnMapList.count>0) {
            return 1;
        }return 0;
    }else if(section ==1 ){
        if (self.elnMapListHot.count>0) {
            return 1;
        }return 0;
    }else {
        if (self.elnMapListRecommend.count>0) {
            return 1;
        }return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        XTMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.delegate = self;
        [cell loadModels:self.elnMapList];
        return cell;
    }else if (indexPath.section == 1){
        XTElnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        [cell loadModels:self.elnMapListHot];
        cell.delegate = self;
        return cell;
    }else {
        XTElnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        [cell loadModels:self.elnMapListRecommend];
        cell.delegate = self;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    headerView.backgroundColor = kColorRGB(242, 242, 242);
    headerView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenW - 80, 30)];
    titleLabel.font = kFont(15);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = [NSString stringWithFormat:@"%@ ",self.sectionTitles[section]];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    //    titleLabel.backgroundColor = [UIColor colorMain];
    [headerView addSubview:titleLabel];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"查看全部 >" forState:0];
    [btn setTitleColor:[UIColor grayColor] forState:0];
    btn.titleLabel.font = kFont(13);
    btn.tag = section;
    [btn addTarget:self action:@selector(lookAll:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView).offset(-8);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
        make.centerY.equalTo(headerView.mas_centerY);
    }];
    
    return headerView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    XTMainFootView *footView = [[[NSBundle mainBundle] loadNibNamed:@"XTMainFootView" owner:self options:nil]lastObject];
    footView.headView.layer.cornerRadius = 25;
    footView.headView.layer.masksToBounds = 25;
    footView.frame = CGRectMake(0, 0, kScreenW, 150);
    [footView.sceneBtn addTarget:self action:@selector(gotoScene) forControlEvents:UIControlEventTouchUpInside];
    [footView.dayCourseBtn addTarget:self action:@selector(gotoDayCource) forControlEvents:UIControlEventTouchUpInside];
    [footView.dayCourseBtn setTitle:@"每日一课" forState:UIControlStateNormal];
    return footView;
}

-(void)gotoDayCource{
//    XTWebViewController* vc = [XTWebViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110;
    }else{
        return 120;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 150;
    }
    return 0;
        
}

- (void)selelctedCourseWithIndex:(XTMainTableViewCell *)cell model:(XTElnMapListModel *)model {
    
    XTCourseDetailViewController *vc = [XTCourseDetailViewController new];
    vc.mapId = model.mapId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selelctedCourseWithElnTableViewCell:(XTElnTableViewCell *)cell model:(XTElnMapListModel *)model {
    XTCourseDetailViewController *vc = [[XTCourseDetailViewController alloc] init];
    vc.mapId = model.mapId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)lookAll:(UIButton *)btn {
    
    if (btn.tag == 0) {
        
        XTMyCourseListViewController *vc = [XTMyCourseListViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (btn.tag == 1){
        XTHotCourseViewController *vc = [XTHotCourseViewController new];
        vc.courseType = XTHotCourseType;
        vc.title = @"热门课程";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        XTHotCourseViewController *vc = [XTHotCourseViewController new];
        vc.courseType = XTRecommendCourseType;
        vc.title = @"智能推荐课程";
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)gotoScene {
    
    XTSceneExerciseViewController *vc = [XTSceneExerciseViewController new];
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
