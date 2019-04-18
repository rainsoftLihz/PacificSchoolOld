//
//  XTSettingViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/4.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTSettingViewController.h"
#import "XTSettingTableViewCell.h"
#import "AppDelegate.h"
#import "XTMainViewModel.h"
#import "LTPickerView.h"
#import "XTMeViewModel.h"

@interface XTSettingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *models;
@property (nonatomic,strong)NSArray *values;
@end

@implementation XTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}

- (void)initData {
    
//    self.models = @[@"账号",@"昵称",@"姓名",@"手机",@"部门",@"岗位",@"头像",@"修改密码"];
    self.models = @[@"账号",@"姓名",@"部门",@"岗位",@"头像"];
  
    NSString *UserId = DEF_PERSISTENT_GET_OBJECT(kUserName);
    NSString *RealName = DEF_PERSISTENT_GET_OBJECT(kRealName);
    NSString *OrgName = DEF_PERSISTENT_GET_OBJECT(kOrgName);
    NSString *PosName = DEF_PERSISTENT_GET_OBJECT(kPosName);
    NSString *HeadImgUrl = DEF_PERSISTENT_GET_OBJECT(kHeadImgUrl);
    if (PosName ==nil) {
        PosName = @"";
        
    }if (HeadImgUrl == nil) {
        HeadImgUrl = @"";
    }
    if (OrgName == nil) {
        OrgName=@"";
    }
    if (PosName == nil) {
        PosName=@"";
    }
    
    self.values = @[UserId,RealName,OrgName,PosName,HeadImgUrl];
    
    [self.tableView reloadData];

}

- (void)initUI {
    
    self.title = @"个人信息";
 
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib: [UINib nibWithNibName:@"XTSettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 50;
    
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.frame = CGRectMake(0, 0, 44, 44);
    [logoutBtn setTitle:@"退出登录" forState:0];
    logoutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    logoutBtn.backgroundColor = kMainColor;
    [logoutBtn addTarget:self action:@selector(logoutBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.layer.cornerRadius = 5;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 50)];
    [footView addSubview:logoutBtn];
    [logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(footView);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(35);
    }];
    
    self.tableView.tableFooterView = footView;
}

- (void)logoutBtnEvent {
    NSLog(@"logout");

//    [kUserDefaults removeObjectForKey:kUserName];
//    [kUserDefaults removeObjectForKey:kNickName];
//    [kUserDefaults removeObjectForKey:kUserId];
//    [kUserDefaults removeObjectForKey:kUserToken];
//    [kUserDefaults removeObjectForKey:kHeadImgUrl];
//
//    [kUserDefaults removeObjectForKey:kRealName];
//    [kUserDefaults removeObjectForKey:kOrgName];
//    [kUserDefaults removeObjectForKey:kPosName];
//    [kUserDefaults setObject:@"N" forKey:kIsLogin];
   
    
    [XTMainViewModel logout:^(NSDictionary * _Nonnull result) {
        
        [kUserDefaults removeObjectForKey:kUserToken];
        [kUserDefaults setObject:@"N" forKey:kIsLogin];
        __weak AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate  switchRootViewController:NO];
    }];
    
    
}

#pragma mark - UITabelViewCellDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XTSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.titleLabel.text = self.models[indexPath.row];
    cell.subLabel.text = self.values[indexPath.row];
    if (indexPath.row == 4) {
        cell.headImageView.hidden = NO;
        NSString *url = [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,self.values[indexPath.row]];
        
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"account_avatar"]];
        cell.subLabel.hidden = YES;
    }else {
        cell.headImageView.hidden = YES;
        cell.subLabel.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
        
        [self selectorPhoto];
        
    }
    
}

#pragma mark - 选择照片
- (void)selectorPhoto {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 拍照
    UIAlertAction *photographAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectorActionIndex:0];
    }];
    [alertController addAction:photographAction];
    
    // 相册
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectorActionIndex:1];
    }];
    [alertController addAction:photoAction];
    
    // 取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 选择相机
- (void)selectorActionIndex:(NSInteger )index {
    
    // 1、创建ZFImagePicker对象
    LTPickerView *picker = [[LTPickerView alloc] init];
    
    picker.isEdit = YES;
    
    if (index == 0) {
        
        // 2、设置图片来源(若不设置默认来自相机)
        picker.sType = SourceTypeCamera;
        
    }else if(index == 1){
        
        // 3、设置来自图片库
        picker.sType = SourceTypeLibrary;
    }
    
    // 实现block回调
    picker.pickImage = ^(UIImage *image,NSString *type,NSString *name){
        
        NSLog(@"\n 原图 image:%@\n type:%@",image,type);
        // 压缩图片
        UIImage *scaleImage =  [LTTools imageScale:image size:CGSizeMake(200, 200)];
        NSLog(@"\n 压缩 image:%@ ",scaleImage);
        // 上传
        [self uploadImage:scaleImage];
    };
    
    [picker createSubviews];
    
    // 4、弹出界面
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)uploadImage:(UIImage *)image {
    
    WeakSelf
    [XTMeViewModel uploadUserImage:image success:^(NSDictionary * _Nonnull result) {
        NSString *headImgurl = result[@"data"][@"frontUser"][@"headimgurl"];
        DEF_PERSISTENT_SET_OBJECT(headImgurl, kHeadImgUrl);
        
        [weakSelf initData];
        
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
