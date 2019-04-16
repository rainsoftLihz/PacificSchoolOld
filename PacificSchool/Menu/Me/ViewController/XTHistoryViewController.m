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
@property (nonatomic,strong)NSMutableArray *modelArr;
@property (nonatomic,assign)NSInteger page;
@end

@implementation XTHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.page = 1;
    [self initUI];
    [self initData];
}

- (void)initData {
    WeakSelf
    [XTMainViewModel getHistory:@{@"pageNo":@(self.page)} sucess:^(NSArray * _Nonnull result, NSInteger total) {
        if (self.page == 1) {
            weakSelf.modelArr = result.mutableCopy;
        }else{
            [weakSelf.modelArr addObjectsFromArray:result];
        }
        
        if (weakSelf.page >= total) {
            //没有数据了
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        
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
 
    return self.modelArr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell loadModel:self.modelArr[indexPath.row]];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTExamResultViewController *exam = [XTExamResultViewController new];
    XTHistoryModel *model = self.modelArr[indexPath.row];
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
