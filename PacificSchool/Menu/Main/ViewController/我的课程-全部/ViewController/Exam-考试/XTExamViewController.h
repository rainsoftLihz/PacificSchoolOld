//
//  XTExamViewController.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseViewController.h"

@class XTExamItemListModel,XTCoursewareDetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTExamViewController : XTBaseViewController
@property(nonatomic,strong)XTCoursewareDetailModel *model;
@end

NS_ASSUME_NONNULL_END
