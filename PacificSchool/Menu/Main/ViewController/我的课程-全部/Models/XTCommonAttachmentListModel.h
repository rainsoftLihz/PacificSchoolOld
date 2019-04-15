//
//  XTCommonAttachmentListModel.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/10.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTCommonAttachmentListModel : NSObject

@property (nonatomic,copy)NSString *attachmentId ;
@property (nonatomic,copy)NSString *belongId ;
@property (nonatomic,copy)NSString *belongType;
@property (nonatomic,copy)NSString *coopCode ;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *createUserId;
@property (nonatomic,copy)NSString *fileExtendName ;
@property (nonatomic,copy)NSString *fileOriginalName;
@property (nonatomic,copy)NSString *filePath ;
@property (nonatomic,copy)NSString *fileServerType;
@property (nonatomic,copy)NSString *fileSize ;
@property (nonatomic,copy)NSString *fileType ;
@property (nonatomic,copy)NSString *isAtLocal ;
@property (nonatomic,copy)NSString *tmpFilePath;

@end

NS_ASSUME_NONNULL_END
