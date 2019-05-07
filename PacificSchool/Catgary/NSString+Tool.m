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

/**
 过滤器/ 将.2f格式化的字符串，去除末尾0
 
 @param numberStr .2f格式化后的字符串
 @return 去除末尾0之后的
 */
+ (NSString *)removeSuffix:(NSString *)numberStr{
    return numberStr;
    if (numberStr.length > 1) {
        
        if ([numberStr componentsSeparatedByString:@"."].count == 2) {
            NSString *last = [numberStr componentsSeparatedByString:@"."].lastObject;
            if ([last isEqualToString:@"00"]) {
                numberStr = [numberStr substringToIndex:numberStr.length - (last.length + 1)];
                return numberStr;
            }else{
                if ([[last substringFromIndex:last.length -1] isEqualToString:@"0"]) {
                    numberStr = [numberStr substringToIndex:numberStr.length - 1];
                    return numberStr;
                }
            }
        }
        return numberStr;
    }else{
        return nil;
    }
}


@end
