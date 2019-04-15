//
//  XTGradientLayer.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTGradientLayer.h"

@implementation XTGradientLayer
+ (CAGradientLayer*)getMainLayerWithFrame:(CGRect)rect {
    return [XTGradientLayer getGradientWithStart:[UIColor colorWithRed:0 green:205.f/255.f blue:240.f/250.f alpha:1] end:kMainColor WithFrame:rect];
}

+ (CAGradientLayer*)getGradientWithStart:(UIColor*)start end:(UIColor*)end WithFrame:(CGRect)rect {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)start.CGColor, (__bridge id)end.CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = rect;
    return gradientLayer;
}
@end
