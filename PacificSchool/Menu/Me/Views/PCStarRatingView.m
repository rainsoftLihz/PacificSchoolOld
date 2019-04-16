//
//  PCStarRatingView.m
//  PCStarRatingView
//
//  Created by xpc on 16/12/14.
//  Copyright © 2016年 xpc. All rights reserved.
//

#import "PCStarRatingView.h"

@implementation PCStarRatingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)layoutSubviews{
    
    for (NSInteger i = 0; i < self.imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"starRating1"];
        imageView.tag = 1000+i;
        imageView.frame = CGRectMake(self.imageWidth*i, 0, self.imageWidth, self.imageHeight);
        [self addSubview:imageView];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //随着手的移动,移动到相应的位置
    //获取触摸对象
    UITouch *touch = [touches anyObject];
    //获取移动之后的坐标变化
    CGPoint newPoint = [touch locationInView:self];
    NSInteger temp = newPoint.x / 12+1;
    
    for (NSInteger i = 0; i < (temp+1)/2; i++) {
        UIImageView *image = (UIImageView *)[self viewWithTag:1000+i];
        
        image.image = [UIImage imageNamed:@"starRating3"];
        
        if (temp%2 == 1) {
            UIImageView *image = (UIImageView *)[self viewWithTag:1000+temp/2];
            if (!self.isNeedHalf) {
                image.image = [UIImage imageNamed:@"starRating3"];
            }else{
                image.image = [UIImage imageNamed:@"starRating2"];
            }
        }
    }
    
    for (NSInteger i = (temp+1)/2; i < 5; i++) {
        UIImageView *iamge = (UIImageView *)[self viewWithTag:1000+i];
        iamge.image = [UIImage imageNamed:@"starRating1"];
    }
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *touch = [touches anyObject];
    //获取移动之后的坐标变化
    CGPoint newPoint = [touch locationInView:self];
    NSInteger temp = newPoint.x / 12+1;
    if (temp > 1) {
        for (NSInteger i = 0; i < temp/2; i++) {
            UIImageView *iamge = (UIImageView *)[self viewWithTag:1000+i];
            iamge.image = [UIImage imageNamed:@"starRating3"];
            if (temp%2 == 1) {
                UIImageView *image = (UIImageView *)[self viewWithTag:1000+temp/2];
                if (!self.isNeedHalf) {
                    image.image = [UIImage imageNamed:@"starRating3"];
                }else{
                    image.image = [UIImage imageNamed:@"starRating2"];
                }
            }
        }
        
    }else if(temp == 1){
        
        UIImageView *image = (UIImageView *)[self viewWithTag:1000];
        if (!self.isNeedHalf) {
            image.image = [UIImage imageNamed:@"starRating3"];
        }else{
            image.image = [UIImage imageNamed:@"starRating2"];
        }
        
        for (NSInteger i = (temp+1)/2; i < 5; i++) {
            UIImageView *iamge = (UIImageView *)[self viewWithTag:1000+i];
            iamge.image = [UIImage imageNamed:@"starRating1"];
        }
        
    }
    for (NSInteger i = (temp+1)/2; i < 5; i++) {
        UIImageView *image = (UIImageView *)[self viewWithTag:1000+i];
        image.image = [UIImage imageNamed:@"starRating1"];
    }
    if (!self.isNeedHalf) {
        temp = (temp +1)/2 *2;
    }
    if (temp < 0) {
        temp = 0;
    }else if (temp > 10){
        temp = 10;
    }
    
    if (!self.isNeedHalf) {
        temp /= 2;
    }
    
    [self.delegate mannerGrade:[NSString stringWithFormat:@"%ld",temp]withView:self];

}

@end
