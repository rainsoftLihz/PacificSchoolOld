//
//  LSRecordView.h
//  RecordVoiceDemo
//
//  Created by Jonny on 2019/2/25.
//  Copyright © 2019 allison. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LSRecordViewEventBlock)(NSString *filePath,NSString *fileName);
typedef void(^LSRecordViewHiddenEventBlock)(void);

NS_ASSUME_NONNULL_BEGIN
@interface LSRecordView : UIView

@property (nonatomic,copy)LSRecordViewEventBlock eventBlock;
@property (nonatomic,copy)LSRecordViewHiddenEventBlock hiddenEventBlock;
@end
NS_ASSUME_NONNULL_END

