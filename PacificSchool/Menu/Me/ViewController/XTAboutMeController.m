//
//  XTAboutMeController.m
//  PacificSchool
//
//  Created by rainsoft on 2019/4/17.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "XTAboutMeController.h"

@interface XTAboutMeController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation XTAboutMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
    [self configUI];
}

-(void)configUI{
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    tableView.rowHeight = 44.0;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self titleArr].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
    cell.textLabel.font = kFont(14.0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 2) {
        cell.backgroundColor = UIColor.clearColor;
    }else{
        cell.textLabel.text = [self titleArr][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = UIColor.whiteColor;
        
        if (indexPath.row == 0) {
            UIView* line = [UIView new];
            line.backgroundColor = UIColor.groupTableViewBackgroundColor;
            [cell.contentView addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell.textLabel);
                make.bottom.mas_equalTo(cell.contentView);
                make.right.mas_equalTo(cell.contentView.mas_right).offset(100);
                make.height.mas_equalTo(0.9);
            }];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return 10.0;
    }
    return 44.0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //对应name --- version  跟安卓同步
        //NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [self showStatus:[NSString stringWithFormat:@"当前版本号为：%@",@"1.7.1"]];
        
    }else if (indexPath.row == 1){
        XTQRcodeVController* vc = [XTQRcodeVController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        XTAboutCPICViewController* vc = [XTAboutCPICViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(NSArray*)titleArr{
    return @[@"版本更新检查",@"APP下载二维码",@"",@"关于智学院"];
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
