//
//  DDHomeViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDAuthManager.h"

@implementation DDAuthManager

+ (instancetype)sharedManager {
    static DDAuthManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (BOOL)isGuest {
    id loginInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"DKLoginInfo"];
    if (!loginInfo) {
        return YES;
    }
    return NO;
}

- (void)login:(NSDictionary *)loginInfo {
    if (loginInfo) {
        [[NSUserDefaults standardUserDefaults] setObject:loginInfo forKey:@"DKLoginInfo"];
    }
}

- (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DKLoginInfo"];
}

- (NSDictionary *)loginInfo {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"DKLoginInfo"];
}

- (void)updateCalibrationLevel:(NSNumber *)level {
    [[NSUserDefaults standardUserDefaults] setObject:level forKey:@"DKCalibrationLevel"];
}

- (NSNumber *)calibrationLevel {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"DKCalibrationLevel"] ?: @(0);
}

@end
