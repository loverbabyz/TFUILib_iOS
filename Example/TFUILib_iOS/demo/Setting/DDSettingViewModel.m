//
//  DDSettingViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDSettingViewModel.h"
#import "TFUserDefaults+demo.h"
#import <TFUILib_iOS/TFFormRowModel.h>
#import <IngeekDK/IngeekDK.h>

@implementation DDSettingViewModel

- (NSString *)title {
    return TF_LSTR(@"SETTINGS");
}

- (void)fetchData:(IntegerBlock)completion {
    if (self.sdkVersion) {
        TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        row.value = self.sdkVersion;
    }
    
    if (self.commitId) {
        TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        row.value = self.commitId;
    }
    
    if (self.releaseDate) {
        TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        row.value = self.releaseDate;
    }
    
    if (self.appId) {
        TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        row.value = self.appId;
    }
    
    if (self.envriment) {
        TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
        row.value = self.envriment;
    }
    
    if (self.userId) {
        TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
        row.value = self.userId;
    }
    
    if (self.mobile) {
        TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
        row.value = self.mobile;
    }
    
    TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
    row.value = self.ibeaconEnable;
    
    row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    row.value = @(kUserDefaults.dispatchedOnMainQueue ? 1 : 0);
    
    row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    row.value = TF_STR(TF_STRINGIFY(%ld), kUserDefaults.logLevel);
    
    if (completion) {
        completion(0);
    }
}

- (void)save:(NSDictionary *)form completion:(VoidBlock)completion {
    kUserDefaults.dispatchedOnMainQueue = ((NSNumber *)form[kRowTag_dispatch]).boolValue;
    kUserDefaults.logLevel = ((NSNumber *)form[kRowTag_logLevel]).integerValue;
    
    [IngeekDkConfig sharedConfig].dispatchedOnMainQueue = kUserDefaults.dispatchedOnMainQueue;
    [IngeekDkConfig sharedConfig].logLevel = (IngeekDkLogLevel)kUserDefaults.logLevel;
    
    if (completion) {
        completion();
    }
}

- (void)logout:(VoidBlock)completion {
    [[IngeekDk sharedInstance] logout:^(NSInteger errorCode) {
        [kUserDefaults logout];
        
        if (completion) {
            completion();
        }
    }];
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
    return kUserDefaults.dispatchedOnMainQueue;
}

- (NSInteger)logLevel {
    return kUserDefaults.logLevel;
}

- (NSString *)ibeaconEnable {
    return  kUserDefaults.model.ibeaconEnable ? TF_LSTR(@"Enable") : TF_LSTR(@"Disabled");
}

- (NSString *)sdkVersion {
    return [[IngeekDk sharedInstance] getVersion].version;
}

- (NSString *)commitId {
    return [[IngeekDk sharedInstance] getVersion].commitId;
}

- (NSString *)releaseDate {
    return [[IngeekDk sharedInstance] getVersion].releaseDate;
}

@end
