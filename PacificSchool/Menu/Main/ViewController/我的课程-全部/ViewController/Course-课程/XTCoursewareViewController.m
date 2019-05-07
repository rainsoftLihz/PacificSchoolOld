//
//  XTCoursewareViewController.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/9.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCoursewareViewController.h"
#import "XTCourseDetailModel.h"
#import "XTMyCourseModel.h"
#import "XTElnMapJobListModel.h"
#import "XTElnMapUserModel.h"
#import "LTTools.h"
#import "XTMainViewModel.h"
#import "XTCoursewareDetailModel.h"
#import "XTCourseModel.h"
#import "XTHTMLViewController.h"
#import "XTVideoViewController.h"
#import "VedioModel.h"
#import "MusicPlayerView.h"
#import "XTCommonAttachmentListModel.h"
#import "XTExamViewController.h"
#import "XTSwitchView.h"
#import "XTCommentTableViewCell.h"
#import "XTCommentModel.h"
#import "LSDateTool.h"

#define kCountHeight  120 + 30 + 44 + 8 + 30

@interface XTCoursewareViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic,strong)XTCourseDetailModel *model;
@property (nonatomic,strong)XTCoursewareDetailModel *coursewareModel;

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)UILabel *proLabel;
@property (nonatomic,strong)UIButton *startBtn;

@property (nonatomic,strong)MusicPlayerView *playerView;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)BOOL isShow;
@property (nonatomic,strong)UIView *informationView;
@property (nonatomic,strong)UIView *commentView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UIScrollView *scorView;

@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UITextField *commentTF;
@property (nonatomic,strong)NSArray *commentModels;

@end

@implementation XTCoursewareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    [self initUI];
    
}

- (void)initData {
    
    self.commentModels = [NSArray array];
    
    NSDictionary *mapModel = @{@"courseId":self.mapModel.objectId};
    WeakSelf
    [XTMainViewModel getCoursewareDetailSuccess:mapModel success:^(XTCoursewareDetailModel * _Nonnull result) {
        weakSelf.coursewareModel = result;
        [weakSelf configUIData];
    }];
    
    [self requestComment];
}

- (void)requestComment {
    NSDictionary *mapModel = @{@"courseId":self.mapModel.objectId};

    WeakSelf
    [XTMainViewModel getCourseComment:mapModel success:^(NSArray * _Nonnull result) {
        weakSelf.commentModels = result;
        [weakSelf.tableView reloadData];
        
    }];
    
}

- (void)configUIData {
    
    if ([self.coursewareModel.elnCourse.contentType isEqualToString:@"audio"]) {
        
        self.imageView.hidden = YES;
        self.startBtn.hidden = YES;
        
        VedioModel *model2 = [[VedioModel alloc]init];
        model2.progress = 30;
        
        if (self.coursewareModel.commonAttachmentList.count > 0) {
            XTCommonAttachmentListModel *listModel = self.coursewareModel.commonAttachmentList[0];
            NSString *filePath = [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,listModel.filePath];
            model2.contentURL = [NSURL URLWithString:filePath];
            
        }
        
        float musicViewWidth =  kScreenW - 16;
        self.playerView = [[MusicPlayerView alloc]initWithFrame:CGRectMake(8, 30, musicViewWidth, 60)];
        [self.playerView setUpWithModel:model2];
        self.playerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.playerView];
        
        NSString *urlImage = [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,self.coursewareModel.elnCourse.coverImg];
        [self.playerView.imageView sd_setImageWithURL:[NSURL URLWithString:urlImage]];
        
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,self.coursewareModel.elnCourse.coverImg]] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",self.coursewareModel.elnCourse.courseTitle];
    self.detailLabel.text = [NSString stringWithFormat:@"%@",self.coursewareModel.elnCourse.courseSummary];
    self.proLabel.text = [NSString stringWithFormat:@"%@人在学",self.coursewareModel.elnCourse.studyCount];
    _textView.text = self.coursewareModel.elnCourse.courseSummary;
}

