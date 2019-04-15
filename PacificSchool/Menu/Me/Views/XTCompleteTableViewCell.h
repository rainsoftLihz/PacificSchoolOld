//
//  XTCompleteTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTMyCourseModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTCompleteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *subScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (void)loadModel:(XTMyCourseModel *)model;
@end

NS_ASSUME_NONNULL_END
