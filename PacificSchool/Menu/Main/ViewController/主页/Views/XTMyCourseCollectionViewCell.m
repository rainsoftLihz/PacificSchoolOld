//
//  XTMyCourseCollectionViewCell.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMyCourseCollectionViewCell.h"
#import "XTElnMapListModel.h"

@implementation XTMyCourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)loadModel:(XTElnMapListModel *)model {
    self.titleLabel.text = model.mapTitle;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kApi_FileServer_url,model.coverImg]]];
    self.headImageView.layer.cornerRadius = 5;
    self.headImageView.layer.masksToBounds = YES;
}
@end
