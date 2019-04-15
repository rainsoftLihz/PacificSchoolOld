//
//  XTMyCourseTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/8.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTMyCourseModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTMyCourseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

- (void)loadModel:(XTMyCourseModel *)model;
@end

NS_ASSUME_NONNULL_END
