//
//  XTAnswerButton.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol XTAnswerButtonDelegate;

typedef NS_ENUM (NSInteger,LTAnswerType){
    LTSignleType,    ///< 单选
    LTMultiType,    ///< 多选
    LTTalkType    ///< 说话
};

@interface XTAnswerButton : UIView

@property (nonatomic,assign)NSInteger index;                    ///< 记录选择的哪个
@property (nonatomic,assign)LTAnswerType answerType;            ///< 选项类型
@property (nonatomic,strong)UIButton *selectorButton;           ///< 选择按钮
@property (nonatomic,weak)id<XTAnswerButtonDelegate>delegate;

- (void)setOptionContentText:(NSString *)text;

//- (instancetype)initWithFrame:(CGRect)frame answerName:(NSString *)answerName;

// 设置选中样式
- (void)setRedioSelected;

// 设置未选中样式
- (void)setRedioUnSelected;
@end

// 代理方法
@protocol XTAnswerButtonDelegate <NSObject>

@optional

- (void)selectorAnswerWithIndex:(XTAnswerButton *)btn answerOptionIndex:(NSInteger)index ;

- (void)cancelSelectorAnswerWithIndex:(XTAnswerButton *)btn answerOptionIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
