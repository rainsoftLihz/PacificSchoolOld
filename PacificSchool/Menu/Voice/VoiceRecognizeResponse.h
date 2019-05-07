//
//  VoiceRecognizeResponse.h
//  PacificSchool
//
//  Created by rainsoft on 2019/5/6.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Content : NSObject
    // 识别结果
    @property(nonatomic,strong) NSString* voiceMessage;
    
    // 请求会话标识
    @property(nonatomic,strong) NSString* reqNo;
    
    // 识别状态
    @property(nonatomic,strong) NSString* status;

@end

@interface VoiceRecognizeResponse : NSObject
    
    // 成功失败标识
    @property(nonatomic,assign)NSInteger result;
    
    // 返回代码
    @property(nonatomic,strong) NSString* code;
    
    // 返回信息
    @property(nonatomic,strong) NSString* message;
    
    @property(nonatomic,strong)Content* content;
    
    @property(nonatomic,strong)NSDictionary* additions;

@end

NS_ASSUME_NONNULL_END
