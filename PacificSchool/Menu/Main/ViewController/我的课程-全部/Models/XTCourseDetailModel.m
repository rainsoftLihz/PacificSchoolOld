//
//  XTCourseDetailModel.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCourseDetailModel.h"
#import "XTMyCourseModel.h"
#import "XTCourseExamModel.h"
#import "XTElnMapUserModel.h"

@implementation XTCourseDetailModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"aiExamJobList":@"XTCourseExamModel",
             @"normalJobList":@"XTElnMapJobListModel",
             };//前边，是属性数组的名字，后边就是类名
}
@end
