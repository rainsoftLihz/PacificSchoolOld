//
//  XTFrontUserStatisticsModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTFrontUserStatisticsModel : NSObject
@property (nonatomic,copy)NSString *coopCode;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *frontUserId;
@property (nonatomic,copy)NSString *isDelete ;
@property (nonatomic,copy)NSString *nickname ;
@property (nonatomic,copy)NSString *orgId ;
@property (nonatomic,copy)NSString *realName;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *totalCoin;
@property (nonatomic,copy)NSString *workId;
@property (nonatomic,copy)NSString *rankNo;
@property (nonatomic,copy)NSString *rankScore;
@property (nonatomic,copy)NSString *totalScore;
@end

NS_ASSUME_NONNULL_END
