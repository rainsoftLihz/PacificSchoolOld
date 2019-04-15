//
//  XTRankViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/4.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTRankViewController.h"
#import "XTRankTableViewCell.h"
#import "XTOrganizationTableViewCell.h"
#import "XTMainViewModel.h"

@interface XTRankViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic,strong)NSArray *models;
@end

@implementation XTRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}

- (void)initData {
    self.models = [NSArray array];
    WeakSelf
    [XTMainViewModel getRankSuccess:^(NSArray * _Nonnull result) {
        weakSelf.models = result;
        [weakSelf.tableView reloadData];
    }];
}

- (void)initUI {
    
    self.myRankLabel.layer.cornerRadius = 20/2;
    self.myRankLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.myRankLabel.layer.masksToBounds = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XTRankTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XTOrganizationTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    self.title = @"英雄榜";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XTRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.indexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        [cell loadModel:self.models[indexPath.row]];
        return cell;
    }else {
        XTOrganizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.indexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        return cell;
    }
   
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