- (void)initUI {
    
    self.title = @"课件详情";
    
    _scorView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scorView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_scorView];
    
    [_scorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kCountHeight)];
    _headView.backgroundColor = [UIColor whiteColor];
    [_scorView addSubview:_headView];
    
    UIView *imageBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 120)];
    imageBGView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:imageBGView];
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.backgroundColor = [UIColor whiteColor];
    _imageView.alpha = .7f;
    // 头像
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,self.model.elnMap.coverImg];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    [_headView addSubview:_imageView];
    
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startBtn setTitle:@"开始学习" forState:0];
    _startBtn.titleLabel.font = kFont(12);
    _startBtn.backgroundColor = kMainColor;
    _startBtn.layer.cornerRadius = 2;
    [_startBtn addTarget:self action:@selector(startStudy) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_startBtn];
    
    
    // 标题
    _titleLabel = [UILabel new];
    //_titleLabel.text = [NSString stringWithFormat:@"   %@",self.model.elnMap.mapTitle];
    _titleLabel.font = [UIFont systemFontOfSize:17 weight:40];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    
    [_headView addSubview:_titleLabel];
    
    //副标题
    _detailLabel = [UILabel new];
    _detailLabel.font = [UIFont systemFontOfSize:12];
    _detailLabel.numberOfLines = 0;
    //_detailLabel.text = [NSString stringWithFormat:@"   课程简介:%@",self.model.elnMap.summary];
    _detailLabel.textColor = [UIColor grayColor];
    _detailLabel.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:_detailLabel];
    
    //学习人数
    _proLabel = [UILabel new];
    _proLabel.font = [UIFont systemFontOfSize:12];
    //    _proLabel.text = [NSString stringWithFormat:@"   人在学"];
    _proLabel.textColor = [UIColor orangeColor];
    _proLabel.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:_proLabel];
    
    UIButton *examBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [examBtn setTitle:@"随堂练" forState:0];
    examBtn.titleLabel.font = kFont(12);
    [examBtn setTitleColor:kMainColor forState:0];
    examBtn.layer.cornerRadius = 2;
    examBtn.layer.borderColor = kMainColor.CGColor;
    examBtn.layer.borderWidth = 1;
    [examBtn addTarget:self action:@selector(examEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:examBtn];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.headView);
        make.height.mas_equalTo(120);
    }];
    
    [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.center.equalTo(self.imageView);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_imageView).offset(8);
        make.right.equalTo(examBtn).offset(-8);
        make.top.equalTo(self->_imageView.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    [examBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headView).offset(-8);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.imageView.mas_bottom).offset(8);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_titleLabel).offset(8);
        make.right.equalTo(self->_titleLabel).offset(-8);
        make.top.equalTo(examBtn.mas_bottom);
        make.height.mas_equalTo(30);
    }];
    
    [_proLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView).offset(8);
        make.right.equalTo(self.headView).offset(-8);
        make.height.mas_equalTo(44);
        make.top.equalTo(self->_detailLabel.mas_bottom).offset(0);
    }];
    
    [self configInformation];
    
}

