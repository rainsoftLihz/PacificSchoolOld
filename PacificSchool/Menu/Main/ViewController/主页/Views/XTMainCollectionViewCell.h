//
//  XTMainCollectionViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XTCourseModel;
NS_ASSUME_NONNULL_BEGIN

@interface XTMainCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

- (void)loadModel:(XTCourseModel *)model;
@end

NS_ASSUME_NONNULL_END
