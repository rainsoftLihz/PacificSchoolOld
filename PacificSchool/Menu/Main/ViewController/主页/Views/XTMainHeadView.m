//
//  XTMainHeadView.m
//  弧形进度条
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 zhou. All rights reserved.
//

#import "XTMainHeadView.h"
#import "XTProgressView.h"

@interface XTMainHeadView ()
@property(nonatomic,strong) XTProgressView *progressView;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong)UILabel *countTimeLabel;

@property(nonatomic,strong)UILabel *punchCardLabel;
@property(nonatomic,strong)UILabel *getNumberLabel;
@property(nonatomic,strong)UILabel *titllLabel;
@end
@implementation XTMainHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData {
    
}

- (void)loadData:(NSDictionary *)dic {
    
    NSString *signTotalCount = dic[@"signTotalCount"];
    NSString *totalCoin = dic[@"totalCoin"];
    NSString *hasStudyTime = dic[@"hasStudyTime"];
    // NSString *isSigned = dic[@"isSigned"];
    
    NSString *aimStudyTime = dic[@"aimStudyTime"];
    
    _countTimeLabel.text = [NSString stringWithFormat:@"学习目标时长%@分钟",aimStudyTime];
    _titllLabel.text = [NSString stringWithFormat:@"%@",hasStudyTime];
    _punchCardLabel.text = [NSString stringWithFormat:@"%@\n累计打卡",signTotalCount];
    _getNumberLabel.text = [NSString stringWithFormat:@"%@\n已获学豆",totalCoin];
    
    NSLog(@" num %f countnum %d 学习时长 %@",[hasStudyTime floatValue],[aimStudyTime intValue],_timeLabel.text);
    
    _progressView = [[XTProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 150)];
    
    _progressView.backgroundColor = [UIColor clearColor];
    [self addSubview:_progressView];
    float time = [hasStudyTime floatValue];
    if (time>5) {
        time = 5;
    }
    _progressView.num = time;
    _progressView.countNum = [aimStudyTime intValue];
    
}

- (void)initUI {
    
    _titllLabel = [[UILabel alloc]init];
    [self addSubview:_titllLabel];
    _titllLabel.textAlignment = NSTextAlignmentCenter;
    _titllLabel.font = [UIFont systemFontOfSize:17];

    _titllLabel.textColor = [UIColor groupTableViewBackgroundColor];
    [_titllLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(60);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
        
    }];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.hidden = YES;
    [self addSubview:_timeLabel];
    _timeLabel.text = @"0";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.font = [UIFont systemFontOfSize:17];
    _timeLabel.textColor = [UIColor whiteColor];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titllLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(30);

    }];
    
    _countTimeLabel = [[UILabel alloc]init];
    [self addSubview:_countTimeLabel];
    _countTimeLabel.textAlignment = NSTextAlignmentCenter;
    _countTimeLabel.font = [UIFont systemFontOfSize:17];
    _countTimeLabel.textColor = [UIColor whiteColor];
    [_countTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_timeLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
        
    }];
    
    
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signBtn setTitle:@"打卡" forState:0];
    signBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [signBtn addTarget:self action:@selector(signBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:signBtn];
    
    signBtn.layer.cornerRadius = 14;
    signBtn.layer.masksToBounds = YES;
    signBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    signBtn.layer.borderWidth = 1;
    
    [signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_countTimeLabel.mas_bottom).offset(8);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    _punchCardLabel = [UILabel new];
    
    _punchCardLabel.textAlignment = NSTextAlignmentCenter;
    _punchCardLabel.font = [UIFont systemFontOfSize:14];
    _punchCardLabel.textColor = [UIColor grayColor];
    _punchCardLabel.numberOfLines = 0;
    [bottomView addSubview:_punchCardLabel];
    
    _getNumberLabel = [UILabel new];
    _getNumberLabel.textAlignment = NSTextAlignmentCenter;
    _getNumberLabel.font = [UIFont systemFontOfSize:14];
    _getNumberLabel.textColor = [UIColor grayColor];
    _getNumberLabel.numberOfLines = 0;
    [bottomView addSubview:_getNumberLabel];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(50);
        make.top.equalTo(signBtn.mas_bottom).offset(3);
    }];
    
    [bottomView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [bottomView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        
    }];
    
}

- (void)signBtnEvent:(UIButton *)btn {
    if (self.blockEvent) {
        self.blockEvent();
    };
}


@end
