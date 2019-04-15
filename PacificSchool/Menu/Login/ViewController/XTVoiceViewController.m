//
//  XTVoiceViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/14.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTVoiceViewController.h"
#import "XTRecordTool.h"
#import "AppDelegate.h"
#import "NSString+MD5.h"
#import "XTDesModel.h"

@interface XTVoiceViewController ()
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopRecordBtn;
@property (weak, nonatomic) IBOutlet UIButton *startRecordBtn;

@property (nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) int endTime;
@property(nonatomic,assign) int count;

@property (strong,nonatomic)XTRecordTool *recordTool;
@property (nonatomic,strong)NSArray *voiceTexts;
@property (nonatomic,strong)NSArray *voiceRegisterTexts;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation XTVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initDataVoice];
    [self initData];
    [self initUI];
}

- (void)initDataVoice {

    self.voiceRegisterTexts = @[@"太平洋保险以成为“行业健康稳定发展的引领者”为愿景，始终以客户需求为导向，专注保险主业，做精保险专业，创新保险产品和服务，提升客户体验，价值持续增长。寿险公司营运条线以客户为中心，加快人工智能与大数据核心技术驱动，为客户经营、营销活动和风险管理提供营运科技赋能，营造集健康、养老、生活和公益为一体的保险服务生态圈，引领人工智能服务新体验。智学院”智能培训平台是人工智能应用的重要举措之一，旨在通过人工智能赋能人才建设和队伍培训。该平台打造了“测、学、练、评”闭环培训新模式；通过声纹、活体验证，提升培训的真实性；通过人机互动场景式训练，提升培训的实战性；通过专业族群培训脸谱的刻画，实现“千人千面”的智能推课，提升培训的准确性。"];
    self.voiceTexts = @[@"在谋划中提出不一般的方案，在行动中拿出不寻常的措施，在落实中取得不平凡的成果",
                        @"客户体验最佳，业务质量最优，经营风险最低，成为行业健康稳定发展的引领者",
                        @"服务能级全面增强、智慧服务提速增效、客户体验领先市场、服务价值持续提升",
                        @"坚持价值持续增长，坚持协调平衡发展、坚持客户需求导向，坚持科技创新驱动",
                        @"为客户经营、营销活动和风险管理提供营运科技赋能，营造集健康、养老、生活和公益为一体的保险服务生态圈",
                        @"以人工智能和大数据为核心技术驱动，建立智能机器人体系平台",
                        @"人才支撑、数字太保、协同发展、战略管控、完善布局",
                        @"“智学院”智能培训平台是太平洋寿险公司践行转型2.0战略的重要举措之一",
                        @"智学院智能移动培训平台打造“测、学、练、评”闭环培训新模式，赋能人才建设和队伍培训",
                        @"智学院智能移动平台通过人机互动场景式训练，提高培训实战性",
                        @"智学院智能移动平台将通过声纹、活体检测验证，提升培训的真实性",
                        @"智学院智能移动平台刻画专业族群培训脸谱，实现“千人千面”智能推课",
                        @"太平洋保险以“做一家负责任的保险公司”为使命，平时注入一滴水，难时拥有太平洋",
                        @"太慧赔集客户端全场景理赔机器人智能交互服务、中端医疗数据互联、后端AI智能决策作业，以及增值健康管理服务为一体，打造行业领先的秒级闪赔模式",
                        @"核动力”智能核保服务，以人工智能为驱动，在业内率先迈入AI核保生产应用新时代，打造秒级核保模式",
                        @"“智享家”服务，颠覆传统柜面模式，以智能、交互、融合的3I服务为标准，打造集服务办理、客户经营、品牌宣传为一体的线上线下互通的“智享体验中心”。",
                        @"智享中心服务，通过智能语音机器人完成与客户的新契约电话回访，还可以与呼入的客户完成语音互动应答，简化客户操作，提高沟通效率。",
                        @"以客户俱乐部为载体，建设“保险服务+延伸服务”生态圈，打造客户服务与客户经营融合的有温度的服务体系",
                        @"太平洋寿险客户服务体系的实施路径是：保险服务智能化、延伸服务生态化、体系运营平台化",
                        ];
    
}

