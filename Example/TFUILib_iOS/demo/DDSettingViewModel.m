//
//  DDSettingViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDSettingViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDSettingViewModel

- (void)save:(NSDictionary *)form completion:(IntegerMsgBlock)completion {
    //  TODO: login logic code...
    
    kUserDefaults.dispatch = ((NSNumber *)form[kRowTag_dispatch]).boolValue;
    kUserDefaults.logLevel = ((NSNumber *)form[kRowTag_logLevel]).integerValue;
    
    NSInteger result = 0;
    NSString *message = @"";
    if (completion) {
        completion(result, message);
    }
}

- (void)logout:(IntegerMsgBlock)completion {
    [kUserDefaults logout];
}

- (NSString *)appId{
    return kUserDefaults.model.appId;
}

- (NSString *)envriment {
    return kUserDefaults.model.envriment;
}

- (NSString *)userId {
    return kUserDefaults.model.userId;
}

- (NSString *)mobile {
    return kUserDefaults.model.mobile;
}

- (BOOL)dispatch {
    return kUserDefaults.dispatch;
}

- (NSInteger)logLevel {
    return kUserDefaults.logLevel;
}

@end
