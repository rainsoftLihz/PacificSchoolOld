//
//  XTTitleView.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTTitleView.h"

@interface XTTitleView ()

@property (nonatomic,strong)UILabel *titleLabel;

@end
@implementation XTTitleView


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

- (void)setTitleContent:(NSString *)text type:(NSString*)type {
    
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:text];
    NSAttributedString *subString = [[NSAttributedString alloc]initWithString:type attributes:@{NSForegroundColorAttributeName:kMainColor,NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    [allString appendAttributedString:subString];
    self.titleLabel.attributedText = allString;
    
}


- (void)initUI {
 
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = kFont(12);
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = kFont(15);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleLabel sizeToFit];
    [self addSubview:self.titleLabel];
//    kScreenW- 15 - 30;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
//        make.height.mas_equalTo(22);
//        make.width.mas_equalTo(kScreenW);
    }];
    
}

@end
