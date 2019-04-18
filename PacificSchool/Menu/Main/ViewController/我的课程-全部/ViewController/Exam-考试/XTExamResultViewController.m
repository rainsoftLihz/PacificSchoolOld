//
//  XTExamResultViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/17.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTExamResultViewController.h"
#import "XTMainViewModel.h"
#import "LQRadarChart.h"
#import "XTAiExamUserDetailModel.h"

@interface XTExamResultViewController ()
<
    LQRadarChartDataSource,
    LQRadarChartDelegate
>
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (nonatomic,strong)NSMutableArray *socres;
@property (nonatomic,strong)NSMutableArray *titles;

@property (nonatomic,strong)XTAiExamUserDetailModel *model;
@property (nonatomic,assign)int requestNumber;
@end

@implementation XTExamResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.closeBtn.backgroundColor = kMainColor;
    
    [SVProgressHUD show];
    
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getExamResult];
    //});

    [self initData];
    [self initUI];
}

- (void)initData {
    _requestNumber = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].idleTimerDisabled = NO;

}

- (void)initUI {
 
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    self.scoreLabel.layer.cornerRadius = 25/2;
    self.scoreLabel.layer.masksToBounds = YES;
    self.scoreLabel.backgroundColor = [UIColor colorWithRed:48/255.f green:79/255.f blue:109./255.f alpha:0.6];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (IBAction)closeEventBtn:(id)sender {
    
    NSArray *pushVCAry=[self.navigationController viewControllers];
    //下面的 pushVCAry.count - 3  是为了  跨越两层返回
    UIViewController *popVC=[pushVCAry objectAtIndex:pushVCAry.count-3];
    [self.navigationController popToViewController:popVC animated:YES];
}

- (void)getExamResult {
    
    NSDictionary *param = @{@"detailId":self.detailId,
                            @"objectType":@"aiExam"
                            };
    NSLog(@"考试结果参数名 %@",param);
    
    WeakSelf
    [XTMainViewModel getExamDetailSuccess:param success:^(NSDictionary * _Nonnull result) {
       weakSelf.model = [XTAiExamUserDetailModel mj_objectWithKeyValues:result];
        NSLog(@"考试结果 %@",result);
        NSArray *resultAry = result[@"data"][@"evaluateUserCategoryList"];
        if (!weakSelf.model.detailId) {
             weakSelf.requestNumber = weakSelf.requestNumber + 1;
//            if (weakSelf.requestNumber < 3) {
//                NSLog(@"考试结果次数 %d",weakSelf.requestNumber);
//
                [weakSelf getExamResult];
//            }
            
        }else {
            [weakSelf configRadarMap:weakSelf.model];
        }
        
    }];
}


- (void)configRadarMap:(XTAiExamUserDetailModel *)result {
    
    self.titles = [NSMutableArray array];
    self.socres = [NSMutableArray array];
    
    int score = [result.score intValue];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"总分:%d",score];
    
    self.rankLabel.text = [NSString stringWithFormat:@"%d",[result.rankNo intValue]];
    
    
    // 声纹核身
    NSDictionary *resultdic = [result.voiceAuthResult mj_JSONObject];
    if ([resultdic[@"score"] floatValue] >= 0.01 ) {
        self.voiceResultLabel.text = @"通过";
    }else {
        self.voiceResultLabel.text = @"未通过";
    }
    NSLog(@" 声纹核身分数 == %f",[resultdic[@"score"] floatValue]);
    
    // 结果评估
    if (score >= (80) && score <= (90)) {
        
        // 大于 80 小于 90
        self.resultLabel.text = @"良好";
        
    }else if (score > (60) && score < (80) ){
        
        // 大于 60 小于 80
        self.resultLabel.text = @"合格";
        
    }else if (score >= 0 && score < (60) ){
        
        // 大于 0 小于 60
        self.resultLabel.text = @"不合格";
        
    }else{
        
        // 大于90
        self.resultLabel.text = @"优秀";

    }
    
    // 排名
    NSDictionary *dic = [result.scoreDetail mj_JSONObject];
    NSArray *categoryList = dic[@"categoryList"];
    
    
    for (NSDictionary *dic in categoryList ) {
        
        NSString *title = dic[@"categoryName"];
        float totalScore = [dic[@"categoryTotalScore"] floatValue];
        float getScore = [dic[@"categoryGetScore"] floatValue];
        
        float userscore = getScore/totalScore *100;
        NSString *scoreS = [NSString stringWithFormat:@"%.2f",userscore];
        NSLog(@"userscore %@",scoreS);

        [self.titles addObject:title];
        [self.socres addObject:scoreS];
    }
    
    CGFloat w = 180;
    LQRadarChart * chart = [[LQRadarChart alloc]initWithFrame:CGRectMake(120, 50, 230, w)];
    chart.radius = w / 3;
    chart.delegate = self;
    chart.dataSource = self;
    chart.maxValue = 100;
    chart.minValue = 1;
    [chart reloadData];
    chart.backgroundColor = [UIColor clearColor];
    [_headView addSubview:chart];
    
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
    return [UIColor whiteColor];
    
}
- (UIColor *)colorOfLineForRadarChart:(LQRadarChart *)radarChart
{
    return [UIColor whiteColor];
    
}
- (UIColor *)colorOfFillStepForRadarChart:(LQRadarChart *)radarChart step:(NSInteger)step
{
    UIColor * color = [UIColor clearColor];
    switch (step) {
        case 1:
            color = [UIColor clearColor];
            break;
        case 2:
            color = [UIColor clearColor];
            break;
        case 3:
            color = [UIColor clearColor];
            break;
        case 4:
            color = [UIColor clearColor];
            break;
            
        default:
            break;
    }
    return color;
}
- (UIColor *)colorOfSectionFillForRadarChart:(LQRadarChart *)radarChart section:(NSInteger)section
{
    if (section == 0) {
        return [UIColor colorWithRed:25/255.f green:126/255.f blue:210/255.f alpha:0.5];
    }else{
        return [UIColor colorWithRed:25/255.f green:100/255.f blue:210/255.f alpha:0.5];
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
    return [UIFont systemFontOfSize:12];
    
}

//    if ([resultdic[@"status"] isEqualToString:@"1"]) {
//        self.voiceResultLabel.text = @"是本人";
//
//    }else if ([resultdic[@"status"] isEqualToString:@"0"]){
//
//        NSString *code = resultdic[@"code"];
//
//        if ([code isEqualToString:@"VP1002"]) {
//
//            self.voiceResultLabel.text = @"服务异常";
//
//        }else if ([code isEqualToString:@"VP1003"]){
//
//            self.voiceResultLabel.text = @"不是本人";
//
//        }else if ([code isEqualToString:@"VP1004"]){
//
//            self.voiceResultLabel.text = @"服务异常";
//
//        }else if ([code isEqualToString:@"VP1005"]){
//
//            self.voiceResultLabel.text = @"服务异常";
//
//        }
//
//
//    }
//


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
