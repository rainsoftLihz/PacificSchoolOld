//
//  XTVoiceViewController.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/14.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseViewController.h"

typedef NS_ENUM(NSInteger, XTVoiceType) {
    XTVoiceRegisterType,
    XTVoiceLoginType
};

NS_ASSUME_NONNULL_BEGIN

@interface XTVoiceViewController : XTBaseViewController

@property (nonatomic,assign)XTVoiceType voiceType;
@property (nonatomic,strong)NSDictionary *param;

@end

NS_ASSUME_NONNULL_END
