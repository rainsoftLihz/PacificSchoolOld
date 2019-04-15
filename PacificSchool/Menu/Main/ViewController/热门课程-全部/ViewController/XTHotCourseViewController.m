//
//  XTHotCourseViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTHotCourseViewController.h"
#import "XTCourseListTableViewCell.h"
#import "XTMainViewModel.h"
#import "XTCourseModel.h"
#import "XTCourseDetailViewController.h"
#import "XTCoursewareViewController.h"
#import "XTElnMapJobListModel.h"

@interface XTHotCourseViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *models;
@end

@implementation XTHotCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}
- (void)initData {
    
    WeakSelf
    if (self.courseType == XTHotCourseType) {
        
        [XTMainViewModel getHotSuccess:^(NSArray * _Nonnull result) {
            weakSelf.models = result;
            [weakSelf.tableView reloadData];
        }];
        
    }else {
        [XTMainViewModel getRecommendSuccess:^(NSArray * _Nonnull result) {
            weakSelf.models = result;
            [weakSelf.tableView reloadData];

        }];
    }
    
}

- (void)initUI {
 
    [self.tableView registerNib:[UINib nibWithNibName:@"XTCourseListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 70;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTCourseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadModel:self.models[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    XTCourseDetailViewController *vc = [XTCourseDetailViewController new];
    XTCourseModel *model =self.models[indexPath.row];
//    vc.mapId = model.courseId;
//    [self.navigationController pushViewController:vc animated:YES];
    XTCoursewareViewController *vc = [XTCoursewareViewController new];
    XTElnMapJobListModel *submodel = [XTElnMapJobListModel new];
    submodel.objectId = model.courseId;
    vc.mapModel = submodel;
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
