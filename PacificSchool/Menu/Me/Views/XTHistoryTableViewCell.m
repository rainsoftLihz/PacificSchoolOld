//
//  XTHistoryTableViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/17.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTHistoryTableViewCell.h"
#import "XTHistoryModel.h"
#import "LSDateTool.h"

@implementation XTHistoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.bgView.layer.cornerRadius = 6;
    self.bgView.layer.masksToBounds = YES;
    self.selectionStyle = 0;
}

-(void)loadModel:(XTHistoryModel *)model {

    self.nameLabel.text = model.examTitle;
    
    NSMutableAttributedString *allString = [[NSMutableAttributedString alloc]initWithString:@"平均分:"];
    NSAttributedString *subString = [[NSAttributedString alloc]initWithString:model.score attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [allString appendAttributedString:subString];
    self.scoreLabel.attributedText = allString;
    self.rank.text = [NSString stringWithFormat:@"全公司排名:%@",model.rankNo];
    
    self.timeLabel.text = [LSDateTool ymdhm_dateConvrrtTimestamp:[model.createTime integerValue]];
    
    [LSDateTool dateConvrrtTimestamp:[model.createTime integerValue]/1000];
    
   self.dateLabel.text = [LSDateTool inputTimeStr:[LSDateTool dateConvrrtTimestamp:[model.createTime integerValue]/1000] withFormat:nil];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
