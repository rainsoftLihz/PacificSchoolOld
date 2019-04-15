//
//  XTMainFontView.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/7.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMainFootView.h"

@implementation XTMainFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headView.layer.cornerRadius = 25;
        self.headView.layer.masksToBounds = YES;
//        self.headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.headView.layer.cornerRadius = 25;
        self.headView.layer.masksToBounds = YES;
    }
    return self;
}

@end
