//
//  XTBaseViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/24.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseViewController.h"

@interface XTBaseViewController ()

@end

@implementation XTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}
#pragma mark - 数据加载UI相关
- (void)show {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
}

- (void)showLoading {
    [SVProgressHUD showWithStatus:@"加载中"];
}

- (void)showError {
    [self afterHide];
    [SVProgressHUD showErrorWithStatus:@"网络错误"];
}

- (void)showSuccess {
    [self afterHide];
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
}

- (void)showStatus:(NSString *)status {
    [self afterHide];
    [SVProgressHUD showSuccessWithStatus:status];
}

- (void)showErrorStatus:(NSString *)status {
    [self afterHide];
    [SVProgressHUD showErrorWithStatus:status];
}

- (void)showStatusInfo:(NSString *)info {
    [self afterHide];
    [SVProgressHUD showInfoWithStatus:info];
    
}

- (void)showStatusInfoWithTimeInterval:(NSTimeInterval)timeInterval text:(NSString *)text {
    
    [SVProgressHUD setMaximumDismissTimeInterval:timeInterval];
    [SVProgressHUD showInfoWithStatus:text];
}


- (void)afterHide {
    [SVProgressHUD setMaximumDismissTimeInterval:1];
    
}

- (void)hide {
    [SVProgressHUD dismiss];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
