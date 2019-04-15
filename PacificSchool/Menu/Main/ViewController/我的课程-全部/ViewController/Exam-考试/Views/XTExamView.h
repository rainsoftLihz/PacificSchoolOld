//
//  XTExamView.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XTExamViewEventBlock)(NSInteger index);
@class XTExamItemListModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTExamView : UIView

@property(nonatomic,strong)XTExamItemListModel *model;
@property(nonatomic,copy)XTExamViewEventBlock block;
@end

NS_ASSUME_NONNULL_END
