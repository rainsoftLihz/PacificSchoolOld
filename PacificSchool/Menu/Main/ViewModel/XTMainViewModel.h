//
//  XTMainViewModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/5.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTCourseDetailModel,XTCoursewareDetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTMainViewModel : NSObject

+ (void)postMainDataSuccess:(void (^)(NSDictionary *result))success;

+ (void)getMtMapDataSuccess:(void (^)(NSArray *result))success;

+ (void)getHotSuccess:(void (^)(NSArray *result))success;

+ (void)getRecommendSuccess:(void (^)(NSArray *result))success;

+ (void)getCourseCompleteSuccess:(void (^)(NSArray *result))success;

+ (void)getCourseDetailSuccess:(NSDictionary *)param success:(void (^)(XTCourseDetailModel *result))success;

+ (void)getRank:(NSDictionary *)param Success:(void (^)(NSArray *result,NSInteger total))success;

+ (void)getHistory:(NSDictionary*)params sucess:(void (^)(NSArray *result,NSInteger total))success;

+ (void)getCoursewareDetailSuccess:(NSDictionary *)param success:(void (^)(XTCoursewareDetailModel *result))success;

+ (void)saveCoursewareDateSuccess:(NSDictionary *)param success:(void (^)(NSDictionary *result))success;

+ (void)getSignDataSuccess:(void (^)(NSDictionary *result))success;

+ (void)getUserInfo:(void (^)(NSDictionary *result))success;

+ (void)getUserCPIC:(void (^)(NSDictionary *result))success;

+ (void)getCourseComment:(NSDictionary *)param success:(void (^)(NSArray *result))success;

+ (void)insterCourseComment:(NSDictionary *)param success:(void (^)(NSDictionary *result))success;

+ (void)getTokenWithParam:(NSDictionary *)param success:(void (^)(NSDictionary *result))success;

+ (void)getHistory:(void (^)(NSArray *result))success;

+ (void)getExamDetailSuccess:(NSDictionary *)param success:(void (^)(NSDictionary *result))success;

+ (void)getMatchingSuccess:(NSDictionary *)param success:(void (^)(NSDictionary *result))success;

+ (void)logout:(void (^)(NSDictionary *result))success;

+ (void)getDetail:(void (^)(NSDictionary *result))success;

+ (void)getSaveSign:(void (^)(NSDictionary *result))success;

+ (void)submitScroeSuccess:(NSDictionary *)param success:(void (^)(NSDictionary *result))success;
@end

NS_ASSUME_NONNULL_END
