//
//  BaseTabBarViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/24.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseTabBarViewController.h"
#import "XTBaseNavViewController.h"
@interface XTBaseTabBarViewController ()
@property (nonatomic,strong)NSArray *titleAry;
@property (nonatomic,strong)NSArray *imageNamesN;
@property (nonatomic,strong)NSArray *imageNamesS;
@property (nonatomic,strong)NSArray *viewControllerAay;
@end

@implementation XTBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self configTab];
}

#pragma mark -  初始化数据
- (void)initData {
    
    //self.titleAry = @[@"首页",@"课程",@"学习",@"学友圈",@"我的"];
    self.titleAry = @[@"课程",@"学院",@"我的"];
    self.imageNamesN = @[[UIImage imageNamed:@"main_n"],[UIImage imageNamed:@"library_n"],[UIImage imageNamed:@"me_n"]];
//
    self.imageNamesS = @[[UIImage imageNamed:@"main_s"],[UIImage imageNamed:@"library_sel"],[UIImage imageNamed:@"me_sel"]];
    
    self.viewControllerAay = @[@"XTMainViewController",@"XTLibraryViewController",@"XTMeViewController"];
}

#pragma mark -  配置底部按钮
- (void)configTab {
    
    
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor grayColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateNormal];
//
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: kColorRGB(36, 153, 220), NSForegroundColorAttributeName, [UIFont systemFontOfSize:13], NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    NSMutableArray *vcs = [NSMutableArray array];
    
    for (int i = 0;i < self.viewControllerAay.count; i++ ) {
        
        NSString *vcStr = self.viewControllerAay[i];
        Class viewController =  NSClassFromString(vcStr);
        
        XTBaseNavViewController *nav;
        
        UIViewController *viewCtr = (UIViewController *)[[viewController alloc]init];
        viewCtr.title = self.titleAry[i];
        viewCtr.tabBarItem.selectedImage = self.imageNamesS[i];
        viewCtr.tabBarItem.image = self.imageNamesN[i];
        
        nav = [[XTBaseNavViewController alloc]initWithRootViewController:viewCtr];
        [vcs addObject:nav];
        self.tabBarItem.title = self.titleAry[i];
    }
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [[UIColor alloc]initWithRed:33/255.0 green:150/255.0 blue:223/255.0 alpha:1];
    self.selectedIndex = 0;
    self.viewControllers = vcs;
    
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
