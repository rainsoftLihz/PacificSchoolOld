//
//  NSString+Tool.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/17.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "NSString+Tool.h"

@implementation NSString (Tool)

-(BOOL)isNull{
    if (!self || [self isKindOfClass:[NSNull class]] || [self isEqualToString:@"(null)"]) {
        return YES;
    }
    return NO;
}

@end
