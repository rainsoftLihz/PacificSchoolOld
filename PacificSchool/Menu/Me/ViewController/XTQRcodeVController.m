//
//  XTQRcodeVController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/17.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "XTQRcodeVController.h"

@interface XTQRcodeVController ()

@end

@implementation XTQRcodeVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"APP下载二维码";
    UIImageView* imgv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imgv];
    imgv.image = [UIImage imageNamed:@"launch"];
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
