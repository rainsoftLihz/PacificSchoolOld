//
//  XTElnMapUserModel.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTElnMapUserModel.h"

@implementation XTElnMapUserModel

+ (NSDictionary *)replacedKeyFromPropertyName {
    
    return @{@"ids":@"id"};
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.jobCountTotal = @"0";
        self.jobCountComplete = @"0";
        self.avgScore = @"0";
    }
    return self;
}
@end
