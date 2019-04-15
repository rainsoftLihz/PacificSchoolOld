//
//  XTMyCourseCollectionViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XTElnMapListModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTMyCourseCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (void)loadModel:(XTElnMapListModel *)model;
@end

NS_ASSUME_NONNULL_END
