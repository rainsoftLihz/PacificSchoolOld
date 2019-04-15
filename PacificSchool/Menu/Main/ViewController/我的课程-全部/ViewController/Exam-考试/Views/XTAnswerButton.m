//
//  XTAnswerButton.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTAnswerButton.h"

@interface XTAnswerButton ()

@property (nonatomic,strong)UIImageView *optionImageView;
@property (nonatomic,strong)UILabel *answerShowLabel;

@end

@implementation XTAnswerButton

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

- (void)setOptionContentText:(NSString *)text {
    
    _answerShowLabel.text = text;
}

- (void)initUI {
     // 选项图片
    self.optionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8, 0, 15, 15)];
    [self addSubview:self.optionImageView];
    
//    [self.optionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(15);
//        make.width.height.mas_equalTo(15);
//        make.centerY.equalTo(self.mas_centerY);
//    }];
    
    _answerShowLabel = [[UILabel alloc]init];
    _answerShowLabel.font = kFont(14);
    _answerShowLabel.numberOfLines = 0;
    
    // 选择按钮
    self.selectorButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.selectorButton addTarget:self action:@selector(selectorAnswer:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectorButton];
    [self addSubview:_answerShowLabel];
    
    
    [self.optionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.width.height.mas_equalTo(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_answerShowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.optionImageView.mas_right).offset(8);
        make.right.equalTo(self).offset(-8);
        make.top.bottom.equalTo(self);
    }];
    
    [self.selectorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
        
    }];
    
}


- (void)setRedioSelected {
    
    if (self.answerType == LTMultiType) {
        [self.optionImageView setImage:[UIImage imageNamed:@"RadioButtonSelected"]];
    }else {
        [self.optionImageView setImage:[UIImage imageNamed:@"RedioSelected"]];
    }
}

- (void)setRedioUnSelected {
    
    if (self.answerType == LTMultiType) {
        [self.optionImageView setImage:[UIImage imageNamed:@"RadioButtonUnselected"]];
    }else {
        [self.optionImageView setImage:[UIImage imageNamed:@"RedioUnSelected"]];
    }
}

- (void)selectorAnswer:(UIButton *)btn {
    
    btn.selected =! btn.selected;
    if (btn.selected) {
        
        [self setRedioSelected];
        
        if ([self.delegate respondsToSelector:@selector(selectorAnswerWithIndex:answerOptionIndex:)]) {
            [self.delegate selectorAnswerWithIndex:self answerOptionIndex:btn.tag];
        }
        
    }else {
        
        [self setRedioUnSelected];
        
        if ([self.delegate respondsToSelector:@selector(cancelSelectorAnswerWithIndex:answerOptionIndex:)]) {
            [self.delegate cancelSelectorAnswerWithIndex:self answerOptionIndex:btn.tag];
            
        }
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
