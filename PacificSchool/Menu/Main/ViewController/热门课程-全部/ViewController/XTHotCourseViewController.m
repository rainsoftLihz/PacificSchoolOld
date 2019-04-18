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
@property (nonatomic,strong)NSMutableArray *modelArr;
@property (nonatomic,assign)NSInteger page;
@end

@implementation XTHotCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.page =  1;
    [self loadData];
    [self initUI];
}

-(void)loadMore{
    self.page++;
    [self loadData];
}

- (void)loadData {
    
    WeakSelf
    if (self.courseType == XTHotCourseType) {
        
        [XTMainViewModel getHot:@{@"page":@(self.page)} Success:^(NSArray * _Nonnull result,NSInteger total) {
            
            [weakSelf.tableView.mj_footer endRefreshing];
            
            if (weakSelf.page == 1) {
                weakSelf.modelArr = result.mutableCopy;
            }else{
                [weakSelf.modelArr addObjectsFromArray:result];
                if (weakSelf.page == 10) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            if (weakSelf.page >= total) {
                //没有数据了
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [weakSelf.tableView reloadData];
        }];
        
    }else {
        [XTMainViewModel getRecommend:@{@"page":@(self.page)} Success:^(NSArray * _Nonnull result,NSInteger total) {
            [weakSelf.tableView.mj_footer endRefreshing];
            
            if (weakSelf.page == 1) {
                weakSelf.modelArr = result.mutableCopy;
            }else{
                [weakSelf.modelArr addObjectsFromArray:result];
                if (weakSelf.page == 10) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            if (weakSelf.page >= total) {
                //没有数据了
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [weakSelf.tableView reloadData];

        }];
    }
    
}

- (void)initUI {
 
    [self.tableView registerNib:[UINib nibWithNibName:@"XTCourseListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 70;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTCourseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadModel:self.modelArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XTCourseDetailViewController *vc = [XTCourseDetailViewController new];
    XTElnMapListModel *model =self.modelArr[indexPath.row];
    vc.mapId = model.mapId;
    [self.navigationController pushViewController:vc animated:YES];
//    XTCoursewareViewController *vc = [XTCoursewareViewController new];
//    XTElnMapJobListModel *submodel = [XTElnMapJobListModel new];
//    submodel.objectId = model.mapId;
//    vc.mapModel = submodel;
//    [self.navigationController pushViewController:vc animated:YES];
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
