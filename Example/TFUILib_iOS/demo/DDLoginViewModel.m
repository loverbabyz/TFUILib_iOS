//
//  DDLoginViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Ingeek-091 on 2023/9/6.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDLoginViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDLoginViewModel

- (void)login:(NSDictionary *)form completion:(IntegerMsgBlock)completion {
    //  TODO: login logic code...
    
    kUserDefaults.model = [DemoModel tf_mj_objectWithKeyValues:form];
    
    NSInteger result = 0;
    NSString *message = @"";
    if (completion) {
        completion(result, message);
    }
}

- (NSString *)appId {
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

-(BOOL)ibeaconEnable {
    return kUserDefaults.model.ibeaconEnable;
}

@end
