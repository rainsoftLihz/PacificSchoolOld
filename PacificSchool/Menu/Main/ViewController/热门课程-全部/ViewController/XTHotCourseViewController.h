//
//  XTHotCourseViewController.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XTCourseType) {
    XTHotCourseType,
    XTRecommendCourseType
};

@interface XTHotCourseViewController : XTBaseViewController
@property (nonatomic,assign)XTCourseType courseType;
@end

NS_ASSUME_NONNULL_END
