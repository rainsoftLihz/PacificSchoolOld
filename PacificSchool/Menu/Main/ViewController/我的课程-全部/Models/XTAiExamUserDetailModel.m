//
//  XTAiExamUserDetailModel.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/21.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTAiExamUserDetailModel.h"

@implementation XTAiExamUserDetailModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.rankNo = @"0";
        self.score = @"0";
        self.scoreDetail = @"0";
    }
    return self;
}
@end
