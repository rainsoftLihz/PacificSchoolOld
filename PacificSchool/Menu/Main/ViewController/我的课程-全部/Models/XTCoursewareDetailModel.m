//
//  XTCoursewareDetailModel.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCoursewareDetailModel.h"

@implementation XTCoursewareDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"commonAttachmentList":@"XTCommonAttachmentListModel",
             @"examItemList":@"XTExamItemListModel"
             };//前边，是属性数组的名字，后边就是类名
}
@end
