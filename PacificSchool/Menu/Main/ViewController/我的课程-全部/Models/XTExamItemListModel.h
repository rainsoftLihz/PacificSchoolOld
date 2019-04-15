//
//  XTExamItemListModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTExamItemListModel : NSObject

@property (nonatomic,copy)NSString *correctAnswer;
@property (nonatomic,copy)NSString *courseCode;
@property (nonatomic,copy)NSString *courseId ;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *createUserId;
@property (nonatomic,copy)NSString *isCourseItem;
@property (nonatomic,copy)NSString *isDelete;
@property (nonatomic,copy)NSString *isPaperItem ;
@property (nonatomic,copy)NSString *itemA ;
@property (nonatomic,copy)NSString *itemB;
@property (nonatomic,copy)NSString *itemC;
@property (nonatomic,copy)NSString *itemD;
@property (nonatomic,copy)NSString *itemDegree;
@property (nonatomic,copy)NSString *itemId;
@property (nonatomic,copy)NSString *itemTitle;
@property (nonatomic,copy)NSString *itemType;
@property (nonatomic,strong)NSArray *optionArray;
@property (nonatomic,strong)NSArray *optionList;
@property (nonatomic,copy)NSString *orderNo;
@property (nonatomic,copy)NSString *score;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *index;
@property (nonatomic,assign)NSInteger questionCount;

@end

NS_ASSUME_NONNULL_END
