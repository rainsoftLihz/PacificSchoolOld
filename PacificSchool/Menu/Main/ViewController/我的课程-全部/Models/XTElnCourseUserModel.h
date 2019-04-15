//
//  XTElnCourseUserModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTElnCourseUserModel : NSObject
@property (nonatomic,copy)NSString *coopCode ;
@property (nonatomic,copy)NSString *courseCode ;
@property (nonatomic,copy)NSString *courseId ;
@property (nonatomic,copy)NSString *courseStandard ;
@property (nonatomic,copy)NSString *courseTitle ;
@property (nonatomic,copy)NSString *createTime ;
@property (nonatomic,copy)NSString *createUserId ;
@property (nonatomic,copy)NSString *forceLevel ;
@property (nonatomic,copy)NSString *frontUserId;
//@property (nonatomic,copy)NSString *id ;
@property (nonatomic,copy)NSString *isComplete ;
@property (nonatomic,copy)NSString *isDelete ;
@property (nonatomic,copy)NSString *lastStudyTime ;
@property (nonatomic,copy)NSString *processPercent;
@property (nonatomic,copy)NSString *registerTime;
@property (nonatomic,copy)NSString *status ;
@property (nonatomic,copy)NSString *studyCountTotal;
@property (nonatomic,copy)NSString *studyPhase ;
@property (nonatomic,copy)NSString *studyTimeTotal;

@end

NS_ASSUME_NONNULL_END
