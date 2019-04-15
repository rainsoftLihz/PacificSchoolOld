//
//  XTMainTableViewCell.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTElnMapListModel;
NS_ASSUME_NONNULL_BEGIN
@protocol XTMainTableViewCellDelegate;
@interface XTMainTableViewCell : UITableViewCell

@property (strong, nonatomic) UICollectionView *collectionView;

@property (nonatomic,assign)id<XTMainTableViewCellDelegate>delegate;
- (void)loadModels:(NSArray *)models;

@end

@protocol XTMainTableViewCellDelegate <NSObject>

- (void)selelctedCourseWithIndex:(XTMainTableViewCell *)cell model:(XTElnMapListModel *)model;

@end

NS_ASSUME_NONNULL_END
