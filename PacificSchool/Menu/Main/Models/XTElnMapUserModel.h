//
//  XTElnMapUserModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTElnMapUserModel : NSObject

@property (nonatomic,copy)NSString *avgScore;
@property (nonatomic,copy)NSString *coopCode;
@property (nonatomic,copy)NSString *createTime ;
@property (nonatomic,copy)NSString *createUserId;
@property (nonatomic,copy)NSString *frontUserId ;
@property (nonatomic,copy)NSString *ids ;
@property (nonatomic,copy)NSString *isComplete ;
@property (nonatomic,copy)NSString *isDelete;
@property (nonatomic,copy)NSString *jobCountComplete ;
@property (nonatomic,copy)NSString *jobCountTotal ;
@property (nonatomic,copy)NSString *mapId ;
@property (nonatomic,copy)NSString *mapTitle ;
@property (nonatomic,copy)NSString *nickname ;
@property (nonatomic,copy)NSString *status ;

@end

NS_ASSUME_NONNULL_END
