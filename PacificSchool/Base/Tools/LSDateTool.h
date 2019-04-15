//
//  LSDateTool.h
//  WiClass
//
//  Created by Jonny on 2019/1/21.
//  Copyright © 2019 com.wistron. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSDateTool : NSObject

+ (NSString *)getCurrentDate;
+ (NSString *)get_currentStringDateValue;
+ (NSString *)getCurrentDay;
+ (NSString *)stringDateValue;
+ (NSString *)getCurrentDate_day;

+ (NSString *)beforeDate:(NSInteger)month;

+ (NSInteger )timestampConvrrtString:(NSString *)dateString;

+ (NSString *)dateConvrrtTimestamp:(NSInteger)timestamp;

+ (NSString *)stringDateMM:(NSString *)dateString;

+ (NSInteger)getWeekday:(NSString *)dateString;

+ (NSInteger )mm_timestampConvrrtString:(NSString *)dateString;

/* 转换时分*/
+ (NSString *)stringDateHHMM:(NSString *)dateString;

+ (NSString *)ymdhm_dateConvrrtTimestamp:(NSInteger)timestamp;

+ (NSString *)getUTCStrFormateLocalStr:(NSString *)localStr;

+ (NSString *)inputTimeStr:(NSString *)timeStr withFormat:(NSString *)format;

+ (NSInteger)timeStampValue;
+ (NSInteger)timeStampValue2;
@end

NS_ASSUME_NONNULL_END
