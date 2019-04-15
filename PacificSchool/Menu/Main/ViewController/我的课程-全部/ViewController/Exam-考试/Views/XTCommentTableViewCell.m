//
//  XTCommentTableViewCell.m
//  CommentDemo
//
//  Created by Jonny on 2019/3/12.
//  Copyright © 2019 Nil. All rights reserved.
//

#import "XTCommentTableViewCell.h"

@implementation XTCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = 20;
    self.headImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
