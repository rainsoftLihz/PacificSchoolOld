//
//  VoiceRecognizeRequest.h
//  PacificSchool
//
//  Created by rainsoft on 2019/5/6.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoiceRecognizeRequest : NSObject
    
    // 令牌
    @property (strong,nonatomic)NSString* token;
    
    // 系统标识
    @property (strong,nonatomic)NSString*  appId;
    
    // 业务标识
    @property (strong,nonatomic)NSString*  bizNo;
    
    // 请求会话标识
    @property (strong,nonatomic)NSString*  reqNo;
    
    // 采样率设置
    @property (strong,nonatomic)NSString*  rate;
    
    // 语言设置
    @property (strong,nonatomic)NSString*  language;
    
    // 资源号设置
    @property (strong,nonatomic)NSString*  resId;
    
    // 音频状态
    @property (strong,nonatomic)NSString*  audioStatus;
    
    // 引擎端点超时时间
    @property (strong,nonatomic)NSString*  eos;
    
    // 引擎前端点超时时间
    @property (strong,nonatomic)NSString*  bos;
    
    // 语音Base64数据
    @property (strong,nonatomic)NSString*  voiceData;

    - (instancetype)initWith:(NSString*)token appId:(NSString*)appId reqNo:(NSString*)reqNo rate:(NSString*)rate  audioStatus:(NSString*)audioStatus;
    
@end

NS_ASSUME_NONNULL_END
