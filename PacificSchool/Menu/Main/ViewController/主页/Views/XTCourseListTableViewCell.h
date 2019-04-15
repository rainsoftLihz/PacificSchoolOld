//
//  XTCourseListTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTCourseModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTCourseListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLAbel;
- (void)loadModel:(XTCourseModel *)model;
@end

NS_ASSUME_NONNULL_END
