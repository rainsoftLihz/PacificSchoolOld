//
//  AQCapture.h
//  H5Test
//
//  Created by harlan on 2019/3/1.
//  Copyright © 2019 wezhiuyi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AQCaptureDelegate <NSObject>
- (void)returnData:(NSMutableData *)data;
@end

@interface AQCapture : NSObject

@property (nonatomic,strong) id<AQCaptureDelegate>delegate;
@property (nonatomic,assign)UInt32  bitsPerChannel;
@property (nonatomic,assign)UInt32  bytesPerPacket;
@property (nonatomic,assign)UInt32  sampleRateKey;

- (instancetype)initWithSampleRateKey:(UInt32)sampleRateKey bitsPerChannel:(UInt32)bitsPerChannel bytesPerPacket:(UInt32)bytesPerPacket;
- (void)startRecord;
- (void)stopRecord;
@end

NS_ASSUME_NONNULL_END
