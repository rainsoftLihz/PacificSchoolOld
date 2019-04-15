//
//  XTCourseDetailModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XTMyCourseModel,XTCourseExamModel,XTElnMapUserModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTCourseDetailModel : NSObject

@property (nonatomic,strong)NSArray *aiExamJobList;
@property (nonatomic,strong)XTMyCourseModel *elnMap;
@property (nonatomic,strong)XTElnMapUserModel *elnMapUser;
@property (nonatomic,strong)NSArray *normalJobList;
@end

NS_ASSUME_NONNULL_END
