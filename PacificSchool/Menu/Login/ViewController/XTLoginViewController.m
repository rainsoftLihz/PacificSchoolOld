//
//  XTLoginViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/13.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTLoginViewController.h"
#import "AppDelegate.h"
#import "NSString+MD5.h"
#import "XTVoiceViewController.h"
#import "XTDesModel.h"


@interface XTLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;
@property (weak, nonatomic) IBOutlet UIButton *voiceLoginBtn;

@end

@implementation XTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}

- (void)initData {
    NSString* userName = DEF_PERSISTENT_GET_OBJECT(kUserName);
    if (userName && userName.length > 0) {
        self.accountTF.text = userName;
    }
}

- (void)initUI {
    
    self.logBtn.backgroundColor = kMainColor;
    
}
- (IBAction)voiceEventBtn:(id)sender {
    
    if (DEF_PERSISTENT_GET_OBJECT(kIsLogin)==nil) {
        [self showStatus:@"请先账号登录"];
        return;
        
    }else {
        
        XTVoiceViewController *voice = [XTVoiceViewController new];
        voice.title = @"声纹登录";
        voice.voiceType = XTVoiceLoginType;
        [self.navigationController pushViewController:voice animated:YES];
    }
}

- (IBAction)loginEvent:(id)sender {
    
    if (self.accountTF.text.length==0 &&self.passwordTF.text.length==0) {
        [self showErrorStatus:@"请登录信息填写完整"];
    }else {
        [self loginRequest];
    }
}

- (void)loginRequest {
    
    WeakSelf
    [LTNetWorkManager loginFirstPost:kApiLogin params:[self getLoginParam] success:^(NSDictionary *result) {
        NSLog(@" 登录成功 %@",result);
        if ([result[@"err_code"] isEqual:@1006]) {
            
            [weakSelf showStatusInfoWithTimeInterval:3 text:result[@"msg"]];

        }else if([result[@"ret"] isEqualToString:@"0"]) {
            
            // 验证声纹
            [weakSelf voiceRegisterStatus:result];
            
        }else {
            
            [weakSelf showStatusInfoWithTimeInterval:3 text:result[@"msg"]];
        }
        
    } failure:^(NSString *msg) {
        
        [weakSelf showStatusInfo:msg];
    }];
    
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
    
    DEF_PERSISTENT_SET_OBJECT(user_id, kUserId);
    DEF_PERSISTENT_SET_OBJECT(token, kUserToken);
    DEF_PERSISTENT_SET_OBJECT(username, kUserName);
    DEF_PERSISTENT_SET_OBJECT(nickname, kNickName);
    DEF_PERSISTENT_SET_OBJECT(headimgurl, kHeadImgUrl);
    
    DEF_PERSISTENT_SET_OBJECT(realName, kRealName);
    DEF_PERSISTENT_SET_OBJECT(orgName, kOrgName);
    DEF_PERSISTENT_SET_OBJECT(posName, kPosName);
    DEF_PERSISTENT_SET_OBJECT(self.passwordTF.text, kUserPSD);
    DEF_PERSISTENT_SET_OBJECT(@"Y",kIsLogin);
    
}

- (void)switchVC {
    
    __weak AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate  switchRootViewController:YES];
    
}

// 查询是否注册过
- (void)voiceRegisterStatus:(NSDictionary *)result {
    
    NSString *user_id = result[@"data"][@"frontUser"][@"frontUserId"];
    NSString *token = result[@"data"][@"accessToken"];
    
    NSDictionary *param = @{@"frontUserId":user_id,
                            @"accessToken":token,
                            @"coopCode":@"cpic",
                            };
    
    WeakSelf
    [LTNetWorkManager loginFirstPost:kGetVoiceCollectStatus params:param success:^(NSDictionary *results) {
        
        [weakSelf hide];
        NSLog(@"是否注册 %@",results);
        if (![results[@"data"][@"isCollectedVoice"] isEqualToString:@"Y"]) {
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示!" message:@"检测到您的账号没有进行声纹采集,请先进行声纹采集" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"声纹采集" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                XTVoiceViewController *vc = [XTVoiceViewController alloc];
                NSMutableDictionary *allDic = [[NSMutableDictionary alloc]initWithDictionary:result];
                [allDic setObject:self.passwordTF.text forKey:@"psd"];
                vc.param = [allDic copy];
                vc.title = @"声纹注册";
            
                vc.voiceType = XTVoiceRegisterType;
                [weakSelf.navigationController pushViewController:vc animated:YES];
                
            }];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:^{
                
            }];
            
        }else {
            
            [weakSelf saveLocation:result];
            [weakSelf switchVC];
            
        }
        
    } failure:^(NSString *msg) {
        [weakSelf showStatus:msg];
    }];
    
}

- (NSDictionary *)getLoginParam {

    NSString *username = self.accountTF.text;
    NSString *password = self.passwordTF.text;
    NSString *API_SECRET_CODE = @"@safty@";
    NSString *coopCode = @"cpic";
    
    NSString *md5psd = [password MD5Digest];
    NSString *allString = [NSString stringWithFormat:@"%@%@%@",username,md5psd,API_SECRET_CODE];
    NSString *verifyCode = [allString MD5Digest];
    
    NSString *passwordDES = [XTDesModel encryptUseDES2:self.passwordTF.text key:@"cpic@des"];
    
    NSDictionary *param = @{@"username":username,
                            @"password":md5psd,
                            @"coopCode":coopCode,
                            @"verifyCode":verifyCode,
                            @"passwordDES":passwordDES
                            };
    return param;
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
