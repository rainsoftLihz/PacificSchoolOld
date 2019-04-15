//
//  LTTools.m
//  ELearning
//
//  Created by Jonny on 16/5/17.
//  Copyright © 2016年 LYG. All rights reserved.
//

#import "LTTools.h"
#import <CommonCrypto/CommonDigest.h>

#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@implementation LTTools

// 获取课程路径
+ (NSString *)getCoursePDFSavePath {
    
    NSArray *ary = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ary[0];
    
//    [[NSUserDefaults standardUserDefaults] objectForKey:@""];
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    NSString *pdfPath = [NSString stringWithFormat:@"%@/video%@/",documentpath,username];
    
    return pdfPath;
}

// 压缩图片
+ (UIImage *)imageScale:(UIImage *)img size:(CGSize)size {
 
    // 创建一个bitmap的context
    CGSize imgSize = img.size;
    
    if (imgSize.width * imgSize.height < 220000) {  // 500KB 以下就不压缩了
        return img;
    }
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
    
}

// 是否是QQ
+ (BOOL)isQqNumber:(NSString *)qqNum {
    
    NSString *qqstr = @"[1-9][0-9]{4,}";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqstr];
    return [qqTest evaluateWithObject:qqNum];
}

// 是否是手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,177
     22         */
    NSString * CT = @"^1((33|53|8[09]|77)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
        
    } else {
        
        return NO;
    }
}

// 判断是否为Email
+ (BOOL)isEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 判断是否为字母或数字
+ (BOOL)inputShouldLetterOrNum:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}

// 判断是否为空值
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    // 去掉前后空格，判断length是否为0
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"null"]||[string isEqualToString:@"<null>"]) {
        return YES;
    }
    // 后台容易返null类型的字符串
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    
    return NO;
}

// 是否有空格
+ (BOOL)isSpace:(NSString *)string {
    
    if([string rangeOfString:@" "].location != NSNotFound) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

+(CGFloat)rectWidthAndHeightWithStr:(NSString *)str AndFont:(CGFloat)fontFloat WithStrWidth:(CGFloat)width {
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontFloat]};//指定字号
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)/*计算高度要先指定宽度*/ options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
    
}

+ (CGFloat)widthWithString:(NSString *)str font:(CGFloat)fontSize {
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
     CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return size.width;
}

+ (CGFloat)heightWithString:(NSString *)str font:(CGFloat)fontSize {
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    return size.height;
}

+ (NSString*)encoding:(NSString*)unencodedString {
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    NSLog(@" %@",encodedString);
    return encodedString;
}

//  时间戳
+ (NSString *)timeStamp {
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSString* strTime = [NSString stringWithFormat:@"%0.f",timeStamp];
    return strTime;
}

//  MD5
+ (NSString *)MD5:(NSString *)aStr {
    if (aStr == nil || aStr.length == 0) {
        return nil;
    }
    const char *value = [aStr UTF8String];
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [outputString appendFormat:@"%02x",outputBuffer[i]];
    }
    return outputString;
}

+ (NSAttributedString *)htmlWithString:(NSString *)htmlString {
    if ([self isBlankString:htmlString]) {
        return [[NSAttributedString alloc]initWithString:@""];
    }
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    return attrStr;
}

+ (UIButton *)createBarButtonItem:(NSString *)imageName {
    UIButton * categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    categoryBtn.frame = CGRectMake(0, 0, 20, 20);
    categoryBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [categoryBtn setTitleColor:[UIColor whiteColor] forState:0];
    [categoryBtn setImage:[UIImage imageNamed:imageName] forState:0];
    
    return categoryBtn;
}

+ (NSString *)deleteString:(NSString *)base {
    
    NSString *str1 = @"<b>";
    NSString *str2 = @"</b>";
    NSString *str3 = @"<span>";
    NSString *str4 = @"</span>";
    NSString *str5 = @"&nbsp;";
    NSString *str6 = @"&nbsp";

    
    NSMutableString *baseString = [[NSMutableString alloc]initWithString:base];
    NSRange range1 = [baseString rangeOfString:str1];
    if (range1.location != NSNotFound) {
        [baseString deleteCharactersInRange:range1];
    }
    
    NSRange range2 = [baseString rangeOfString:str2];
    
    if (range2.location != NSNotFound) {
        [baseString deleteCharactersInRange:range2];
    }
    
    NSRange range3 = [baseString rangeOfString:str3];
    
    if (range3.location != NSNotFound) {
        [baseString deleteCharactersInRange:range3];
    }
    
    NSRange range4 = [baseString rangeOfString:str4];
    
    if (range4.location != NSNotFound) {
        [baseString deleteCharactersInRange:range4];
    }
    
    NSRange range5 = [baseString rangeOfString:str5];
    
    if (range5.location != NSNotFound) {
        [baseString deleteCharactersInRange:range5];
    }
    
    NSRange range6 = [baseString rangeOfString:str6];
    
    if (range6.location != NSNotFound) {
        [baseString deleteCharactersInRange:range6];
    }
    
    return [baseString copy];
}

