//
//  XTExamResultViewController.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/17.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XTExamResultViewController : XTBaseViewController
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceResultLabel;
@property (copy, nonatomic)NSString *detailId;
@end

NS_ASSUME_NONNULL_END
