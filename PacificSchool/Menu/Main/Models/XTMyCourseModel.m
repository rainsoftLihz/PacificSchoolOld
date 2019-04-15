//
//  XTMyCourseModel.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMyCourseModel.h"

@implementation XTMyCourseModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"elnMapJobList":@"XTElnMapJobListModel",
             };//前边，是属性数组的名字，后边就是类名
}
@end
