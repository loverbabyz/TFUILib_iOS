//
//  DDShareKeyViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDShareKeyViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDShareKeyViewModel

- (NSString *)title {
    return TF_LSTR(@"SHARE KEY");
}

- (NSString *)vin {
    return kUserDefaults.vin;
}

- (void)shareKey:(NSDictionary *)form completion:(IntegerBlock)completion {
    
//    IngeekBleToBeSharedKey *limitedKey = [[IngeekBleToBeSharedKey alloc] init];
//    limitedKey.pid = self.vin;
//    limitedKey.mobile = [self.values objectForKey:kStringify(MOBILE)];
//    limitedKey.userName = [self.values objectForKey:kStringify(NAME)];
//    limitedKey.startTime = [startDate timeIntervalSince1970] * 1000;
//    limitedKey.endTime = [endDate timeIntervalSince1970] * 1000;
//    NSScanner *scanner = [NSScanner scannerWithString:[self.values objectForKey:kStringify(KPRE)]];
//    unsigned long long kpre;
//    [scanner scanHexLongLong:&kpre];
//    NSString *kpreValue = [NSString stringWithFormat:@"%02llx",kpre];
//    limitedKey.kpre = kpreValue;
//    
//    
//    [[IngeekBle sharedInstance] shareKey:limitedKey completion:^(NSInteger errorCode) {
//        NSLog(@"#### error code: %d", (int)errorCode);
//        if (!errorCode) {
//            [self showMessageView:TF_LSTR(@"Share success.") duration:2 color:kSuccessColor];
//        } else {
//            NSString *msg = [NSString stringWithFormat:TF_LSTR(@"Share failed, error: %@"), EMSG(errorCode)];
//            [self showMessageView:msg duration:2 color:kErrorColor];
//        }
//    }];
}

@end
