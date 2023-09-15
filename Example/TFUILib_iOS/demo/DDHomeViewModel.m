//
//  DDHomeViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDHomeViewModel.h"
#import "TFUserDefaults+demo.h"
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
@import TFUILib_iOS.TFFormRowModel;

@implementation DDHomeViewModel

- (NSString *)title {
    return @"Demo";
}

//- (void)feach:(VoidBlock)completion {
//    NSString *vin = kUserDefaults.vin;
//    
//    if (![vin isEmpty]) {
//        TFFormRowModel *row = (TFFormRowModel *)[self dataAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        row.value = vin;
//    }
//    
//    if (completion) {
//        completion();
//    }
//}

- (void)updateVIN:(NSString *)vin completion:(VoidBlock)completion {
    kUserDefaults.vin = vin;
    
    if (completion) {
        completion();
    }
}

- (NSString *)vin {
    return kUserDefaults.vin;
}

- (NSString *)appId {
    return kUserDefaults.model.appId;
}

@end
