//
//  XTRecognitionView.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/16.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTRecognitionView.h"
#import "XTRecognitionManager.h"
#import "XTMainViewModel.h"

@interface XTRecognitionView ()
@property(nonatomic,strong) XTRecognitionManager *manager;
@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,copy)NSString *recordString; ///< 记录录音数据
@property(nonatomic,strong)UILabel *msgLabel;
@property(nonatomic,strong)UILabel *matchingLabel;
@end

@implementation XTRecognitionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData {
    self.recordString = @"";
    self.manager = [[XTRecognitionManager alloc]init];
     __weak typeof(self) __weakSelf = self;
    self.manager.resultBlock = ^(NSString *result) {

        __weakSelf.textView.text = [NSString stringWithFormat:@"%@%@",__weakSelf.recordString,result];
    };
    
}

- (void)initUI {
 
    
    UIView *titleView = [[UIView alloc]init];
    [self addSubview:titleView];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"home_top"];
    [titleView addSubview:imageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"跟读内容";
    titleLabel.font = kFont(15);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;

    [titleView addSubview:titleLabel];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(titleView);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleView);
        make.center.equalTo(titleView);
    }];
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(60);
    }];

    _textView = [UITextView new];
    _textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textView.text = @"";
    [self addSubview:_textView];
    _textView.editable = NO;
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(titleView.mas_bottom);
        make.height.mas_equalTo(100);
    }];

    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordBtn setImage:[UIImage imageNamed:@"voice"] forState:0];
    [recordBtn addTarget:self action:@selector(clearRecordBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:recordBtn];
    
    UILabel *reLabel = [UILabel new];
    reLabel.text = @"重读";
    reLabel.textColor = kMainColor;
    reLabel.font = kFont(10);
    reLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:reLabel];
    
    [recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(-16);
        make.height.width.mas_equalTo(30);
        make.bottom.equalTo(reLabel.mas_top).offset(5);
        
    }];
    
    [reLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(recordBtn);
        make.height.width.mas_equalTo(30);
        make.bottom.equalTo(self.textView.mas_bottom).offset(5);
        
    }];
    
    UIButton *startRecordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startRecordBtn setImage:[UIImage imageNamed:@"voice"] forState:0];
    
    [startRecordBtn addTarget:self action:@selector(stopRecordBtn:) forControlEvents:UIControlEventTouchUpInside];
    
     [startRecordBtn addTarget:self action:@selector(startRecordEvent:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:startRecordBtn];

    _msgLabel = [UILabel new];
    _msgLabel.text = @"按下开始录音";
    _msgLabel.textColor = kMainColor;
    _msgLabel.font = kFont(14);
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_msgLabel];
    
    [_msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.centerX.equalTo(self);
        make.height.mas_equalTo(20);
        make.left.right.equalTo(self);
        make.top.equalTo(self.textView.mas_bottom).offset(8);
        
    }];
    
    [startRecordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.height.width.mas_equalTo(60);
        make.top.equalTo(self.msgLabel.mas_bottom).offset(8);
        
    }];
    
    _matchingLabel = [UILabel new];
    _matchingLabel.text = @"匹配度:";
    _matchingLabel.textColor = [UIColor grayColor];
    _matchingLabel.font = kFont(12);
//    _matchingLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_matchingLabel];
    
    [_matchingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
        make.left.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom).offset(8);
        
    }];
    
}

- (void)startRecordEvent:(UIButton *)btn {
    
    NSLog(@"按下");
    
    [_manager recordButtonClicked];
    
    _msgLabel.text = @"松开停止录音";
}

- (void)stopRecordBtn:(UIButton *)btn {
    
    NSLog(@"抬起");
    [_manager endRecording];
    _msgLabel.text = @"按下开始录音";
    self.recordString = self.textView.text;
    
    [self requestMatching];

}

- (void)requestMatching {
    
    NSDictionary *param = @{@"voiceWords":self.quetionString,
                           @"examWords":_textView.text
                            };
    NSLog(@" 匹配 %@",param);
    
    [XTMainViewModel getMatchingSuccess:param success:^(NSDictionary * _Nonnull result) {
        self->_matchingLabel.text = [NSString stringWithFormat:@"匹配度:%@",result[@"data"]];
        NSLog(@" 结果 %@",self->_matchingLabel.text);

    }];
    
}


- (void)clearRecordBtn {
    
    self.textView.text = @"";
    self.recordString = @"";
}

@end
