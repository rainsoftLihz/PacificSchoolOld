//
//  XTRankModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

//    coopCode = cpic;
//    createTime = 1547956369000;
//    frontUserId = edcf19a007794898ba5d06de3559a539;
//    isDelete = N;
//    nickname = "李鹏";
//    orgId = b5cc45903ee942ba9fbae417810fa706;
//    realName = "李鹏";
//    status = 1;
//    stockCoin = 32;
//    totalCoin = 32;
//    workId = 1001;
//};

#import "XTFrontUserStatisticsModel.h"
@interface XTRankModel : NSObject

@property (nonatomic,copy)NSString *coopCode;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *createUserId;
@property (nonatomic,copy)NSString *frontUserId;
@property (nonatomic,copy)NSString *frontUserNo ;
@property (nonatomic,strong)XTFrontUserStatisticsModel *frontUserStatistics;
@property (nonatomic,copy)NSString *headimgurl ;
@property (nonatomic,copy)NSString *isDelete ;
@property (nonatomic,copy)NSString *isOnline ;
@property (nonatomic,copy)NSString *isVisitor;
@property (nonatomic,copy)NSString *lastLoginTime ;
@property (nonatomic,copy)NSString *mobile ;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *orgId ;
@property (nonatomic,copy)NSString *orgName;
@property (nonatomic,copy)NSString *password ;
@property (nonatomic,copy)NSString *posName ;
@property (nonatomic,copy)NSString *realName ;
@property (nonatomic,copy)NSString *registerTime;
@property (nonatomic,copy)NSString *roleCode ;
@property (nonatomic,copy)NSString *status ;
@property (nonatomic,copy)NSString *totalLoginCount ;
@property (nonatomic,copy)NSString *userAuthType ;
@property (nonatomic,copy)NSString *username ;
@property (nonatomic,copy)NSString *workId;

@end

