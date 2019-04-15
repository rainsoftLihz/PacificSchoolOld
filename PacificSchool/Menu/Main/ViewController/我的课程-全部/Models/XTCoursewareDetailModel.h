//
//  XTCoursewareDetailModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class XTCourseModel,XTCourseTypeModel,XTElnCourseUser;
@interface XTCoursewareDetailModel : NSObject

@property (nonatomic,strong)NSArray *commonAttachmentList;
@property (nonatomic,strong)XTCourseModel *elnCourse;
@property (nonatomic,strong)XTCourseTypeModel *courseType;
@property (nonatomic,strong)XTElnCourseUser *elnCourseUser;
@property (nonatomic,strong)NSArray *examItemList;
@end

NS_ASSUME_NONNULL_END
