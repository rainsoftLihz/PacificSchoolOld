//
//  XTRankTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/6.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XTRankModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTRankTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)loadModel:(XTRankModel *)model;
@end

NS_ASSUME_NONNULL_END
