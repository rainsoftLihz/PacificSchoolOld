//
//  XTQuestionView.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTQuestionView.h"
#import "LTTools.h"

@interface XTQuestionView ()

@property(nonatomic,strong) UILabel *label;

@end

@implementation XTQuestionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initUI];
        
    }
    return self;
}

- (void)setQuestionContent:(NSString *)text {
    
    _label.text = text;
    float height = [LTTools rectWidthAndHeightWithStr:text AndFont:15 WithStrWidth:kScreenW-16];
    if (height<40) {
        height= 40;
    }
    _label.frame = CGRectMake(8, 0, kScreenW - 16,height);

}

- (void)initUI {
    
    _label = [UILabel new];
    _label.layer.cornerRadius = 5;
    _label.layer.masksToBounds = YES;
    _label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _label.font = kFont(15);
    _label.numberOfLines = 0;
    [self addSubview:_label];
    
    
    
//    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(8);
//        make.right.equalTo(self).offset(-8);
//        make.top.bottom.equalTo(self);
//    }];
    
}
@end
