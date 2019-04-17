//
//  XTPunchCardViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTPunchCardViewController.h"
#import "UIView+Gradient.h"
#import "XTMainViewModel.h"
#import "XTSignModel.h"
@interface XTPunchCardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *successBtn;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *signNumber;
@property (weak, nonatomic) IBOutlet UILabel *signNumber1;
@property (weak, nonatomic) IBOutlet UILabel *studentDateLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *myTotalCoinLabel;
@property (weak, nonatomic) IBOutlet UIButton *signImageView;

@end

@implementation XTPunchCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //AutoLayout布局完成时，在进行添加，否则frame错误
    [self.bgView addGradientColor];
}

- (void)initData {
    WeakSelf
    [SVProgressHUD show];
    [XTMainViewModel getSignDataSuccess:^(NSDictionary * _Nonnull result) {
        
        if (result[@"data"]) {
            XTSignModel* model = [XTSignModel mj_objectWithKeyValues:result[@"data"]];
            weakSelf.studentDateLabel.text = [NSString stringWithFormat:@"%@分钟",model.hasStudyTime?:@"0"];
            weakSelf.signNumber1.text = [NSString stringWithFormat:@"%@天",model.signContinueCount?:@"0"];
            weakSelf.signNumber.text = [NSString stringWithFormat:@"%@天",model.signTotalCount?:@"0"];
            
            
            NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:@"我的智慧豆:"];
            NSAttributedString *subString = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model.totalScore?:@"0"] attributes:@{NSForegroundColorAttributeName:[UIColor brownColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
            
            [allString appendAttributedString:subString];
            weakSelf.myTotalCoinLabel.attributedText = allString;
            NSString *isSigned = [NSString stringWithFormat:@"%@",model.isSigned];
            if ([isSigned isEqualToString:@"Y"]) {
                self.msgLabel.text = @"自动打卡成功";
                [self.signImageView setImage:[UIImage imageNamed:@"signinSuccess"] forState:0];
            }else  {
                self.msgLabel.text = @"自动打卡失败";
                [self.signImageView setImage:[UIImage imageNamed:@"signError.jpg"] forState:0];
                
            }
            
        }
        
    }];
}

- (NSString *)getCurrentDate_day {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *currentDateString = [formatter stringFromDate:date];
    return currentDateString;
    
}

- (void)initUI {
    
    self.title = @"签到";
    self.dateLabel.text = [self getCurrentDate_day];
    
//    [self.bgView  addGradientColor];
    
    
    

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
