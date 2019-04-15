//
//  XTDesModel.m
//  PacificSchool
//
//  Created by Jonny on 2019/3/22.
//  Copyright © 2019 Jonny. All rights reserved.
//

#import "XTDesModel.h"

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation XTDesModel

//加密
+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    size_t dataLength = [plainText length];
    //==================
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    NSString *testString = key;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];
    
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          (void *)bufferPtr, bufferPtrSize,
                                          &movedBytes);
    if (cryptStatus == kCCSuccess) {
        
        ciphertext= [self parseByte2HexString:bufferPtr :(int)movedBytes];
        
    }
    ciphertext=[ciphertext uppercaseString];//字符变大写
    
    return ciphertext ;
}

+ (NSString *)encodeDesWithString:(NSString *)str key:(NSString *)key
{
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    
    const void *vinitVec = (const void *) [str UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,kCCAlgorithmDES,kCCOptionPKCS7Padding,vkey,kCCKeySizeDES,vinitVec,vplainText,plainTextBufferSize,(void *)bufferPtr,bufferPtrSize,&movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    
    NSString *result = [myData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return result;
    
}

+ (NSString *) parseByte2HexString:(Byte *) bytes  :(int)len{
    
    NSString *hexStr = @"";
    
    if(bytes)
    {
        for(int i=0;i<len;i++)
        {
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
            if([newHexStr length]==1)
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            else
            {
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
            
            NSLog(@"%@",hexStr);
        }
    }
    
    return hexStr;
}
+ (long long)random8Numbers
{
    return [self randomNumber:10000000 to:100000000];
}

+ (long long)randomNumber:(long long)from to:(long long)to
{
    return (long long)(from + arc4random() % (to - from + 1));
}

+ (NSString *)encryptUseDES1:(NSString *)plainText key:(NSString *)key
{
    NSMutableString *ciphertext = [NSMutableString new];//用于拼接加密后的字符串
    NSData * encryptData =[plainText dataUsingEncoding:NSUTF8StringEncoding];//明文转二进制
    const char *encryptBytes = (const char *)[encryptData bytes];//转字符
    size_t encryptDataLength = [encryptData length];//获取字符长度
    NSData * keyData =[key dataUsingEncoding:NSUTF8StringEncoding];//密钥转二进制
    const char *keyBytes = (const char *)[keyData bytes];//密钥转字符
    //size_t keyDataLength = [keyData length];//获取密钥长度(默认kCCKeySizeDES 8位，你也可以传入自己获取的长度，前提你的key只能写前八位)
    NSString * iv =[NSString stringWithFormat:@"%lld",[self random8Numbers]];//获取8位随机数向量
    NSData * ivData =[iv dataUsingEncoding:NSUTF8StringEncoding];//向量转二进制
    const char *ivBytes = (const char *)[ivData bytes];//向量转字符
    unsigned char buffer[1024 *15];//加密缓存大小 自己写的15k大小 1k 1024b 容纳512个汉子
    memset(buffer, 0, sizeof(char));//给缓存区开辟内存空间
    size_t numBytesEncrypted = 0;//用来表示长度
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,//加密，加密类型DES
                                          kCCOptionPKCS7Padding,//在JAVA中使用这种方式加密："DES/CBC/PKCS5Padding" 对应的OC的是 kCCOptionPKCS7Padding.
                                          keyBytes, kCCKeySizeDES,//密钥字符数据，密钥字符长度
                                          ivBytes,//向量字符数据
                                          encryptBytes, encryptDataLength,//明文字符数据，明文字符长度
                                          buffer, 1024 *15,//缓存buffer，缓存buffer长度
                                          &numBytesEncrypted);//获取加密后的字符长度
    if (cryptStatus == kCCSuccess)//加密成功
    {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];//获取加密后的二进制数据
        NSString * one =[self convertDataToHexStr:[iv dataUsingEncoding:NSUTF8StringEncoding]];//向量二进制数据转16进制字符串
        NSString * two = [self convertDataToHexStr:data];//加密后的二进制转16进制字符串
        [ciphertext appendString:one];//拼接向量(根据后台需求 可能固定的向量就不用拼接)
        [ciphertext appendString:two];//拼接加密后的数据
        [ciphertext uppercaseString];//转大写   以上都是根据服务端需求来写,有些可能不是转16进制，可能是base64，可以用GTMBase库，github上搜一下就行。
    }
    return [ciphertext copy];//返回最后字符串 传给后台
}

+ (NSString *)convertDataToHexStr:(NSData *)data
{
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    
    NSData* cipherData = [self convertHexStrToData:[cipherText lowercaseString]];
    NSLog(@"++++++++///%@",cipherData);
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    NSString *testString = key;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    Byte *iv = (Byte *)[testData bytes];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
    
}

+ (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    NSLog(@"hexdata: %@", hexData);
    return hexData;
}

static Byte iv[] = {1,2,3,4,5,6,7,8};

+ (NSString *) encryptUseDES2:(NSString *)plainText key:(NSString *)key {
    
    NSString *ciphertext = nil;
    
    const char *textBytes = [plainText UTF8String];
    
    NSUInteger dataLength = [plainText length];
    
    
    unsigned char buffer[1024];
    
    memset(buffer, 0, sizeof(char));
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          
                                          kCCOptionECBMode|kCCOptionPKCS7Padding,  //kCCOptionECBMode  kCCOptionPKCS7Padding
                                          
                                          [key UTF8String], kCCKeySizeDES,
                                          
                                          iv,
                                          
                                          textBytes, dataLength,
                                          
                                          buffer, 1024,
                                          
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        //NSLog(@"ssf:%s",buffer);
        ciphertext = [self base64Encoding:data];
     
    }
    
    return ciphertext;
}

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

+ (NSString *)base64Encoding:(NSData*) text {
    if (text.length == 0)
        return @"";
    
    char *characters = malloc(text.length*3/2);
    
    if (characters == NULL)
        return @"";
    
    int end = text.length - 3;
    int index = 0;
    int charCount = 0;
    int n = 0;
    
    while (index <= end) {
        int d = (((int)(((char *)[text bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[text bytes])[index + 1]) & 0x0ff) << 8)
        | ((int)(((char *)[text bytes])[index + 2]) & 0x0ff);
        
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = encodingTable[d & 63];
        
        index += 3;
        
        if(n++ >= 14)
        {
            n = 0;
            characters[charCount++] = ' ';
        }
    }
    
    if(index == text.length - 2)
    {
        int d = (((int)(((char *)[text bytes])[index]) & 0x0ff) << 16)
        | (((int)(((char *)[text bytes])[index + 1]) & 255) << 8);
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = encodingTable[(d >> 6) & 63];
        characters[charCount++] = '=';
    }
    else if(index == text.length - 1)
    {
        int d = ((int)(((char *)[text bytes])[index]) & 0x0ff) << 16;
        characters[charCount++] = encodingTable[(d >> 18) & 63];
        characters[charCount++] = encodingTable[(d >> 12) & 63];
        characters[charCount++] = '=';
        characters[charCount++] = '=';
    }
    NSString * rtnStr = [[NSString alloc] initWithBytesNoCopy:characters length:charCount encoding:NSUTF8StringEncoding freeWhenDone:YES];
    return rtnStr;
}

@end
