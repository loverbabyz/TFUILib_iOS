//
//  DDShareKeyViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDShareKeyViewModel.h"
#import "TFUserDefaults+demo.h"
#import <IngeekDK/IngeekDK.h>

@implementation DDShareKeyViewModel

- (NSString *)title {
    return TF_LSTR(@"SHARE KEY");
}

- (NSString *)vin {
    return kUserDefaults.vin;
}

- (void)shareKey:(NSDictionary *)form completion:(IntegerBlock)completion {
    NSDate *startDate = [form objectForKey:TF_STRINGIFY(startDate)];
    NSDate *endDate = [form objectForKey:TF_STRINGIFY(endDate)];
    
    IngeekBleToBeSharedKey *limitedKey = [[IngeekBleToBeSharedKey alloc] init];
    limitedKey.pid = self.vin;
    limitedKey.mobile = [form objectForKey:TF_STRINGIFY(mobile)];
    limitedKey.userName = [form objectForKey:TF_STRINGIFY(userName)];
    limitedKey.startTime = [startDate timeIntervalSince1970] * 1000;
    limitedKey.endTime = [endDate timeIntervalSince1970] * 1000;
    NSScanner *scanner = [NSScanner scannerWithString:[form objectForKey:TF_STRINGIFY(KPRE)]];
    unsigned long long kpre;
    [scanner scanHexLongLong:&kpre];
    NSString *kpreValue = [NSString stringWithFormat:@"%02llx",kpre];
    limitedKey.kpre = kpreValue;
    
    
    [[IngeekBle sharedInstance] shareKey:limitedKey completion:^(NSInteger errorCode) {
        NSLog(@"#### error code: %d", (int)errorCode);
        if (completion) {
            completion(errorCode);
        }
    }];
}

@end
