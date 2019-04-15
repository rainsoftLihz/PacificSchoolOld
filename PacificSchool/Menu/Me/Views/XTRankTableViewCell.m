//
//  XTRankTableViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTRankTableViewCell.h"
#import "XTRankModel.h"
#import "XTFrontUserStatisticsModel.h"
@implementation XTRankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = 50/2;
    self.headImageView.layer.masksToBounds = YES;
}

- (void)loadModel:(XTRankModel *)model {
    
    self.titleLabel.text = model.realName;
    NSLog(@" 名字 --%@",model.realName);
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,model.headimgurl]] placeholderImage:[UIImage imageNamed:@"account_avatar"]];
    self.subLabel.text = model.frontUserStatistics.rankNo;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
