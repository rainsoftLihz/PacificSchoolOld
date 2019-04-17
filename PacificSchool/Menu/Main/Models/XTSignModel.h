//
//  XTSignModel.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/16.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTSignModel : NSObject
//目标学习时长  分钟
@property(nonatomic,strong) NSString* aimStudyTime;
//已经学习时长
@property(nonatomic,strong) NSString* hasStudyTime;
//是否签到
@property(nonatomic,strong) NSString* isSigned;
//连续打卡次数
@property(nonatomic,strong) NSString* signContinueCount;
//累计打卡次数
@property(nonatomic,strong) NSString* signTotalCount;

//我的智慧豆
@property(nonatomic,strong) NSString* totalScore;
@end

NS_ASSUME_NONNULL_END
