//
//  XTCommentModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/12.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTCommentModel : NSObject

@property (nonatomic,copy)NSString *commentId;
@property (nonatomic,copy)NSString *commentType;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *coopCode;
@property (nonatomic,copy)NSString *courseId;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *createUserId ;
@property (nonatomic,copy)NSString *frontUserId ;
@property (nonatomic,copy)NSString *headimgurl ;
@property (nonatomic,copy)NSString *isDelete ;
@property (nonatomic,copy)NSString *isThumb;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *replyCount ;
@property (nonatomic,copy)NSString *status ;
@property (nonatomic,copy)NSString *upCount;


@end

NS_ASSUME_NONNULL_END
