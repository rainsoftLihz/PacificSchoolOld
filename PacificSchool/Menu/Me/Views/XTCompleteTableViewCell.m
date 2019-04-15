//
//  XTCompleteTableViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCompleteTableViewCell.h"
#import "XTMyCourseModel.h"
#import "XTElnMapUserModel.h"

@implementation XTCompleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadModel:(XTMyCourseModel *)model {
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,model.coverImg]]];
    self.titleLabel.text = model.mapTitle;
    self.scoreLabel.text = @"平均分";
    self.subScoreLabel.textColor = [UIColor redColor];
    self.subScoreLabel.text = [NSString stringWithFormat:@"%@分",model.elnMapUser.avgScore];
    self.dateLabel.text = [NSString stringWithFormat:@"完成时间:暂无"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
