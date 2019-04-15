//
//  NSNumber+ToString.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/15.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "NSNumber+ToString.h"

@implementation NSNumber (ToString)
-(BOOL)isEqualToString:(NSString*)str{
    
    NSString* toStr = [NSString stringWithFormat:@"%@",self];

    return [toStr isEqualToString:str];
}
@end
