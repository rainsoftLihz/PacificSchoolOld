//
//  XTHistoryModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/17.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTHistoryModel : NSObject

@property (nonatomic,strong)NSString *coopCode ;
@property (nonatomic,strong)NSString *createTime ;
@property (nonatomic,strong)NSString *createUserId;
@property (nonatomic,strong)NSString *detailId ;
@property (nonatomic,strong)NSString *examId ;
@property (nonatomic,strong)NSString *frontUserId ;
@property (nonatomic,strong)NSString *isDelete;
@property (nonatomic,strong)NSString *rankNo;
@property (nonatomic,strong)NSString *score;
@property (nonatomic,strong)NSDictionary *scoreDetail;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *voiceAuthResult ;
@property (nonatomic,strong)NSString *examTitle;


@end

NS_ASSUME_NONNULL_END
