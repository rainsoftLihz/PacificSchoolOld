//
//  LTNetWorkManager.h
//  MobileClassroom
//
//  Created by Jonny on 23/02/2017.
//  Copyright © 2017 上海众盟的软件科技股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccessDic)(NSDictionary *dic);
typedef void(^RequestErrorData)(NSString *msg);

@interface LTNetWorkManager : NSObject



+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure;

#pragma mark - 登陆之后的post请求
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *msg))failure;

#pragma mark - 登陆之前的post请求
+ (void)loginFirstPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *msg))failure;

#pragma mark - 上传图片
+ (void)uploadImageURL:(NSString *)url param:(NSDictionary *)param image:(UIImage *)image success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *msg))failure;


#pragma mark - 批量上传图片
+ (void)uploadImageURL:(NSString *)url param:(NSDictionary *)param images:(UIImage *)image success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *msg))failure;

+ (void)postWithUrl:(NSString*)url param:(NSString*)param success:(void (^)(NSDictionary *result))success fail:(void (^)(NSString *msg))fail;

+ (NSDictionary *)getEncrypt;

+ (void)upload_fileWithUrl:(NSString*)url param:(NSDictionary *)param file:(NSString *)filePath fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(RequestSuccessDic)success fail:(RequestErrorData)fail;

@end
