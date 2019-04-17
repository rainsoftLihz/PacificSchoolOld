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
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
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
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,DEF_PERSISTENT_GET_OBJECT(kHeadImgUrl)?:@""]] placeholderImage:[UIImage imageNamed:@"account_avatar"]];
    self.iconImg.layer.cornerRadius = 20;
    self.iconImg.layer.masksToBounds = YES;
}

-(void)loadMore{
    self.page++;
    [self loadData];
}


- (void)loadData {
    
    WeakSelf
    [XTMainViewModel getRank:@{@"pageNo":@(self.page)} Success:^(NSArray * _Nonnull result,NSInteger total) {
        
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if (weakSelf.page == 1) {
           weakSelf.modelArr = result.mutableCopy;
           [weakSelf setUpUIWithData];
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


#pragma mark ---  123
-(void)setUpUIWithData{
    for (int i = 0; i < 3; i++) {
        XTRankModel *modell = self.modelArr[i];
        
        UIImageView* imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,modell.headimgurl]] placeholderImage:[UIImage imageNamed:@"account_avatar"]];
        
        UILabel* scroeLab = [[UILabel alloc] init];
        scroeLab.textColor = UIColor.whiteColor;
        scroeLab.font = kFont(14.0);
        scroeLab.textAlignment = NSTextAlignmentCenter;
        scroeLab.text = modell.frontUserStatistics.rankScore;
        [self.view addSubview:scroeLab];
        if (i == 0) {
            self.numberOneLabel.text = modell.realName;
            [self addImgv:imgV To:self.numOneImg top:12.0];
            [scroeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.numberOneLabel.mas_centerX);
                make.top.mas_equalTo(self.numberOneLabel.mas_bottom).offset(0.0);;
            }];
            
        }else if (i == 1){
            self.numberTwoLabel.text = modell.realName;
            [self addImgv:imgV To:self.numTwoImg top:8.0];
            [scroeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.numberTwoLabel.mas_centerX);
                make.top.mas_equalTo(self.numberTwoLabel.mas_bottom).offset(0.0);;
            }];
        }else {
            self.numberThreeLabel.text = modell.realName;
            [self addImgv:imgV To:self.numThreeImg top:10.0];
            [scroeLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.numberThreeLabel.mas_centerX);
                make.top.mas_equalTo(self.numberThreeLabel.mas_bottom).offset(0.0);;
            }];
        }
    }
}

-(void)addImgv:(UIImageView*)imgV To:(UIImageView*)toImgV top:(NSInteger)topSpace{
    [toImgV addSubview:imgV];
    //212 280
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(toImgV);
        make.top.mas_equalTo(toImgV.mas_top).offset(topSpace);
        make.size.mas_equalTo(CGSizeMake(66, 66));
    }];
    
    imgV.layer.cornerRadius = 66/2.0;
    imgV.layer.masksToBounds = YES;
}
    


- (void)initUI {
    
    self.myRankLabel.layer.cornerRadius = 20/2;
    self.myRankLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.myRankLabel.layer.masksToBounds = YES;
    self.myRankLabel.text = [NSString stringWithFormat:@" 我的排名:%ld",self.rankNo];
    
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
    return self.modelArr.count>3?self.modelArr.count-3:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XTRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.indexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+4];
        if (self.modelArr.count > indexPath.row+3) {
            [cell loadModel:self.modelArr[indexPath.row+3]];
        }
        
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
