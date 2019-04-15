//
//  XTAiExamUserDetailModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/21.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTAiExamUserDetailModel : NSObject
@property (nonatomic,copy)NSString *coopCode;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *createUserId;
@property (nonatomic,copy)NSString *detailId;
@property (nonatomic,copy)NSString *examId;
@property (nonatomic,copy)NSString *frontUserId;
@property (nonatomic,copy)NSString *isDelete;
@property (nonatomic,copy)NSString *rankNo;
@property (nonatomic,copy)NSString *score;
@property (nonatomic,copy)NSString *scoreDetail;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *voiceAuthResult;

@end

NS_ASSUME_NONNULL_END
