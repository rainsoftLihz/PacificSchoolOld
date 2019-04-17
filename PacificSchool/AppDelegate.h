//
//  AppDelegate.h
//  PacificSchool
//
//  Created by Jonny on 2019/1/16.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)switchRootViewController:(BOOL)isLogin;

-(void)goToLogin;

@end

