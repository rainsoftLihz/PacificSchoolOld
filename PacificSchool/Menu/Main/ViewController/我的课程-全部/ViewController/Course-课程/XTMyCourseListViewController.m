//
//  XTMyCourseListViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMyCourseListViewController.h"
#import "XTMyCourseTableViewCell.h"
#import "XTMainViewModel.h"
#import "XTCourseDetailViewController.h"
#import "XTMyCourseModel.h"

@interface XTMyCourseListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *models;
@end

@implementation XTMyCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}

- (void)initData {
    
    self.models = [NSArray array];
    WeakSelf
    [XTMainViewModel getMtMapDataSuccess:^(NSArray * _Nonnull result) {
        weakSelf.models = result;
        [weakSelf.tableView reloadData];
    }];
    
}

- (void)initUI {
 
    [self.tableView registerNib:[UINib nibWithNibName:@"XTMyCourseTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 70;
    self.tableView.tableFooterView = [UIView new];
    
    self.title = @"我的课程";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTMyCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadModel:self.models[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTCourseDetailViewController *vc = [XTCourseDetailViewController new];
    XTMyCourseModel *courseModel = self.models[indexPath.row];
    vc.mapId = courseModel.mapId;
    [self.navigationController pushViewController:vc animated:YES];
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
