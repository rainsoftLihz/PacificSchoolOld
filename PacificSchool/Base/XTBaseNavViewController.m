//
//  XTBaseNavViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/24.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseNavViewController.h"

@interface XTBaseNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation XTBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.backgroundColor = kMainColor;
    
    self.interactivePopGestureRecognizer.enabled = YES;
    //  self.interactivePopGestureRecognizer.delegate = self;
    __weak typeof(self) weakself = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = (id)weakself;
    }
    
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
    button.frame = CGRectMake(0, 44/2.0-20/2.0, 32.0/3.0, 60.0/3.0);
 
    [button setBackgroundImage:[UIImage imageNamed:@"backNav"] forState:0];
    [button addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(0, 0, 44, 44);
    [clearBtn addSubview:button];
    [clearBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearBtn];
    return someBarButtonItem;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        // 屏蔽调用rootViewController的滑动返回手势
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
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
