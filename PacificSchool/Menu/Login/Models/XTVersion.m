//
//  XTVersion.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/16.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "XTVersion.h"

@implementation XTVersion

-(BOOL)needUpdate{
    
    //对应code --- build
    NSString *versionCode = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];
    
    //对应name --- version
    NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSLog(@"versionCode=%@  currentVersion=%@",versionCode,currentVersion);
    if (self.versionName == nil || self.versionName.length < 1) {
        return NO;
    }
    
    if ([self.versionName isEqualToString:currentVersion]) {
        //比对code
        if (versionCode.integerValue < self.versionNo.integerValue) {
            return YES;
        }else {
            return NO;
        }
    }
    
    if (self.versionName.floatValue > currentVersion.floatValue) {
        return YES;
    }
    
    return NO;
}


@end
