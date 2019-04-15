//
//  XTHistoryTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/17.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTHistoryModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *rank;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
-(void)loadModel:(XTHistoryModel *)model;
@end

NS_ASSUME_NONNULL_END
