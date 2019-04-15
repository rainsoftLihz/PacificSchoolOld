//
//  UIView+Gradient.m
//  PacificSchool
//
//  Created by Jonny on 2019/2/21.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)
- (void)addGradientColor {
    
    [self.layer insertSublayer:[XTGradientLayer getMainLayerWithFrame:self.bounds] atIndex:0];

}

- (void)addGradientColorWithStart:(UIColor*)start end:(UIColor*)end {
    [self.layer insertSublayer:[XTGradientLayer getGradientWithStart:start end:end WithFrame:self.bounds] atIndex:0];
}

@end