- (void)initData {
    
    self.endTime = 0;
    
    self.recordTool = [XTRecordTool new];
    __weak typeof(self) __weakSelf = self;
    self.recordTool.eventBlock = ^(NSString * _Nonnull filePath, NSString * _Nonnull fileName) {{
        NSLog(@"文件地址 %@",filePath);
        if (__weakSelf.voiceType == XTVoiceRegisterType) {
            
            if (__weakSelf.count>59) {
                
                [__weakSelf requestUploadRegiseterVoice:filePath fileName:fileName];

            } else {
                [__weakSelf showStatusInfo:@"录制声纹必须大于一分钟"];
                __weakSelf.count = 0;
                __weakSelf.timeLabel.text = @"00:00";
                __weakSelf.timeLabel.hidden = YES;
            }
        }else {
            [__weakSelf requestUploadLoginVoice:filePath fileName:fileName];
        }
    }
        
    };
}

- (void)requestUploadRegiseterVoice:(NSString *)filePath fileName:(NSString *)fileName {
    
    NSString *identifierId = self.param[@"data"][@"frontUser"][@"frontUserId"];
    NSDictionary *param = @{@"identifierId":identifierId,
                            @"type":@"1",
                            @"file":fileName,
                            };
    NSLog(@"  param ====  %@",param);
    [self show];
    WeakSelf
    [LTNetWorkManager upload_fileWithUrl:kVoiceRegister param:param file:filePath fileName:fileName mimeType:@"mp3" success:^(NSDictionary *dic) {
        [weakSelf hide];
        
        weakSelf.timeLabel.text = @"00:00";
        weakSelf.timeLabel.hidden = YES;
        if ([dic[@"status"] isEqualToString:@"1"]) {
            
            [weakSelf updateVoiceMessage];
        }else {
            [weakSelf showStatus:@"请录一分钟以上"];
        }
        
    } fail:^(NSString *msg) {
        [weakSelf showStatus:msg];
    }];
    
}

- (void)requestUploadLoginVoice:(NSString *)filePath fileName:(NSString *)fileName {
    NSString *identifierId = DEF_PERSISTENT_GET_OBJECT(kUserId);
    NSDictionary *param = @{@"identifierId":identifierId,
                            @"type":@"1",
                            @"file":fileName,
                            };
    WeakSelf
    [weakSelf show];
    [LTNetWorkManager upload_fileWithUrl:kVoiceAuthentication param:param file:filePath fileName:fileName mimeType:@"mp3" success:^(NSDictionary *dic) {
        NSLog(@"声纹登录 %@",dic);
        
        NSString *status = dic[@"status"];
        NSString *score = dic[@"score"];
        NSString *errorMsg = dic[@"errorMsg"];
        NSString *code = dic[@"code"];

        self.logTextView.text  = [NSString stringWithFormat:@"code:%@\nstatus:%@\nscore:%@\nmsg:%@",code,status,score,errorMsg];
        
        [weakSelf hide];
        weakSelf.timeLabel.text = @"00:00";
        weakSelf.timeLabel.hidden = YES;
        if ([dic[@"status"] isEqualToString:@"1"]) {
            
            int score = [dic[@"score"] floatValue]*100;
            if (score>50) {
//                DEF_PERSISTENT_SET_OBJECT(@"Y", kIsLogin);
//                [weakSelf switchVC];
                
                [weakSelf loginRequest];
                
            }else {
                [weakSelf showStatus:@"声纹验证不是本人"];
            }
            
        }else {
            
            if([dic[@"code"] isEqualToString:@"VP1001"]){
                
                [weakSelf showStatusInfo:@"未检测到声纹,请重试!"];
                
            }else {
                [weakSelf showStatusInfo:@"声纹验证失败请重试!"];
            }
            
        }
        
    } fail:^(NSString *msg) {
        [weakSelf showStatus:msg];

    }];
    
}

