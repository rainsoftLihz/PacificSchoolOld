//
//  XTRecognitionManager.h
//  SpeechTest
//
//  Created by Jonny on 2019/3/16.
//  Copyright © 2019 Dushu Ou. All rights reserved.
//

#import <Foundation/Foundation.h>

// 停止中block
typedef void(^XTRecognitionManagerStoping)(NSString *result);
// 停止录音
typedef void(^XTRecognitionManagerStop)(NSString *result);

typedef void(^XTRecognitionManagerStart)(NSString *result);

// 识别结果
typedef void(^XTRecognitionManagerResult)(NSString *result);

//识别失败
typedef void(^XTRecognitionManagerError)(NSString *result);

//语音识别是否可用
typedef void(^XTRecognitionManagerAvailability)(BOOL available);


NS_ASSUME_NONNULL_BEGIN

@interface XTRecognitionManager : NSObject

@property (nonatomic,copy)XTRecognitionManagerStoping stopingBlock;
@property (nonatomic,copy)XTRecognitionManagerStart startBlock;
@property (nonatomic,copy)XTRecognitionManagerStop stopBlock;
@property (nonatomic,copy)XTRecognitionManagerResult resultBlock;
@property (nonatomic,copy)XTRecognitionManagerError errorBlock;
@property (nonatomic,copy)XTRecognitionManagerAvailability availableBlock;

+(XTRecognitionManager *)shareManager;

- (void)recordButtonClicked;

- (void)startRecording;

- (void)endRecording;


@end

NS_ASSUME_NONNULL_END
