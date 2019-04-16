//
//  XTRankViewController.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/4.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XTRankViewController : XTBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *myRankLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberThreeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)NSInteger rankNo;
@end

NS_ASSUME_NONNULL_END
