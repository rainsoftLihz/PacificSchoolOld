//
//  XTMeHeadView.h
//  PacificSchool
//
//  Created by Jonny on 2019/2/24.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTMeHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *netImageView;
@property (weak, nonatomic) IBOutlet UIButton *rankButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *allBGView;
@property (weak, nonatomic) IBOutlet UIView *dadar;

@end

NS_ASSUME_NONNULL_END
