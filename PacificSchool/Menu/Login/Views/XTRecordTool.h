//
//  XTRecordTool.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/14.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LSRecordViewEventBlock)(NSString *filePath,NSString *fileName);

@interface XTRecordTool : NSObject

@property (nonatomic,copy)LSRecordViewEventBlock eventBlock;

- (void)removeFilePath;
- (void)clearCafFile;
- (void)startRecord;

// 结束录音
- (void)doneRecordNotice;
@end



NS_ASSUME_NONNULL_END
