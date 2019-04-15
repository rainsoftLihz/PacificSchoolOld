//
//  XTBaseViewController.h
//  PacificSchool
//
//  Created by Jonny on 2019/2/24.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTBaseViewController : UIViewController

/* 数据加载UI相关 */
- (void)show;
- (void)showLoading;
- (void)showError;
- (void)showSuccess;
- (void)hide;
- (void)showStatus:(NSString *)info;
- (void)showErrorStatus:(NSString *)status;
- (void)showStatusInfo:(NSString *)info;
- (void)showStatusInfoWithTimeInterval:(NSTimeInterval)timeInterval text:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
