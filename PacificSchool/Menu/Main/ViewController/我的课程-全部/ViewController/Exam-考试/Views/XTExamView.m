//
//  XTExamView.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTExamView.h"
#import "XTAnswerButton.h"
#import "XTTitleView.h"
#import "XTQuestionView.h"
#import "XTExamItemListModel.h"
#import "XTRecognitionView.h"

@interface XTExamView ()
<
    XTAnswerButtonDelegate
>
@property (nonatomic,strong)XTTitleView *titleView;
@property (nonatomic,strong)XTQuestionView *quetionView;
@property (nonatomic,strong)UIView *optionView;
@property (nonatomic,assign)float optionBtnHeights;
@property (nonatomic,strong)NSArray *options ;
@property (nonatomic,strong)UIButton *nextBtn;
@end

@implementation XTExamView

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
    
    _optionBtnHeights = 0;
    
    self.options = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I"];

}

- (void)setModel:(XTExamItemListModel *)model {
 
    _model = model;
    
    float height = [LTTools rectWidthAndHeightWithStr:model.itemTitle AndFont:15 WithStrWidth:kScreenW-16];
    if (height<40) {
        height= 40;
    }
//    height=300;
    // 问题
    [_quetionView setQuestionContent:model.itemTitle];
    
    [_quetionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];

    [self configTalk:model];
    
    // 题型
    [self configQuestionType:model];
    
    // 选项
    [self configOption:model];
    
    // 切换
    [self configNextBtn:model];
}

- (void)configNextBtn:(XTExamItemListModel *)model {
    if ([model.index isEqualToString:[NSString stringWithFormat:@"%ld",model.questionCount]]) {
        [_nextBtn setTitle:@"提交" forState:0];
    }
}

// 配置语音
- (void)configTalk:(XTExamItemListModel *)model {
    
    if ([model.itemType isEqualToString:@"talk"]) {
        
        XTRecognitionView *recognitionView = [XTRecognitionView new];
        recognitionView.backgroundColor = [UIColor whiteColor];
        recognitionView.quetionString = model.itemTitle;
        [self addSubview:recognitionView];

        [recognitionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.quetionView).offset(8);
            make.right.equalTo(self.quetionView).offset(-8);
            make.top.equalTo(self.quetionView.mas_bottom).offset(8);
            make.height.mas_equalTo(256);
        }];
        
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(recognitionView).offset(20);
            make.right.equalTo(recognitionView).offset(-20);
            make.top.equalTo(recognitionView.mas_bottom).offset(8);
            make.height.mas_equalTo(30);
        }];
        
    }
    
}

- (void)configQuestionType:(XTExamItemListModel *)model {
    
    if ([model.itemType isEqualToString:@"multi"]) {
        
        [_titleView setTitleContent:[NSString stringWithFormat:@"第%@题",model.index] type:@"[多选题]"];
        
    }else if ([model.itemType isEqualToString:@"signle"]) {
        
        [_titleView setTitleContent:[NSString stringWithFormat:@"第%@题",model.index] type:@"[单选题]"];
        
    }else if ([model.itemType isEqualToString:@"talk"]) {
        
        [_titleView setTitleContent:[NSString stringWithFormat:@"第%@题",model.index] type:@"[语音题]"];
        
    }else if ([model.itemType isEqualToString:@"judge"]) {
        
        [_titleView setTitleContent:[NSString stringWithFormat:@"第%@题",model.index] type:@"[判断题]"];
    }
    
}

- (void)configOption:(XTExamItemListModel *)model {
    
    for (int i = 0; i<model.optionArray.count; i ++ ) {
    
        NSString *title = model.optionArray[i];
        NSString *quesion = [NSString stringWithFormat:@"%@、%@",self.options[i],title];
        
        float height = [LTTools rectWidthAndHeightWithStr:quesion AndFont:14 WithStrWidth:kScreenW-24];
        if (height<40) {
            height = 40;
        }
        NSLog(@" 循环高度 ==== %f title =%@ /n",height,quesion);

        _optionBtnHeights = _optionBtnHeights + height;
        
        XTAnswerButton *btn = [[XTAnswerButton alloc]init];
        btn.delegate = self;
        btn.index = i;
        if ([model.itemType isEqualToString:@"multi"]) {
            btn.answerType = LTMultiType;
        }else if ([model.itemType isEqualToString:@"signle"]) {
            btn.answerType = LTSignleType;
        }else if ([model.itemType isEqualToString:@"talk"]) {
            btn.answerType = LTTalkType;
        }
        
        [btn setRedioUnSelected];
        
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i+10086;
        [self addSubview:btn];
        
        [btn setOptionContentText:quesion];
        if (i == 0) {
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.quetionView.mas_bottom);
                make.height.mas_equalTo(height);
            }];
        }else {
            
            XTAnswerButton *subbtn = [self viewWithTag:(i+10086)-1];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(subbtn.mas_bottom);
                make.height.mas_equalTo(height);
            }];
            
        }
    }
    
    NSLog(@" 高度 ==== %f",_optionBtnHeights);
    
}

- (void)initUI {
 
    _titleView = [XTTitleView new];
    _titleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_titleView];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];

    _quetionView = [XTQuestionView new];
    _quetionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_quetionView];
 
    [_quetionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.titleView.mas_bottom).offset(8);
        make.height.mas_equalTo(0);
    }];
    
    _optionView = [UIView new];
    _optionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_optionView];

    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setTitle:@"下一题" forState:0];
    _nextBtn.titleLabel.font = kFont(15);
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:0];
    [_nextBtn addTarget:self action:@selector(nextEventBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextBtn];
    
    
    _nextBtn.layer.cornerRadius= 2;
    _nextBtn.layer.borderWidth = 1;
    _nextBtn.layer.borderColor = kMainColor.CGColor;
    _nextBtn.backgroundColor = kMainColor;
    
//    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(20);
//        make.right.equalTo(self).offset(-20);
//        make.bottom.equalTo(self.mas_bottom).offset(-10);
//        make.height.mas_equalTo(30);
//    }];
    
    
}

- (void)nextEventBtn:(UIButton *)btn {
    
    if (self.block) {
        self.block([self.model.index intValue]);
    }
}

- (void)selectorAnswerWithIndex:(XTAnswerButton *)btn answerOptionIndex:(NSInteger)index {
    
    if (btn.answerType == LTMultiType) {
        
    }else {
        [self changeSeleteBtnStyle:btn.tag];
    }
}

- (void)cancelSelectorAnswerWithIndex:(XTAnswerButton *)btn answerOptionIndex:(NSInteger)index {
    
    if (btn.answerType == LTMultiType) {
        
    }else {
        [self changeSeleteBtnStyle:btn.tag];
    }
}

- (void)changeSeleteBtnStyle:(NSInteger )index {
    
    NSLog(@"index %ld",index);
//    UIScrollView *contentView = [self viewWithTag:index + 10086];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[XTAnswerButton class]]) {
            XTAnswerButton *btn = (XTAnswerButton *)view;
            if (btn.tag != (index)) {
                [btn setRedioUnSelected];
            }else {
                [btn setRedioSelected];
            }
        }
    }
}

-(void)dealloc{
    NSLog(@"dealloc === >>> %@",self);
}

@end
