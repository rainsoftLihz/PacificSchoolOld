//
//  LTNetWorkManager.m
//  MobileClassroom
//
//  Created by Jonny on 23/02/2017.
//  Copyright © 2017 上海众盟的软件科技股份有限公司. All rights reserved.
//

#import "LTNetWorkManager.h"
#import "AFNetworking.h"

@implementation LTNetWorkManager

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *result))success failure:(void (^)(NSError *error))failure {
    [SVProgressHUD show];

    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr GET:url parameters:[self getOldParamsFromParams:params] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(error);
    }];
}

#pragma mark - 登陆之前的post 请求
+ (void)loginFirstPost:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *msg))failure {
    
    [SVProgressHUD show];
    // 1.创建请求管理者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    manger.requestSerializer.timeoutInterval = 30.f;
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html",@"text/xml", nil];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 打印请求Api
    //[LTNetWorkManager jointParameter:[self getOldParamsFromParams:params] url:url];
    NSLog(@"登录参数 %@",params);
    [manger POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"❕登陆或注册之前数据请求错误返回数据%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(@"登陆或注册前网络错误");
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

#pragma mark - 登陆之后的post 请求
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *msg))failure {
    
    // 1.创建请求管理者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html",@"text/xml", nil];
    manger.requestSerializer.timeoutInterval = 60.f;
//    manger.requestSerializer.HTTPShouldHandleCookies = NO;
    [LTNetWorkManager jointParameter:[self getOldParamsFromParams:params] url:url];
    
    [manger POST:url parameters:[self getOldParamsFromParams:params] progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"❕数据请求错误返回数据%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failure(@"网络错误");
    }];
}

+ (void)uploadImageURL:(NSString *)url param:(NSDictionary *)param images:(UIImage *)image success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *msg))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:[self getOldParamsFromParams:param] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *imageName = [NSString stringWithFormat:@"imageName.png"];
        [formData appendPartWithFileData:imageData name:@"user_file" fileName:imageName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"网络错误");
    }];
    
}

+ (void)uploadImageURL:(NSString *)url param:(NSDictionary *)param image:(UIImage *)image success:(void (^)(NSDictionary *result))success failure:(void (^)(NSString *msg))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:[self getEncrypt] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:imageData name:@"user_file" fileName:@"headImage.png" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@" 上传图片成功 %@",responseObject);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@" 上传图片失败 %@",error.domain);
        }
        failure(@"网络错误");
    }];
}

+ (NSDictionary *)getOldParamsFromParams:(NSDictionary *)params {
    
    NSMutableDictionary *newParams = [[NSMutableDictionary alloc] initWithDictionary:params];
    [newParams addEntriesFromDictionary:[self getEncrypt]];
    return newParams;
}

+ (NSDictionary *)getEncrypt {
    
    NSString *userid = DEF_PERSISTENT_GET_OBJECT(kUserId);
    NSString *username = DEF_PERSISTENT_GET_OBJECT(kUserName);
    NSString *token =  DEF_PERSISTENT_GET_OBJECT(kUserToken);
    NSString *coopcode = @"cpic";
    if ([LTTools isBlankString:userid]) userid = @"";
    if ([LTTools isBlankString:username]) username = @"";
    if ([LTTools isBlankString:token]) token = @"";
    NSDictionary *commParam = @{ @"frontUserId" : userid, @"accessToken" : token,@"coopCode":coopcode};
    return  commParam;
}

+ (void)jointParameter:(NSDictionary *)par url:(NSString *)url {
    
    NSArray *parAry = par.allKeys;
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i = 0; i < parAry.count; i ++ ) {
        
        NSString *key = parAry[i];
        NSString *values = par[key];
        NSString *jointKey = [NSString stringWithFormat:@"%@=%@",key,values];
        [keyValues addObject:jointKey];
    }
    
    NSString *keyValuesString  = [keyValues componentsJoinedByString:@"&"];
    NSLog(@" ❗️ 参数字符  ：%@&%@ \n",url,keyValuesString);
}

+ (void)postWithUrl:(NSString*)url param:(NSString*)param success:(void (^)(NSDictionary *result))success fail:(void (^)(NSString *msg))fail {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];//不设置会报-1016或者会有编码问题
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; //不设置会报-1016或者会有编码问题
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; //不设置会报 error 3840
    
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript",@"text/html",@"text/plain",nil]];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"URLString:url parameters:nil error:nil];
    
    [request addValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    
    NSData *body =[param dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPBody:body];
    
    //发起请求
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *_Nonnull response, id _Nullable responseObject,NSError * _Nullable error)
      
      {
          if (error) {
              NSLog(@" 请求错误 %@",error);
              fail(@"请求错误");
          }else {
              
              NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              NSLog(@" ===== %@",dic);
//              if ([dic[@"status"] isEqualToString:@"success"]) {
                  success(dic);
                  
//              }else {
//                  fail(@"请求错误");
//
//              }
              
          }
      }] resume];
    
}

+ (void)upload_fileWithUrl:(NSString*)url param:(NSDictionary *)param file:(NSString *)filePath fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(RequestSuccessDic)success fail:(RequestErrorData)fail {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain",nil];
    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"MP3File/1551924184343.pcm"];
//        NSLog(@" ======== %@",filePath);
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSLog(@"文件名字%@",fileName);
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"audio/mpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"状态 %@",responseObject);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@" 上传录音失败 %@",error);
        }
        fail(@"网络错误");
    }];

    
}

@end