- (void)configInformation {

    
    XTSwitchView *view = [[XTSwitchView alloc]initWithFrame:CGRectMake(0, kCountHeight + 8, kScreenW, 35)];
    view.backgroundColor = [UIColor whiteColor];
    WeakSelf
    view.blockEvent = ^(NSInteger index) {
        if (index == 0) {
            weakSelf.tableView.hidden = YES;
            weakSelf.informationView.hidden = NO;
            weakSelf.commentView.hidden = YES;
        }else {
            weakSelf.tableView.hidden = NO;
            weakSelf.informationView.hidden = YES;
            weakSelf.commentView.hidden = NO;
        }
    };
    [_scorView addSubview:view];
    
    _informationView = [[UIView alloc]initWithFrame:CGRectMake(0, kCountHeight + 35 + 8, kScreenW, kScreenH - kCountHeight - 35)];
    _informationView.backgroundColor = [UIColor whiteColor];
    [_scorView addSubview:_informationView];
    
    UILabel *titleLabel = [UILabel new];
    [_informationView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = @"简介";
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.informationView).offset(8);
        make.right.equalTo(self.informationView).offset(-8);
        make.top.equalTo(self.informationView).offset(8);
        make.height.mas_equalTo(20);
    }];
    
    _textView = [[UITextView alloc]init];
    _textView.editable = NO;
    _textView.text = @"";
    _textView.backgroundColor = [UIColor whiteColor];
    [_informationView addSubview:_textView];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.informationView).offset(8);
        make.right.equalTo(self.informationView).offset(-8);
        make.top.equalTo(titleLabel.mas_bottom).offset(0);
        make.bottom.equalTo(self.informationView.mas_bottom).offset(-8);
    }];
    
    float height = kScreenH - 275 - 48 - 64 - 8;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kCountHeight + 35 + 8 + 8, kScreenW,height)];
    _tableView.delegate  = self;
    _tableView.hidden = YES;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XTCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.tableFooterView = [UIView new];
    _tableView.estimatedRowHeight = 44;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_scorView addSubview:_tableView];
    
    
    _commentView = [UIView new];
    _commentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_commentView];
    
    _commentTF = [UITextField new];
    _commentTF.font = [UIFont systemFontOfSize:12];
    _commentTF.placeholder = @"请输入评论";
    _commentTF.layer.cornerRadius = 2;
    _commentTF.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _commentTF.layer.borderWidth = 1;
    [_commentView addSubview:_commentTF];
    
    
    UIButton *commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setTitle:@"评论" forState:0];
    commentBtn.backgroundColor = kMainColor;
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    commentBtn.layer.cornerRadius = 2;
    [commentBtn addTarget:self action:@selector(commentEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_commentView addSubview:commentBtn];
   
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeArea);
        make.height.mas_equalTo(48);
    }];
    
    [_commentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentView).offset(8);
        make.right.equalTo(commentBtn.mas_left).offset(-8);
        make.top.equalTo(self.commentView.mas_top).offset(8);
        make.bottom.equalTo(self.commentView.mas_bottom).offset(-8);
    }];
    
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentView).offset(-8);
        make.left.equalTo(self.commentTF.mas_right).offset(-8);
        make.top.equalTo(self.commentView.mas_top).offset(8);
        make.bottom.equalTo(self.commentView.mas_bottom).offset(-8);
        make.width.mas_equalTo(50);
    }];
    
}

- (void)commentEvent:(UIButton *)btn {

    if (_commentTF.text.length>0) {
        
        
//        m=insertForum
//        coopCode=cpic
//        frontUserId：用户ID
//        courseId：课程ID
//        content：评论内容
//        nickname：昵称
//        comment_type=forum
//    headimgurl:用户头像url（非必填）
     
        
        NSDictionary *param = @{@"m":@"insertForum",
                                @"courseId":self.mapModel.objectId,
                                @"content":self.commentTF.text,
                                @"nickname":DEF_PERSISTENT_GET_OBJECT(kNickName),
                                @"comment_type":@"forum",
                                
                                };
        NSLog(@"评论 %@",param);
        WeakSelf
        [XTMainViewModel insterCourseComment:param success:^(NSDictionary * _Nonnull result) {
            
            [weakSelf requestComment];
            weakSelf.commentTF.text = @"";
        }];
    }
    
}

- (void)startStudy {
    
    if ([self.coursewareModel.elnCourse.contentType isEqualToString:@"link"]) {
        
        XTHTMLViewController *vc = [XTHTMLViewController new];
        vc.model = self.coursewareModel.elnCourse;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if([self.coursewareModel.elnCourse.contentType isEqualToString:@"video"]){
        
        XTVideoViewController *vc = [XTVideoViewController new];
        vc.model = self.coursewareModel;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)examEvent:(UIButton *)btn {
    
    XTExamViewController *vc = [XTExamViewController new];
    vc.model = self.coursewareModel;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.commentModels.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    XTCommentModel *model = self.commentModels[indexPath.row];
    
    NSString *date = [LSDateTool ymdhm_dateConvrrtTimestamp:[model.createTime integerValue]];
    cell.dateLabel.text = date;
    cell.nameLabel.text = model.nickname;
    cell.commnetLabel.text = model.content;
//    cell.commnetLabel.text = @"account_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avataraccount_avatar";
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,model.headimgurl]] placeholderImage:[UIImage imageNamed:@"account_avatar"]];
    return cell;
}

- (void)dealloc {
    
    [self.playerView pause];
    [self.playerView destroyPlayer];
    [self.playerView destroyPlayerItem];
    self.playerView = nil;
    
    NSLog(@"dealloc === >>> %@",self);
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
