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
    UIImageView* imgv = [[UIImageView alloc] init];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:imgv];
    
    CGFloat  imgSize = 180;
    imgv.image = [UIImage imageNamed:@"WechatIMG87"];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(44);
        make.size.mas_equalTo(CGSizeMake(imgSize, imgSize));
        
    }];
    
    UIImageView* imgvAndrod = [[UIImageView alloc] init];
    [self.view addSubview:imgvAndrod];
    imgvAndrod.image = [UIImage imageNamed:@"QRAndrod"];
    [imgvAndrod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(imgSize, imgSize));
        make.top.mas_equalTo(imgv.mas_bottom).offset(20);
    }];
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
