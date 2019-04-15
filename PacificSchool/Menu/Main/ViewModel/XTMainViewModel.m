//
//  XTMainViewModel.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/5.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTMainViewModel.h"
#import "SVProgressHUD.h"
#import "XTMyCourseModel.h"
#import "XTCourseModel.h"
#import "XTRankModel.h"
#import "XTCourseDetailModel.h"
#import "XTCoursewareDetailModel.h"
#import "XTCommentModel.h"
#import "XTHistoryModel.h"
#import "XTAiExamUserDetailModel.h"

@implementation XTMainViewModel

// 获取详情
+ (void)getDetail:(void (^)(NSDictionary *result))success {

    [SVProgressHUD show];
    [LTNetWorkManager post:kGetDetail params:nil success:^(NSDictionary *result) {
        
        NSLog(@"用户统计 %@",result);
        success(result);
        [SVProgressHUD dismiss];
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
}

+ (void)getHistory:(void (^)(NSArray *result))success {
    
    [SVProgressHUD show];
   
    [LTNetWorkManager post:kGetHistory params:nil success:^(NSDictionary *result) {
        NSLog(@"历史 == %@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            NSArray *list = result[@"data"][@"list"];
            NSArray *models =  [XTHistoryModel mj_objectArrayWithKeyValuesArray:list];
            success(models);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}


+ (void)getTokenWithParam:(NSDictionary *)param success:(void (^)(NSDictionary *result))success {
    
    [SVProgressHUD show];
    NSString *userid = DEF_PERSISTENT_GET_OBJECT(kUserId);
    NSString *userToken = DEF_PERSISTENT_GET_OBJECT(kUserToken);
    
    NSString *url = [NSString stringWithFormat:@"%@&coopCode=cpic&frontUserId=%@&accessToken=%@",kGetToken,userid,userToken];
    NSLog(@" url =====  %@ json==%@",url,[param mj_JSONString]);
//    n&coopCode=1&frontUserId=1&accessToken=1
    [LTNetWorkManager postWithUrl:url param:[param mj_JSONString] success:^(NSDictionary *result) {
        [SVProgressHUD dismiss];
        success(result);
    } fail:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];

    }];
    
}


+ (void)getCourseComment:(NSDictionary *)param success:(void (^)(NSArray *result))success {
    
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetCourseComment params:param success:^(NSDictionary *result) {
        NSLog(@"信息%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            NSArray *list = result[@"data"][@"list"];
            NSArray *models = [XTCommentModel mj_objectArrayWithKeyValuesArray:list];
            success(models);

        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)insterCourseComment:(NSDictionary *)param success:(void (^)(NSDictionary *result))success {
    
    [SVProgressHUD show];
    [LTNetWorkManager post:kInsterCourseComment params:param success:^(NSDictionary *result) {
        NSLog(@"信息%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            success(result);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}


+ (void)getUserCPIC:(void (^)(NSDictionary *result))success {
    
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetUserCPIC params:nil success:^(NSDictionary *result) {
        NSLog(@"信息%@",result);
        [SVProgressHUD dismiss];
        success(result);
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)getUserInfo:(void (^)(NSDictionary *result))success {

    [SVProgressHUD show];
    [LTNetWorkManager post:kGetUserInfo params:nil success:^(NSDictionary *result) {
        NSLog(@"信息%@",result);
        [SVProgressHUD dismiss];
        success(result);
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)getSignDataSuccess:(void (^)(NSDictionary *result))success {
    [LTNetWorkManager post:kGetSignInfo params:nil success:^(NSDictionary *result) {
        NSLog(@"获取打卡信息%@",result);
        [SVProgressHUD dismiss];
        success(result);
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)getSaveSign:(void (^)(NSDictionary *result))success {
    [LTNetWorkManager post:kSaveSign params:nil success:^(NSDictionary *result) {
        NSLog(@"打卡%@",result);
        [SVProgressHUD dismiss];
        success(result);
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)postMainDataSuccess:(void (^)(NSDictionary *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetMainData params:nil success:^(NSDictionary *result) {
        NSLog(@"首页数据%@",result);
        [SVProgressHUD dismiss];
        success(result);
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)getMtMapDataSuccess:(void (^)(NSArray *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetMyMap params:nil success:^(NSDictionary *result) {
        NSLog(@"我的课程%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            NSArray *list = result[@"data"][@"elnMapList"];
            NSArray *models = [XTMyCourseModel mj_objectArrayWithKeyValuesArray:list];
            success(models);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
}

+ (void)getHotSuccess:(void (^)(NSArray *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetHot params:nil success:^(NSDictionary *result) {
        NSLog(@"热门 == %@",result);
        
        if ([[NSString stringWithFormat:@"%@",result[@"ret"]] isEqualToString:@"0"]) {
            NSArray *list = result[@"data"][@"list"];
            NSArray *models = [XTCourseModel mj_objectArrayWithKeyValuesArray:list];
            success(models);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];

}

+ (void)getRecommendSuccess:(void (^)(NSArray *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetRecommend params:nil success:^(NSDictionary *result) {
        NSLog(@"推荐%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            NSArray *list = result[@"data"][@"list"];
            NSArray *models = [XTCourseModel mj_objectArrayWithKeyValuesArray:list];
            success(models);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
    
}

+ (void)getCourseCompleteSuccess:(void (^)(NSArray *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetComplete params:nil success:^(NSDictionary *result) {
        NSLog(@"完成%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            NSArray *list = result[@"data"][@"elnMapList"];
            NSArray *models = [XTMyCourseModel mj_objectArrayWithKeyValuesArray:list];
            success(models);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)getCourseDetailSuccess:(NSDictionary *)param success:(void (^)(XTCourseDetailModel *result))success {
    NSLog(@"parmas======%@",param);
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetCourseDetail params:param success:^(NSDictionary *result) {
        NSLog(@"课程详情%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            NSDictionary *list = result[@"data"];
            XTCourseDetailModel *model = [XTCourseDetailModel mj_objectWithKeyValues:list];
            success(model);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)getCoursewareDetailSuccess:(NSDictionary *)param success:(void (^)(XTCoursewareDetailModel *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetCoursewareDetail params:param success:^(NSDictionary *result) {
        NSLog(@"===%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            NSDictionary *list = result[@"data"];
            XTCoursewareDetailModel *model = [XTCoursewareDetailModel mj_objectWithKeyValues:list];
            success(model);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
}

+ (void)saveCoursewareDateSuccess:(NSDictionary *)param success:(void (^)(NSDictionary *result))success {
    [SVProgressHUD show];
    
    [LTNetWorkManager post:kSaveInert params:param success:^(NSDictionary *result) {
        NSLog(@"===%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
//            NSDictionary *list = result[@"data"];
//            XTCoursewareDetailModel *model = [XTCoursewareDetailModel mj_objectWithKeyValues:list];
            NSString *studyTime = [NSString stringWithFormat:@"同步学习时间成功,本次学习时间为:%@秒",result[@"data"][@"elnCourseStudyLog"][@"studyTime"]];
//            [SVProgressHUD setMaximumDismissTimeInterval:5];

            [SVProgressHUD showWithStatus:studyTime];
            [SVProgressHUD dismissWithDelay:3];
            success(result);
        }else {
            
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}



+ (void)getRankSuccess:(void (^)(NSArray *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetRankList params:nil success:^(NSDictionary *result) {
        NSLog(@"排名%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            NSArray *list = result[@"data"][@"list"];
            NSArray *models = [XTRankModel mj_objectArrayWithKeyValuesArray:list];
            success(models);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)getExamDetailSuccess:(NSDictionary *)param success:(void (^)(NSDictionary *result))success {
    [LTNetWorkManager post:kGetEvaluateUserDetail params:param success:^(NSDictionary *result) {
        NSLog(@"考试结果%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            success(result[@"data"][@"aiExamUserDetail"]);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
}

+ (void)getMatchingSuccess:(NSDictionary *)param success:(void (^)(NSDictionary *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kGetMatchingDegree params:param success:^(NSDictionary *result) {
        NSLog(@"匹配结果%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            success(result);
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

+ (void)logout:(void (^)(NSDictionary *result))success {
    [SVProgressHUD show];
    [LTNetWorkManager post:kLogout params:nil success:^(NSDictionary *result) {
        NSLog(@"退出登录%@",result);
        if ([result[@"ret"] isEqualToString:@"0"]) {
            success(result);
        }else {
            //[SVProgressHUD showErrorWithStatus:@"退出错误"];
            success(result);
        }

        
    } failure:^(NSString *msg) {
        [SVProgressHUD showErrorWithStatus:msg];
    }];
    
}

@end
