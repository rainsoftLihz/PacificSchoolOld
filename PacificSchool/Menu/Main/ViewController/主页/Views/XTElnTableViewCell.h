//
//  XTElnTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XTElnMapListModel;
@protocol XTElnTableViewCellDelegate;
@interface XTElnTableViewCell : UITableViewCell

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,assign)id<XTElnTableViewCellDelegate>delegate;
- (void)loadModels:(NSArray *)models;
@end

@protocol XTElnTableViewCellDelegate <NSObject>

- (void)selelctedCourseWithElnTableViewCell:(XTElnTableViewCell *)cell model:(XTElnMapListModel *)model;

@end
NS_ASSUME_NONNULL_END
