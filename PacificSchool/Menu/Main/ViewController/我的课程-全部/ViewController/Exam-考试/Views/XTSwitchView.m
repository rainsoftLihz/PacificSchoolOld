//
//  XTSwitchView.m
//  CommentDemo
//
//  Created by Jonny on 2019/3/12.
//  Copyright © 2019 Nil. All rights reserved.
//

#import "XTSwitchView.h"
#import "Masonry.h"

@interface XTSwitchView ()
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;

@end

@implementation XTSwitchView

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

- (void)initUI {
    
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.frame = CGRectMake(0, 0, 0, 0);
    [_leftBtn setTitle:@"简介" forState:0];
    _leftBtn.tag = 0;
    [_leftBtn setTitleColor:[UIColor blackColor] forState:0];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_leftBtn addTarget:self action:@selector(leftEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 0, 0);
    [_rightBtn setTitle:@"评论" forState:0];
    _rightBtn.tag = 1;
    [_rightBtn setTitleColor:[UIColor blackColor] forState:0];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn addTarget:self action:@selector(rightEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_rightBtn];
    
    _bottomLine = [UIView new];
    _bottomLine.backgroundColor = kMainColor;
    [self addSubview:_bottomLine];
    
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.right.equalTo(self.rightBtn.mas_left);
        make.height.mas_equalTo(33);
        make.width.equalTo(self.rightBtn.mas_width);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.left.equalTo(self.leftBtn.mas_right);
        make.height.mas_equalTo(33);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftBtn);
        make.height.mas_equalTo(2);
        make.top.equalTo(self.leftBtn.mas_bottom).offset(-3);
        make.width.mas_equalTo(40);
        
    }];
}
//- (void)setIsShow:(BOOL)isShow {
//    _isShow = isShow;
//    if (_isShow) {
//        [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(2);
//            make.top.equalTo(self.leftBtn.mas_bottom).offset(-5);
//            make.centerX.equalTo(self.leftBtn);
//            make.width.mas_equalTo(40);
//        }];
//    }else {
//        [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.rightBtn);
//            make.height.mas_equalTo(2);
//            make.top.equalTo(self.rightBtn.mas_bottom).offset(-5);
//            make.width.mas_equalTo(40);
//        }];
//    }
//}

- (void)leftEvent:(UIButton *)btn {
    
    [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(2);
        make.top.equalTo(btn.mas_bottom).offset(-2);
        make.centerX.equalTo(btn);
        make.width.mas_equalTo(40);
    }];
    if (self.blockEvent) {
        self.blockEvent(btn.tag);
    }
}

- (void)rightEvent:(UIButton *)btn {
    
    [_bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.height.mas_equalTo(2);
        make.top.equalTo(btn.mas_bottom).offset(-2);
        make.width.mas_equalTo(40);
    }];
    
    if (self.blockEvent) {
        self.blockEvent(btn.tag);
    }
}

@end
