//
//  ZCNoneiFLYTEK.h
//  JK_BLB
//
//  Created by shiyang on 16/1/5.
//  Copyright © 2015年 com.application.qiyun. All rights reserved.
//

/*
 需要添加系统的库
 AVFoundation
 CoreTelephony
 CoreLocation
 AudioToolBox
 SystemCOnfiguration
 QuartzCore
 AddressBook
 Foundation
 CoreGraphics
 libz
 */

/*
 * 初始化方法
 * 引用库
    #import "iflyMSC/IFlyMSC.h"
    #import "Definition.h"
 
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID_VALUE];
    [IFlySpeechUtility createUtility:initString];
 */

/*
 * 接口调用方法
 
 
 
 * 开始录音:
    [[FlyVoiceManager shareManager] startSpeaking];
 
 * 停止录音并返回获取字符串:
    [[FlyVoiceManager shareManager] stopSpeaking:^(NSString *str) {
        NSLog(@"刚才说的是:%@",str);
    }];
 */

#import <Foundation/Foundation.h>
//语音识别
#import "iflyMSC/iflyMSC.h"

@interface FlyVoiceManager : NSObject<IFlySpeechRecognizerDelegate>
{
    NSInteger isAutoStop;
}
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象
@property(nonatomic,copy) NSString *resultStr;
@property(nonatomic,copy) void(^onResult)(NSString*);
@property(nonatomic, weak) id volumeDelegate;	// 音量变化回调
+(id)shareManager;

/*
 *  开始录音,默认等待5秒钟就结束录音,则开始识别
 */
-(void)startSpeaking;

/*
 *  停止录音,立即开始识别
 */
-(void)stopSpeaking:(void(^)(NSString*))a;

/*
 *  取消录音
 */
-(void)cancleSpeaking:(void(^)(NSString *))a;

@end
