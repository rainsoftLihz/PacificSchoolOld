//
//  AppDelegate.m
//  PacificSchool
//
//  Created by Jonny on 2019/1/16.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "AppDelegate.h"
#import "XTLoginViewController.h"
#import "XTMainViewController.h"
#import "XTBaseTabBarViewController.h"
#import "XTBaseNavViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Speech/Speech.h>
#import "XTDesModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSString *des = [XTDesModel encodeDesWithString:@"5tgb^YHN" key:@""];
    
    //NSString *des = [XTDesModel encryptUseDES2:@"123456" key:@"cpic@des"];
    //NSLog(@" des 加密 %@",des);
    sleep(2);
    [self switchRootViewController:NO];
    [self getRecord];
    
    return YES;
}

-(void)getRecord{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if ([session respondsToSelector:@selector(requestRecordPermission:)]) {
        [session performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }];
    } else {
    }
    
    // 请求权限
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        NSLog(@"status %@", status == SFSpeechRecognizerAuthorizationStatusAuthorized ? @"授权成功" : @"授权失败");
    }];
    
    
}
#pragma mark - 切换视图
- (void)switchRootViewController:(BOOL)isLogin {

    
    if ([DEF_PERSISTENT_GET_OBJECT(kIsLogin) isEqualToString:@"N"]||DEF_PERSISTENT_GET_OBJECT(kIsLogin) == nil) {
        XTBaseNavViewController *nav = [[XTBaseNavViewController alloc]initWithRootViewController:[XTLoginViewController new]];
        self.window.rootViewController = nav;
       
        
    } else {
    
        XTBaseTabBarViewController *tabBar = [[XTBaseTabBarViewController alloc]init];
        tabBar.selectedIndex = 0;
        self.window.rootViewController = tabBar;
    }
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
