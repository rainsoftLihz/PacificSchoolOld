//
//  XTCourseListTableViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTCourseListTableViewCell.h"
#import "XTCourseModel.h"

@implementation XTCourseListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadModel:(XTCourseModel *)model {
 
    self.titleLabel.text = model.courseTitle;
    self.subTitleLabel.text = [NSString stringWithFormat:@"%@",model.courseSummary];
    self.numberLAbel.text = [NSString stringWithFormat:@"学习人数:%@",model.viewCount];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,model.coverImg]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
