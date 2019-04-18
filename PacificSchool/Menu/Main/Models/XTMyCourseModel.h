//
//  XTMyCourseModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTElnMapUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XTMyCourseModel : NSObject
//belongId":"",
//"belongType":"org",
//"coopCode":"cpic",
//"coverImg":"/uploads/cpic/resource/elnMap/fcb60bca204044ef9855a777ae0d2b81.jpeg",
//"createTime":1548662825000,
//"createUserId":"dd55a742f32b40a9b17c94fa0f1daa36",
//"elnMapJobList":Array[5],
//"elnMapUser":Object{...},
//"isDelete":"N",
//"isForceOrder":"Y",
//"jobCount":12,
//"mapCode":"98",
//"mapId":"95451530834b467182fac6e2fdecbb9a",
//"mapTitle":"产品：安行宝3.0",
//"modifyTime":1550504422000,
//"modifyUserId":"dd55a742f32b40a9b17c94fa0f1daa36",
//"status":"1",
//"summary":"

@property (nonatomic,copy)NSString *belongId;

@property (nonatomic,copy)NSString *belongType;
@property (nonatomic,copy)NSString *coopCode;
@property (nonatomic,copy)NSString *coverImg;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *createUserId;
@property (nonatomic,copy)NSArray *elnMapJobList;
@property (nonatomic,strong)XTElnMapUserModel*elnMapUser;
@property (nonatomic,copy)NSString *isDelete;
@property (nonatomic,copy)NSString *isForceOrder;
@property (nonatomic,copy)NSString *jobCount;
@property (nonatomic,copy)NSString *mapCode;
@property (nonatomic,copy)NSString *mapId;
@property (nonatomic,copy)NSString *mapTitle;
@property (nonatomic,copy)NSString *modifyTime;
@property (nonatomic,copy)NSString *modifyUserId;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *summary;
@property (nonatomic,copy)NSString *jobCountComplete;
@property (nonatomic,copy)NSString *jobCountTotal;
@property (nonatomic,copy)NSString *scoreAverage;
@end;

NS_ASSUME_NONNULL_END
