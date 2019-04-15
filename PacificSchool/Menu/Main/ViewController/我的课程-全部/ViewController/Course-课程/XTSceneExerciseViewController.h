//
//  XTSceneExerciseViewController.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/13.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XTWebType) {
    XTWebTestType = 0,
    XTWebExamType
};


@interface XTSceneExerciseViewController : XTBaseViewController
@property (nonatomic,assign) XTWebType webType;


@property (nonatomic,strong)NSString *examId;
@property (nonatomic,copy)NSString *examTitle;

@end

NS_ASSUME_NONNULL_END
