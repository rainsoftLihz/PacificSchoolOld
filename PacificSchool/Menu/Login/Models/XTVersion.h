//
//  XTVersion.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/16.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTVersion : NSObject

//下载地址
@property(nonatomic,strong) NSString* downloadUrl;

//是否强制更新
@property(nonatomic,strong) NSString* isForceUpdate;

//描述信息
@property(nonatomic,strong) NSString* versionDesc;

//版本名称
@property(nonatomic,strong) NSString* versionName;

//版本号
@property(nonatomic,strong) NSString* versionNo;

-(BOOL)needUpdate;

@end

NS_ASSUME_NONNULL_END
