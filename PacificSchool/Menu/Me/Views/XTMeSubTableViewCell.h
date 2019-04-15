//
//  XTMeSubTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/2/24.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTMeSubTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ritghtTileLabel;

@end

NS_ASSUME_NONNULL_END
