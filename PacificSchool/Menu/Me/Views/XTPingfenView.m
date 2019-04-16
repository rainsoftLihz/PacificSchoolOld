//
//  XTPingfenView.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/16.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "XTPingfenView.h"
@interface XTPingfenView()<PCStarRatingDelegate>
@property(nonatomic,strong) UILabel* scoreLab;
@end
@implementation XTPingfenView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
        [self setupUI];
        [self addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)setupUI{
    UIView* bkView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-230, kScreenW, 230)];
    bkView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bkView];
    
    [bkView addSubview:self.starView];
    
    self.starView.frame = CGRectMake(kScreenW/2.0-_starView.imageWidth * 5/2.0,  200/2.0-_starView.imageHeight/2.0,_starView.imageWidth * 5, _starView.imageHeight);
    
    self.scoreLab = [[UILabel alloc] init];
    self.scoreLab.textColor = [UIColor blackColor];
    self.scoreLab.font = [UIFont boldSystemFontOfSize:18.0];
    self.scoreLab.textAlignment = NSTextAlignmentCenter;
    [bkView addSubview:self.scoreLab];
    [self.scoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bkView);
        make.bottom.mas_equalTo(self.starView.mas_top).offset(-5.0);
    }];
    
    UIButton* submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    submitBtn.backgroundColor = UIColor.greenColor;
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    [bkView addSubview:submitBtn];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 30.0/2;
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bkView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100.0, 30.0));
        make.bottom.mas_equalTo(bkView.mas_bottom).offset(-18.0);
    }];
    
    
    UILabel* pLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    pLab.text = @"评分";
    pLab.textAlignment = NSTextAlignmentCenter;
    pLab.textColor = [UIColor blackColor];
    pLab.font = [UIFont boldSystemFontOfSize:16.0];
    [bkView addSubview:pLab];
    
    UIButton* xBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [xBtn setTitle:@"取消" forState:UIControlStateNormal];
    xBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    [xBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [xBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [bkView addSubview:xBtn];
    [xBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(pLab);
        make.size.equalTo(pLab);
        make.right.mas_equalTo(bkView);
    }];
}

-(void)cancel{
    //取消
    [self removeFromSuperview];
}

-(PCStarRatingView *)starView{
    if (_starView == nil) {
        _starView = [[PCStarRatingView alloc] init];
        _starView.backgroundColor = [UIColor whiteColor];
        _starView.tag = 100;
        _starView.imageWidth = 24.0;
        _starView.imageHeight = 22.0;
        _starView.imageCount = 5;
        _starView.isNeedHalf = YES;
        _starView.delegate = self;
    }
    return _starView;
}

- (void)mannerGrade:(NSString *)grade withView:(UIView *)starView{
    self.scoreLab.text = [NSString stringWithFormat:@"%@分",grade] ;
}


@end
