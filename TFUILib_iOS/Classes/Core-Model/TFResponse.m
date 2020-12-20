//
//  BaseResponse.m
//  SSXQ
//
//  Created by sunxiaofei on 16/3/2.
//  Copyright © 2016年 sunxiaofei. All rights reserved.
//

#import "TFResponse.h"

@implementation TFResponse

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.errorCode = 0;
        self.errorMessage = @"";
    }
    return self;
}

-(instancetype)initWithErrorCode:(NSInteger)errorCode
{
    self = [super init];
    if (self)
    {
        self.errorCode = errorCode;
        self.errorMessage = nil;
    }
    return self;
}

-(instancetype)initWithErrorCode:(NSInteger)errorCode errorMessage:(NSString*)errorMessage
{
    self = [super init];
    if (self)
    {
        self.errorCode = errorCode;
        self.errorMessage = errorMessage;
    }
    return self;
}

@end
