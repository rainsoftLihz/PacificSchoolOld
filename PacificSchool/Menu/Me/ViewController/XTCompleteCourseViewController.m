//
//  XTCompleteCourseViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCompleteCourseViewController.h"
#import "XTCompleteTableViewCell.h"
#import "XTMainViewModel.h"
#import "XTCourseDetailViewController.h"
#import "XTMyCourseModel.h"

@interface XTCompleteCourseViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *models;

@end

@implementation XTCompleteCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initUI];
}

- (void)initData {
    WeakSelf
    [XTMainViewModel getCourseCompleteSuccess:^(NSArray * _Nonnull result) {
        weakSelf.models = result;
        [weakSelf.tableView reloadData];
    }];
}

- (void)initUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XTCompleteTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 80;
    self.tableView.tableFooterView = [UIView new];
    self.title = @"已完成的课程";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTCompleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadModel:self.models[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTMyCourseModel *model = self.models[indexPath.row];
    
    XTCourseDetailViewController *vc = [XTCourseDetailViewController new];
    vc.mapId = model.mapId;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//XTCourseDetailViewController

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