// 字符串转数组
+ (NSArray *)stringConversionArray:(NSString *)string {
    NSMutableArray *ary = [NSMutableArray array];
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:string];
    for (int i = 0 ; i < string.length ; i ++) {
        NSRange range = NSMakeRange(i,1);
        [ary addObject:[mutableString substringWithRange:range]];
    }
    return ary;
}

- (NSArray *)sortInsertionHanndle:(NSArray *)baseAry handle:(BOOL (^)(id obj0, id obj1))handle {
    NSMutableArray *array = [baseAry mutableCopy];
    
    for (int i = 0; i < array.count; i++) {
        for (int j = i+1; j < array.count; j++) {
            
            id o0 = [array objectAtIndex:i];
            id o1 = [array objectAtIndex:j];
            
            if (handle(o0, o1)) {
                [array replaceObjectAtIndex:i withObject:o1];
                [array replaceObjectAtIndex:j withObject:o0];
            }
        }
    }
    return [array copy];
}

+ (NSString *)checkStringIsNull:(NSString *)string {
    
    if ([LTTools isBlankString:string]) {
        return @"";
    }return string;
    
}

// 时间
+ (NSString *)getTime {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *dateTime = [formatter stringFromDate:date];
    NSLog(@" 当前时间%@",dateTime);
    return dateTime;
}

// 根据 range 删除字符串
+ (NSString *)deleteStringRange:(NSRange)range baseString:(NSString *)string{
    
    NSMutableString *baseString = [string mutableCopy];
    [baseString deleteCharactersInRange:range];
    return [baseString copy];
}


+ (NSString *)deleteStringOptionString:(NSString *)optionString baseString:(NSString *)baseString {
    NSMutableString *optionStrings = [optionString mutableCopy];
    NSRange range = [optionStrings rangeOfString:baseString];
    if (range.location !=NSNotFound) {
        [optionStrings deleteCharactersInRange:NSMakeRange(0, range.location+1)];
        return [optionStrings copy];

    }return [optionStrings copy];
}

+ (NSString *)getPath {
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return  [NSString stringWithFormat:@"%@/QSPDownloadTool_DownloadDataDocument_Path/",path];
}

+ (NSMutableArray *)getImageDownloadURL:(NSString *)strURL {
    
    NSMutableArray *saveImageArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableString *str;
    NSString *strTemp = @"src=\"";
    NSString *strHttpTemp = @"src=\"http";
    NSRange range;
    BOOL httpFlg = YES;
    str = [[NSMutableString alloc] initWithString:strURL];
    range = [str rangeOfString:strHttpTemp];
    if (range.length == 0) {
        range = [str rangeOfString:strTemp];
        httpFlg = NO;
    }
    while (range.length != 0) {
        if (!httpFlg) {
            
            
            NSArray *httpStrArray = [kApi_base_url componentsSeparatedByString:@"/"];
            if ([httpStrArray count]>2) {
                NSString *http = [NSString stringWithFormat:@"http://%@",[httpStrArray objectAtIndex:2]];
                [str insertString:http atIndex:range.location + strTemp.length];
            }
        }
        NSRange range1 = [str rangeOfString:strTemp];
        NSString *strStart = [str substringFromIndex:range1.location];
        NSRange rangeSaveStart = [strStart rangeOfString:@"\"http"];
        NSString *strSaveStart;
        NSRange rangeSaveEnd;
        if (rangeSaveStart.length != 0) {
            strSaveStart = [strStart substringFromIndex:rangeSaveStart.location + 1];
        } else {
            strSaveStart = strSaveStart;
        }
        rangeSaveEnd = [strSaveStart rangeOfString:@"\""];
        NSString *strSaveEnd;
        if (rangeSaveEnd.length != 0) {
            strSaveEnd = [strSaveStart substringToIndex:rangeSaveEnd.location];
        } else {
            strSaveEnd = [strStart substringToIndex:rangeSaveEnd.location];
        }
        [saveImageArray addObject:strSaveEnd];
        NSRange range2 = [strStart rangeOfString:@">"];
        NSString *strEnd = [strStart substringFromIndex:range2.location + 1];
        str = [[NSMutableString alloc] initWithFormat:@"%@", strEnd];
        range = [str rangeOfString:strHttpTemp];
        httpFlg = YES;
        if (range.length == 0) {
            range = [str rangeOfString:@"src=\""];
            httpFlg = NO;
        }
    }
    //NSLog(@"下载图片路径 %@",saveImageArray);
    return saveImageArray;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError =nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
