//
//  ApiHeader.h
//  PacificSchool
//
//  Created by Jonny on 2019/3/5.
//  Copyright © 2019 Jonny. All rights reserved.
//

#ifndef ApiHeader_h
#define ApiHeader_h

/*
 // Sit测试
 //https://zhxy-ft.cpic.com.cn/elnApi/api/
 // 公有云
 //http://tapi.pomesoft.com/api/
 // 生产
 //https://aitraining.cpic.com.cn/elnApi/api/
 */


/*!
 *
 *  @brief 正式环境: 0
 *
 *  @brief 测试环境: 1
 */
#define kAppIsProduction 1

/*!
 *
 *  @brief 公有云环境: 1
 */
#define kAppIsPomesoft 0


#if kAppIsProduction

   // 公网环境
   #if kAppIsPomesoft

    #define kApi_base_url @"https://tapi.pomesoft.com"

    #define kApi_base_Add @"/api/"

    #define kApi_FileServer_url @"http://fileserver.pomesoft.com"

    #define kVoiceRegister @"http://voiceprint.iflysec.com/api/voiceprint/register"

    #define kVoiceAuthentication @"http://voiceprint.iflysec.com/api/voiceprint/authentication"

    #define kZhxy @"https://learntestweb.wezhuiyi.com/"

    //获取token
    #define kGetToken @"https://learntestweb.wezhuiyi.com/api/v1/examTraining?m=getByAccessToken"


  #else
    // sit环境
    #define kApi_base_url @"https://zhxy-ft.cpic.com.cn"

    #define kApi_base_Add @"/elnApi/api/"

    #define kApi_FileServer_url @"http://zhxy-ft.cpic.com.cn/elnFile"

    // 声纹注册
    #define kVoiceRegister @"https://zhxy-ft.cpic.com.cn/sw/api/voiceprint/register"

    // 声纹登录
    #define kVoiceAuthentication @"https://zhxy-ft.cpic.com.cn/sw/api/voiceprint/authentication"

    // 通关考及情景演练
    #define kZhxy @"https://zhxy-ft.cpic.com.cn/"

    //获取token
    #define kGetToken @"https://zhxy-ft.cpic.com.cn/api/v1/examTraining?m=getByAccessToken"

   #endif





#else

    /***生产环境****/
    // 基地址
    #define kApi_base_url @"https://aitraining.cpic.com.cn"

    #define kApi_base_Add @"/elnApi/api/"

    //文件基地址
    #define kApi_FileServer_url @"http://aitraining.cpic.com.cn/elnFile"

    //获取token
    #define kGetToken @"https://aitraining.cpic.com.cn/api/v1/examTraining?m=getByAccessToken"

    //通关考及情景演练
    #define kZhxy @"https://aitraining.cpic.com.cn/"

    //声纹注册
    #define kVoiceRegister @"https://aitraining.cpic.com.cn/sw/api/voiceprint/register"

    //声纹登录
    #define kVoiceAuthentication @"https://aitraining.cpic.com.cn/sw/api/voiceprint/authentication"

#endif





#define ApiWithFormat(api) [NSString stringWithFormat:@"%@%@",kApi_base_Add,api]

#define kApiLogin ApiWithFormat(@"login.action?m=loginByCPIC")

#define kGetMainData ApiWithFormat(@"portalSetting.action?m=getAPPMainPageDataCPIC")

//我的课程
#define kGetMyMap ApiWithFormat(@"elnMap.action?m=getMyElnMap")

//推荐课程
#define kGetRecommend ApiWithFormat(@"elnMap.action?m=getPageRecommend")

//热门课程
#define kGetHot ApiWithFormat(@"elnMap.action?m=getPageHot")

//已完成
#define kGetComplete ApiWithFormat(@"elnMap.action?m=getMyElnMapComplete")

//获取详情
#define kGetCourseDetail ApiWithFormat(@"elnMap.action?m=getDetail")
//获取课件详情
#define kGetCoursewareDetail ApiWithFormat(@"elnCourse.action?m=getDetail")

//获取英雄榜
#define kGetRankList ApiWithFormat(@"frontUserStatistics.action?m=getRankListByRankNo")

// 保存学习z时间
#define kSaveInert ApiWithFormat(@"elnCourseStudyLog.action?m=insert")

// 打卡
#define kGetSignInfo ApiWithFormat(@"frontActLog.action?m=getSignInfoByStudyTime")

// 获取详情
#define kGetUserInfo ApiWithFormat(@"frontUser.action?m=getDetail")

// 雷达图数据
#define kGetUserCPIC ApiWithFormat(@"evaluateUserDetail.action?m=getChartByFrontUserCPIC")

// 获取课程评论
#define kGetCourseComment ApiWithFormat(@"elnCourseComment.action?m=getPageForum")

// 课程评论
#define kInsterCourseComment ApiWithFormat(@"elnCourseComment.action?m=insertForum")

//#define kGetToken ApiWithFormat(@"elnCourseComment.action?m=insertForum")
// 获取通关考考试结果

#define kGetEvaluateUserDetail ApiWithFormat(@"evaluateUserDetail.action?m=getCpicChartByDetailId")

//https://aitraining.cpic.com.cn/elnApi/api/evaluateUserDetail.action?m=getLastChartByObjectId&objectId=3078&objectType=aiExam&accessToken=e6c6606e26484ce39d746b98907f54ce&coopCode=cpic&frontUserId=e3dab3cecda94c728511c1db29acd3ea

// 上传头像
#define kFrontUserHeadimgurl ApiWithFormat(@"frontUser.action?m=updateHeadimgurl")

// 查询是否注册过
#define kGetVoiceCollectStatus ApiWithFormat(@"frontUser.action?m=getVoiceCollectStatus")

// 更新声纹注册信息
#define kUpdateVoiceCollectStatus ApiWithFormat(@"frontUser.action?m=updateVoiceCollectStatus")

// 历史
#define kGetHistory ApiWithFormat(@"aiExamUserDetail.action?m=getPage")

// 考试详情
#define kGetExmaDetail ApiWithFormat(@"aiExamDetail.action?m=getDetail")

// 语音对比
#define kGetMatchingDegree ApiWithFormat(@"aiVoiceToWords.action?m=getMatchingDegree")

// 注销
#define kLogout ApiWithFormat(@"login.action?m=logout")

// 获取用户统计
#define kGetDetail ApiWithFormat(@"frontUserStatistics.action?m=getDetail")

// 保存
#define kSaveSign ApiWithFormat(@"frontActLog.action?m=saveSign")


//https://learntestweb.wezhuiyi.com/api/v1/examTraining?m=getByAccessToken&coopCode=1&frontUserId=1&accessToken=1

//版本更新
#define kUpdate ApiWithFormat(@"sysAppLog.action?m=getLatest")

//获取智慧豆
#define kGetSign ApiWithFormat(@"/frontUserStatistics.action?m=getSignInfoByCPIC")

//提交评分
#define kSubmitScore ApiWithFormat(@"/commonScoreLog.action?m=insertByElnMap")

//评分详情
#define kScoreDetail ApiWithFormat(@"/commonScoreLog.action?m=getDetailByElnMap")

#endif /* ApiHeader_h */
