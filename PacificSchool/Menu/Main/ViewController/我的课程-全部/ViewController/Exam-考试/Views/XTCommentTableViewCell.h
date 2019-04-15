//
//  XTCommentTableViewCell.h
//  CommentDemo
//
//  Created by Jonny on 2019/3/12.
//  Copyright © 2019 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commnetLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

NS_ASSUME_NONNULL_END
