//
//  XTElnMapListModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTElnMapListModel : NSObject

@property (nonatomic,copy)NSString *belongId ;
@property (nonatomic,copy)NSString *belongType ;
@property (nonatomic,copy)NSString *coopCode ;
@property (nonatomic,copy)NSString *coverImg ;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *createUserId;
@property (nonatomic,copy)NSString *isDelete;
@property (nonatomic,copy)NSString *isForceOrder;
@property (nonatomic,copy)NSString *jobCount ;
@property (nonatomic,copy)NSString *mapCode;
@property (nonatomic,copy)NSString *mapId ;
@property (nonatomic,copy)NSString *mapTitle;
@property (nonatomic,copy)NSString *modifyTime ;
@property (nonatomic,copy)NSString *summary ;
@end

NS_ASSUME_NONNULL_END
