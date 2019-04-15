//
//  XTSettingTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/4.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTSettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

NS_ASSUME_NONNULL_END
