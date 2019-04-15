//
//  XTSettingTableViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/4.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTSettingTableViewCell.h"

@implementation XTSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = 22;
    self.headImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
