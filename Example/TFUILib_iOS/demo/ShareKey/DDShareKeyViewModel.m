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
#import "define_tag.h"

@implementation DDShareKeyViewModel

- (NSString *)title {
    return TF_LSTR(@"SHARE KEY");
}

- (NSString *)vin {
    return kUserDefaults.vin;
}

- (void)shareKey:(NSDictionary *)form completion:(IntegerBlock)completion {
    NSDate *startTime = ((NSDate *)[form objectForKey:kRowTag_startTime]);
    NSDate *endTime = [form objectForKey:kRowTag_endTime];
    
    IngeekBleToBeSharedKey *limitedKey = [[IngeekBleToBeSharedKey alloc] init];
    limitedKey.pid = self.vin;
    limitedKey.mobile = [form objectForKey:kRowTag_mobile];
    limitedKey.userName = [form objectForKey:kRowTag_userName];
    limitedKey.startTime = [startTime timeIntervalSince1970] * 1000;
    limitedKey.endTime = [endTime timeIntervalSince1970] * 1000;
    NSScanner *scanner = [NSScanner scannerWithString:[form objectForKey:kRowTag_kpre]];
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
