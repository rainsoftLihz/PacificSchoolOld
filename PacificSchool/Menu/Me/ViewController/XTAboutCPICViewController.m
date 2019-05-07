//
//  XTAboutCPICViewController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/17.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "XTAboutCPICViewController.h"

@interface XTAboutCPICViewController ()

@end

@implementation XTAboutCPICViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat navigationBarAndStatusBarHeight = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    UITextView* text = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-navigationBarAndStatusBarHeight)];
    text.backgroundColor = UIColor.whiteColor;
    text.editable = NO;
    text.scrollEnabled = YES;
    [self.view addSubview:text];
    self.title = @"关于智学院";
    text.font = [UIFont systemFontOfSize:14.0];
    text.textColor = UIColor.blackColor;
    
    text.text = @"\n  智学院”智能培训平台，是太保寿险利用人工智能技术在培训领域的最新应用探索，是践行公司转型2.0战略的重要举措之一，是营运条线\“2+5+1\“转型项目集中的V07项目。\n智学院项目旨在通过人工智能赋能人才建设和队伍培训\n【智学院解决什么问题】培训资源不足，覆盖面低；针对性不足；真实性无法保证；效果不好跟踪；培训形式单一，实战性差；内容准备和网络课件更新不及时。\n【智学院集成哪些技术】语音识别/合成、语义理解、声纹识别、人机互动、情绪识别、活体验证、机器情景语料学习和训练等技术。\n【智学院具有哪些特色】特色1：“测、学、练、评”闭环培训新模式；\n特色2：通过声纹、活体验证，提升培训的真实性；\n特色3：通过人机互动场景式训练，提升培训的实战性；\n特色4：通过专业族群培训脸谱的刻画，实现“千人千面”的智能推课，提升培训的精确性；\n特色5：支持内容上传、审核，课程配置，任务分发的分级管理、授权；\n特色6：配套体系化的队伍培训和内容统筹机制。\n【谁参与了智学院研发】智学院项目由寿险公司营运条线发起，由营运企划部牵头，同时集合了集团科技运营中心，寿险公司核保核赔部、客户服务部，郑州和长沙营运中心，北京、吉林省、安徽、深圳等分公司的智慧。他们是：\n业务组：曾乃奎（产品经理）、李婷、丁胜、燕然之、潘亚欧、战希霞、宋慧卿、孙德梅、史颖、封巧华、赵美娟、李超、季靖、王星惠\n技术组：史鸿勇（IT项目经理）、尚志明、何斐、郑佳佳，以及科大讯飞提供的技术支持\n【智学院将有哪些拓展】与人才队伍建设和培训体系、资质评定对接；支持每天日常培训内容发布；学习竞赛；积分学豆体系和应用等。\n【智学院不好用怎么破】界面不好看、流程不顺畅、功能不全面、过程太复杂，都欢迎大家联系项目组，或提出您的建议、方案，加入项目组，与我们一起不停优化。";
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
