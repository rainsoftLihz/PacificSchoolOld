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
#import "XTRankModel.h"
@interface XTRankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *numOneImg;
@property (weak, nonatomic) IBOutlet UIImageView *numTwoImg;
@property (weak, nonatomic) IBOutlet UIImageView *numThreeImg;
@property (nonatomic,strong)NSMutableArray *modelArr;
@property (nonatomic,assign)NSInteger page;
@end

@implementation XTRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.page = 1;
    
    [self loadData];
    [self initUI];
}

-(void)loadMore{
    self.page++;
    [self loadData];
}


- (void)loadData {
    
    WeakSelf
    [XTMainViewModel getRank:@{@"pageNo":@(self.page)} Success:^(NSArray * _Nonnull result,NSInteger total) {
        if (self.page == 1) {
           weakSelf.modelArr = result.mutableCopy;
           [weakSelf setUpUIWithData];
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


#pragma mark ---  123
-(void)setUpUIWithData{
    for (int i = 0; i < 3; i++) {
        XTRankModel *modell = self.modelArr[i];
        
        UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,modell.headimgurl]] placeholderImage:[UIImage imageNamed:@"account_avatar"]];
        
        if (i == 0) {
            self.numberOneLabel.text = modell.realName;
            [self addImgv:imgV To:self.numOneImg];
            
        }else if (i == 1){
            self.numberTwoLabel.text = modell.realName;
            [self addImgv:imgV To:self.numTwoImg];
        }else {
            self.numberThreeLabel.text = modell.realName;
            [self addImgv:imgV To:self.numThreeImg];
        }
    }
}

-(void)addImgv:(UIImageView*)imgV To:(UIImageView*)toImgV{
    [toImgV addSubview:imgV];
    //212 280
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(toImgV);
        make.top.mas_equalTo(toImgV.mas_top).offset(15.0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    imgV.layer.cornerRadius = 60/2.0;
    imgV.layer.masksToBounds = YES;
}
    


- (void)initUI {
    
    self.myRankLabel.layer.cornerRadius = 20/2;
    self.myRankLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.myRankLabel.layer.masksToBounds = YES;
    self.myRankLabel.text = [NSString stringWithFormat:@"%ld",self.rankNo];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XTRankTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"XTOrganizationTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    self.title = @"英雄榜";
    
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self.numberTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.numTwoImg);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.numTwoImg.mas_bottom);
    }];
    
    [self.numberOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.numOneImg);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.numberTwoLabel);
    }];
    
    
    [self.numberThreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.numThreeImg);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.numberTwoLabel);
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XTRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.indexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+4];
        [cell loadModel:self.modelArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
