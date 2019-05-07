//
//  VoiceRecognizeRequest.m
//  PacificSchool
//
//  Created by rainsoft on 2019/5/6.
//  Copyright © 2019年 Jonny. All rights reserved.
//

#import "VoiceRecognizeRequest.h"

@implementation VoiceRecognizeRequest
    
- (instancetype)initWith:(NSString*)token appId:(NSString*)appId reqNo:(NSString*)reqNo
    rate:(NSString*)rate  audioStatus:(NSString*)audioStatus
{
    self = [super init];
    if (self) {
        self.token = token;
        
        self.appId = appId;
        
        self.reqNo = reqNo;
        
        self.rate = rate;
        
        self.audioStatus = audioStatus;
    }
    return self;
}
    
@end
