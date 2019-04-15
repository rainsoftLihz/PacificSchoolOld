//
//  XTElnMapJobListModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


// 与课程详情中的normalJobList 共用
@interface XTElnMapJobListModel : NSObject

@property (nonatomic,copy)NSString *contentType;
@property (nonatomic,copy)NSString *isComplete;
@property (nonatomic,copy)NSString *isOpen;
@property (nonatomic,copy)NSString *studyTimeTotal;
@property (nonatomic,copy)NSString *timeLong;

@property (nonatomic,copy)NSString *coopCode;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *createUserId;
@property (nonatomic,copy)NSString *isDelete;
@property (nonatomic,copy)NSString *jobId;
@property (nonatomic,copy)NSString *mapId ;
@property (nonatomic,copy)NSString *objectId;
@property (nonatomic,copy)NSString *objectTitle;
@property (nonatomic,copy)NSString *objectType ;
@property (nonatomic,copy)NSString *orderNo ;
@property (nonatomic,copy)NSString *status ;

@end

NS_ASSUME_NONNULL_END
