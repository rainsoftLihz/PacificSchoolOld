//
//  XTMainHeadView.h
//  弧形进度条
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^XTMainHeadViewSignEvent)();
@interface XTMainHeadView : UIView
@property (nonatomic,copy)XTMainHeadViewSignEvent blockEvent;
- (void)loadData:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
