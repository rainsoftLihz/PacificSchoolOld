//
//  XTHistoryViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/17.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTHistoryViewController.h"
#import "XTMainViewModel.h"
#import "XTHistoryTableViewCell.h"
#import "XTExamResultViewController.h"
#import "XTHistoryModel.h"

@interface XTHistoryViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *models;
@end

@implementation XTHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initUI];
    
    
}

- (void)initData {
    
    self.models = [NSArray array];
    WeakSelf
    [XTMainViewModel getHistory:^(NSArray * _Nonnull result) {
        weakSelf.models = result;
        [weakSelf.tableView reloadData];
    }];
    
}

- (void)initUI {
    
    self.title = @"全部记录";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"XTHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
 
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return self.models.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadModel:self.models[indexPath.row]];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTExamResultViewController *exam = [XTExamResultViewController new];
    XTHistoryModel *model = self.models[indexPath.row];
    exam.detailId = model.detailId;
    exam.title = model.examTitle;
    [self.navigationController pushViewController:exam animated:YES];
    
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