- (void)updateVoiceMessage {
    
    [self show];
    NSString *frontUserId = self.param[@"data"][@"frontUser"][@"frontUserId"];
    NSString *accessToken = self.param[@"data"][@"frontUser"][@"accessToken"];
    NSString *isCollectedVoice = @"Y";
    NSString *coopCode = @"cpic";
    
    NSDictionary *param = @{@"frontUserId":frontUserId,
                            @"accessToken":accessToken,
                            @"isCollectedVoice":isCollectedVoice,
                            @"coopCode":coopCode
                            };
    WeakSelf
    [LTNetWorkManager loginFirstPost:kUpdateVoiceCollectStatus params:param success:^(NSDictionary *result) {
        [weakSelf hide];
        if ([result[@"ret"] isEqualToString:@"0"]) {
            
            [weakSelf saveLocation];
            [weakSelf switchVC];
        }else {
            [weakSelf showStatus:@"更新信息失败"];
        }
        NSLog(@"reslut %@",result);
        
    } failure:^(NSString *msg) {
        
    }];
    
}

#pragma mark - 切换视图
- (void)switchVC {
    
    __weak AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate  switchRootViewController:YES];
    
}

#pragma mark - 注册成功登录
- (void)saveLocation {
    
    NSString *user_id = self.param[@"data"][@"frontUser"][@"frontUserId"];
    NSString *token = self.param[@"data"][@"accessToken"];
    NSString *username = self.param[@"data"][@"frontUser"][@"username"];
    NSString *nickname = self.param[@"data"][@"frontUser"][@"nickname"];
    NSString *headimgurl = self.param[@"data"][@"frontUser"][@"headimgurl"];
    
    NSString *orgName = self.param[@"data"][@"frontUser"][@"orgName"];
    NSString *posName = self.param[@"data"][@"frontUser"][@"posName"];
    NSString *realName = self.param[@"data"][@"frontUser"][@"realName"];

    NSString *psd = self.param[@"psd"];
    
    DEF_PERSISTENT_SET_OBJECT(user_id, kUserId);
    DEF_PERSISTENT_SET_OBJECT(token, kUserToken);
    DEF_PERSISTENT_SET_OBJECT(username, kUserName);
    DEF_PERSISTENT_SET_OBJECT(nickname, kNickName);
    DEF_PERSISTENT_SET_OBJECT(headimgurl, kHeadImgUrl);
    
    DEF_PERSISTENT_SET_OBJECT(realName, kRealName);
    DEF_PERSISTENT_SET_OBJECT(orgName, kOrgName);
    DEF_PERSISTENT_SET_OBJECT(posName, kPosName);
    
    DEF_PERSISTENT_SET_OBJECT(psd, kUserPSD);

    DEF_PERSISTENT_SET_OBJECT(@"Y",kIsLogin);
}

