//
//  XTCourseListViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCourseListViewController.h"
#import "XTCourseListTableViewCell.h"
@interface XTCourseListViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XTCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initData];
    [self initUI];
}

- (void)initData {
    
}

- (void)initUI {
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XTCourseListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.rowHeight = 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTCourseListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
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
