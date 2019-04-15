//
//  XTSwitchView.h
//  CommentDemo
//
//  Created by Jonny on 2019/3/12.
//  Copyright © 2019 Nil. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XTSwitchViewBlockEvent)(NSInteger index);
@interface XTSwitchView : UIView
@property(nonatomic,assign)BOOL isShow;
@property(nonatomic,copy)XTSwitchViewBlockEvent blockEvent;
@end

NS_ASSUME_NONNULL_END
