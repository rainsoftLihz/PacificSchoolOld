//
//  LTTools.h
//  ELearning
//
//  Created by Jonny on 16/5/17.
//  Copyright © 2016年 LYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTTools : NSObject



/* 获取课程保存地址 */
+ (NSString *)getCoursePDFSavePath;

/* 压缩图片 */
+ (UIImage *)imageScale:(UIImage *)img size:(CGSize)size;

/* 判断是不是QQ号 */
+ (BOOL)isQqNumber:(NSString *)qqNum;

/* 判断手机号 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/*  验证电子邮件 */
+ (BOOL)isEmail:(NSString *)email;

/*  字母或数字 */
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString;

/* 验证字符串是否为空 */
+ (BOOL)isBlankString:(NSString *)string;

/* 验证字符串是否有空格 */
+(BOOL)isSpace:(NSString *)string;

/* 计算高度 */
+(CGFloat)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat WithStrWidth:(CGFloat)width;

/* 计算宽度 */
+ (CGFloat)widthWithString:(NSString *)str font:(CGFloat)fontSize;

/* 计算高度 */
+ (CGFloat)heightWithString:(NSString *)str font:(CGFloat)fontSize;

/* 对url进行编码 */
+ (NSString*)encoding:(NSString*)unencodedString;

/* 时间戳 */
+ (NSString *)timeStamp;

/* MD5 */
+ (NSString *)MD5:(NSString *)aStr;

/* 网页标签转换 */
+ (NSAttributedString *)htmlWithString:(NSString *)htmlString;

/* 创建BarButton */
+ (UIButton *)createBarButtonItem:(NSString *)imageName;

/* 删除字符串 */
+ (NSString *)deleteString:(NSString *)base;

/* 字符串转为数组 */
+ (NSArray *)stringConversionArray:(NSString *)string;

/* 检查是否为空*/
+ (NSString *)checkStringIsNull:(NSString *)string;

/* 获取时间*/
+ (NSString *)getTime;

/* 根据字符串删除*/
+ (NSString *)deleteStringRange:(NSRange)range baseString:(NSString *)string;

/* 根据固定位置删除这个字符串之前的字符（包含这个字符）*/
+ (NSString *)deleteStringOptionString:(NSString *)optionString baseString:(NSString *)baseString;

- (NSArray *)sortInsertionHanndle:(NSArray *)baseAry handle:(BOOL (^)(id obj0, id obj1))handle;

/* 获取地址本机Document地址 */
+ (NSString *)getPath;

/* 获取图片路径 */
+ (NSMutableArray *)getImageDownloadURL:(NSString *)strURL;

/* 转Json*/
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
