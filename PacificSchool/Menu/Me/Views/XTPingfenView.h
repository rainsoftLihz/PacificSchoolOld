//
//  XTPingfenView.h
//  PacificSchool
//
//  Created by rainsoft on 2019/4/16.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCStarRatingView.h"
#import "XTMainViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface XTPingfenView : UIButton
@property (nonatomic,strong)PCStarRatingView* starView;
-(instancetype)initWithFrame:(CGRect)frame andScore:(NSString*)scroe andMapId:(NSString*)mapId;
@end

NS_ASSUME_NONNULL_END
