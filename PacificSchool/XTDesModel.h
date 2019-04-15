//
//  XTDesModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/22.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTDesModel : NSObject

+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

+ (NSString *)encodeDesWithString:(NSString *)str key:(NSString *)key;

+ (NSString *)encryptUseDES1:(NSString *)plainText key:(NSString *)key;

+ (NSString *)encryptUseDES2:(NSString *)plainText key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
