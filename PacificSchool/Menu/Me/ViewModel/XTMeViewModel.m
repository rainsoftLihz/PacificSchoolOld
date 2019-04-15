//
//  XTMeViewModel.m
//  PacificSchool
//
//  Created by Jonny on 2019/4/2.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMeViewModel.h"
#import "AFNetworking.h"

@implementation XTMeViewModel

+ (void)uploadUserImage:(UIImage *)image success:(void (^)(NSDictionary *result))success {

    NSString *frontUserId = DEF_PERSISTENT_GET_OBJECT(kUserId);
    NSString *coopcode = @"cpic";
    NSString *token =  DEF_PERSISTENT_GET_OBJECT(kUserToken);

    NSDictionary *param = @{@"frontUserId":frontUserId,@"coopCode":coopcode,@"accessToken":token};
    NSLog(@" 上传参数 %@",param);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"application/json",@"text/javascript",@"text/html",@"text/xml", nil];

    [manager POST:kFrontUserHeadimgurl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:imageData name:@"headimgurl" fileName:@"headImage.png" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@" 上传图片成功 %@",responseObject);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@" 上传图片失败 %@",error);
        }
        [SVProgressHUD showWithStatus:@"网络错误"];
    }];
    
    
}

@end
