//
//  Definition.h
//  MSCDemo
//
//  Created by iflytek on 13-6-6.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlyVoiceManager.h"
#import "IATConfig.h"
#import "ISRDataHelper.h"
#define Margin  5
#define Padding 10
#define iOS7TopMargin 64 //导航栏44，状态栏20
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending )
#define ButtonHeight 44
#define NavigationBarHeight 44

#define APPID_VALUE           @"5c89c022"
#define URL_VALUE             @""                 // url
#define TIMEOUT_VALUE         @"20000"            // timeout      连接超时的时间，以ms为单位
#define BEST_URL_VALUE        @"1"                // best_search_url 最优搜索路径

#define SEARCH_AREA_VALUE     @"安徽省合肥市"
#define ASR_PTT_VALUE         @"1"
#define VAD_BOS_VALUE         @"5000"
#define VAD_EOS_VALUE         @"1800"
#define PLAIN_RESULT_VALUE    @"1"
#define ASR_SCH_VALUE         @"1"

#define SAVE_VALUE(idkey,idvalue)       [[NSUserDefaults standardUserDefaults] setValue:idvalue forKey:idkey];      \
[[NSUserDefaults standardUserDefaults] synchronize];

#define LOAD_VALUE(idkey)               [[NSUserDefaults standardUserDefaults] valueForKey:idkey]

#define REMOVE_VALUE(idKey)             [[NSUserDefaults standardUserDefaults] removeObjectForKey:idKey];           \
[[NSUserDefaults standardUserDefaults] synchronize];

#define kRefreshTheDrugConsultTextField @"voiceTextback"

#define kVoiceError @"voiceErrork"

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_CENTER NSTextAlignmentCenter
#else
# define IFLY_ALIGN_CENTER UITextAlignmentCenter
#endif

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_LEFT NSTextAlignmentLeft
#else
# define IFLY_ALIGN_LEFT UITextAlignmentLeft
#endif
