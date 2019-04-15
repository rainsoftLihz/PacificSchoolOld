//
//  XTMainCollectionViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMainCollectionViewCell.h"
#import "XTCourseModel.h"
@implementation XTMainCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = 5;
    self.headImageView.layer.masksToBounds = YES;
}

- (void)loadModel:(XTCourseModel *)model{
    self.titleLabel.text = model.courseTitle;
    self.subTitleLabel.text = [NSString stringWithFormat:@"已有%@人学习",model.viewCount];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,model.coverImg]]];
}

@end
