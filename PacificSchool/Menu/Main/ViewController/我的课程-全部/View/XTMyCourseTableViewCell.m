//
//  XTMyCourseTableViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMyCourseTableViewCell.h"
#import "XTMyCourseModel.h"
#import "XTElnMapUserModel.h"

@implementation XTMyCourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadModel:(XTMyCourseModel *)model {
    
    self.titleLabel.text = model.mapTitle;
    NSString *urlString = [NSString stringWithFormat:@"%@%@",kApi_FileServer_url,model.coverImg];
    
    NSURL *url = [NSURL URLWithString:urlString];
    [self.headImageView sd_setImageWithURL:url];
    
    self.headImageView.contentMode = UIViewContentModeScaleAspectFit;
    double complete = [model.elnMapUser.jobCountComplete doubleValue];
    double total = [model.elnMapUser.jobCountComplete doubleValue];

    double pr = complete / total;
    
    if (isnan(pr)) {
        pr = 0;
    }
    
    self.progressView.progress = pr;
    // 总数
    self.countLabel.text = [NSString stringWithFormat:@"%@/%@",model.elnMapUser.jobCountComplete,model.elnMapUser.jobCountTotal];
    
    NSLog(@"完成度%f model %f %f",complete,total,complete / total);
    
    // 平均分
    NSString *coSour = [NSString removeSuffix:[NSString stringWithFormat:@"%.1f%%",pr*100]] ;
    self.subLabel.text = [NSString stringWithFormat:@"已完成%@ 平均分%.1f",coSour,[model.elnMapUser.avgScore floatValue]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