- (void)initUI {
    
    [self.startRecordBtn addTarget:self action:@selector(startRecordEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.stopRecordBtn addTarget:self action:@selector(stopRecordEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.voiceType == XTVoiceRegisterType) {
        int x = arc4random() % self.voiceRegisterTexts.count;
        self.contentLabel.text = self.voiceRegisterTexts[x];
        [self showTitle];
        
    }else {
        int x = arc4random() % self.voiceTexts.count;
        self.contentLabel.text = self.voiceTexts[x];
    }
    
    self.stopRecordBtn.hidden = YES;
    self.timeLabel.hidden = YES;
}

- (void)startRecordEvent:(UIButton *)btn {
    
    [self.recordTool clearCafFile];
    
    self.startRecordBtn.hidden = YES;
    self.bottomLabel.text = @"点击波纹完成录音";
    self.stopRecordBtn.hidden = NO;
    [self.recordTool startRecord];
    
    if (self.voiceType == XTVoiceRegisterType) {
    
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(repeatShowTime:) userInfo:@"admin" repeats:YES];
        self.count = 0;
        self.timeLabel.text = @"00:00";
        self.timeLabel.hidden = NO;
    }
    
}

- (void)repeatShowTime:(NSTimer *)timer {
    
    self.count++;
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",self.count/60,self.count%60];
}

- (void)stopRecordEvent:(UIButton *)btn {
    
    self.startRecordBtn.hidden = NO;
    self.stopRecordBtn.hidden = YES;
    self.bottomLabel.text = @"点击上方按钮,朗读上方内容";
    [self.recordTool doneRecordNotice];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timeLabel.hidden = YES;
}

- (void)showTitle {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示!" message:@"现在开始声纹注册,将用于智学院平台的身份识别和学习、通关考的真实性验证,请确认是您本人,一旦注册成功将无法变更,请在提示语结束后,按照您的日常交流习惯完整诵读注册语料(备注:采集过程需一分钟以上)" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

- (void)showLoginTitle {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示!" message:@"现在开始声纹注册,将用于智学院平台的身份识别和学习、通关考的真实性验证,请确认是您本人,一旦注册成功将无法变更,请在提示语结束后,按照您的日常交流习惯完整诵读注册语料(备注:采集过程需一分钟以上)" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}

- (void)dealloc {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (NSDictionary *)getLoginParam {
    
    NSString *username = DEF_PERSISTENT_GET_OBJECT(kUserName);
    NSString *password = DEF_PERSISTENT_GET_OBJECT(kUserPSD);
    NSString *API_SECRET_CODE = @"@safty@";
    NSString *coopCode = @"cpic";
    
    NSString *md5psd = [password MD5Digest];
    NSString *allString = [NSString stringWithFormat:@"%@%@%@",username,md5psd,API_SECRET_CODE];
    NSString *verifyCode = [allString MD5Digest];
    
    NSString *passwordDES = [XTDesModel encryptUseDES2:password key:@"cpic@des"];
    
    NSDictionary *param = @{@"username":username,
                            @"password":md5psd,
                            @"coopCode":coopCode,
                            @"verifyCode":verifyCode,
                            @"passwordDES":passwordDES
                            };
    return param;
}

- (void)saveLocation:(NSDictionary *)result {
    
    NSString *user_id = result[@"data"][@"frontUser"][@"frontUserId"];
    NSString *token = result[@"data"][@"accessToken"];
    NSString *username = result[@"data"][@"frontUser"][@"username"];
    NSString *nickname = result[@"data"][@"frontUser"][@"nickname"];
    NSString *headimgurl = result[@"data"][@"frontUser"][@"headimgurl"];
    
    NSString *orgName = result[@"data"][@"frontUser"][@"orgName"];
    NSString *posName = result[@"data"][@"frontUser"][@"posName"];
    NSString *realName = result[@"data"][@"frontUser"][@"realName"];
    //NSString *psd = result[@"psd"];
    
//    NSLog(@"保存psd == %@",psd);
    
    DEF_PERSISTENT_SET_OBJECT(user_id, kUserId);
    DEF_PERSISTENT_SET_OBJECT(token, kUserToken);
    DEF_PERSISTENT_SET_OBJECT(username, kUserName);
    DEF_PERSISTENT_SET_OBJECT(nickname, kNickName);
    DEF_PERSISTENT_SET_OBJECT(headimgurl, kHeadImgUrl);
    
    DEF_PERSISTENT_SET_OBJECT(realName, kRealName);
    DEF_PERSISTENT_SET_OBJECT(orgName, kOrgName);
    DEF_PERSISTENT_SET_OBJECT(posName, kPosName);
    //DEF_PERSISTENT_SET_OBJECT(psd, kUserPSD);
    DEF_PERSISTENT_SET_OBJECT(@"Y",kIsLogin);
    
}

- (void)loginRequest {
    
    WeakSelf
    [LTNetWorkManager loginFirstPost:kApiLogin params:[self getLoginParam] success:^(NSDictionary *result) {
        NSLog(@" 登录成功 %@",result);
        if ([result[@"err_code"] isEqual:@1006]) {
            
            [weakSelf showErrorStatus:result[@"msg"]];
            
        }else if([result[@"ret"] isEqualToString:@"0"]) {
            
            [weakSelf saveLocation:result];
            [weakSelf switchVC];

        }else {
            [weakSelf showErrorStatus:result[@"msg"]];
        }
        
    } failure:^(NSString *msg) {
        
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
