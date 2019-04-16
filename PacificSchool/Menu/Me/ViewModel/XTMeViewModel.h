//
//  XTMeViewModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/4/2.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTMeViewModel : NSObject
+ (void)uploadUserImage:(UIImage *)image success:(void (^)(NSDictionary *result))success;

+ (void)checkVersionSuccess:(void (^)(NSDictionary *result))success;

@end

NS_ASSUME_NONNULL_END
