//
//  XTBaseNavViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/24.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseNavViewController.h"

@interface XTBaseNavViewController ()

@end

@implementation XTBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.backgroundColor = kMainColor;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];

}

- (UIImage*)createImageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        // 如果不是答题的界面就设置🔙按钮
//        if (![viewController isKindOfClass:[LTAnswerExamViewController class]]) {
        
            [viewController setHidesBottomBarWhenPushed:YES];
            viewController.navigationItem.leftBarButtonItem = [self setBackButtonItem];
//        }
    }
    
    [super pushViewController:viewController animated:animated];
}
- (UIBarButtonItem *)setBackButtonItem {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 20, 20);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [button setImage:[UIImage imageNamed:@"return"] forState:0];
    [button addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return someBarButtonItem;
}

- (void)backViewController {
    
    [self popViewControllerAnimated:YES];
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
