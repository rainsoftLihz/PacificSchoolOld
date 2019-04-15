//
//  XTProgressView.h
//  弧形进度条
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XTProgressView : UIView
@property(nonatomic,assign)float num;  // 进度数
@property(nonatomic,assign)int countNum; // 总数
@property(nonatomic,strong)UILabel *numLabel;
@end

NS_ASSUME_NONNULL_END
