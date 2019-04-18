//
//  UserDefine.h
//  PacificSchool
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 Jonny. All rights reserved.
//

#ifndef UserDefine_h
#define UserDefine_h

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height

#define kMainColor [UIColor colorWithRed:0 green:126.f/255.f blue:217.f/250.f alpha:1]
#define kColorRGB(r,g,b) [[UIColor alloc]initWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1]

#define kFont(size) [UIFont systemFontOfSize:size]


/* 用户名 用户ID token*/
#define kUserName @"kUserName"
#define kUserPSD @"kUserPSD"

#define kUserId   @"kUserId"
#define kUserToken  @"kUserToken"
#define kNickName  @"kNickName"
#define kHeadImgUrl  @"kHeadImgUrl"
#define kRealName  @"kRealName"
//岗位
#define kPosName  @"kPosName"
//部门
#define kOrgName  @"kOrgName"
//是否登录过
#define kIsLogin  @"kIsLogin"
#define kStudyTime  @"kStudyTime"

#define kErrcode7777 @"kErrcode7777"

#define DEF_PERSISTENT_GET_OBJECT(key)  [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define kUserDefaults [NSUserDefaults standardUserDefaults]


#define DEF_PERSISTENT_SET_OBJECT(object, key)                          \
({                                                                      \
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];       \
[defaults setObject:object forKey:key];                                 \
[defaults synchronize];                                                  \
})

#define WeakSelf __weak typeof(self) weakSelf = self;

#define NSLog(FORMAT, ...) printf("[文件名:%s]\n[函数名:%s]\n%s\n",__FILE__,__FUNCTION__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


//#ifdef DEBUG //开发阶段
//#define NSLog(format,...) printf("%s",[[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])
//#else //发布阶段
//#define NSLog(...)
//#endif


// 判断iPhone X
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define kSafeArea (kDevice_Is_iPhoneX ? 34 : 0)



#endif /* UserDefine_h */
