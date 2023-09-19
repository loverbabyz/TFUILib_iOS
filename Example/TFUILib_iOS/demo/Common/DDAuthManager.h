//
//  DDHomeViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDAuthManager : NSObject

/**
 * Creates and returns an 'DDAuthManager' object
 */
+ (instancetype)sharedManager;

/**
 * @method isGuest
 */
- (BOOL)isGuest;

/**
 * @method login
 */
- (void)login:(NSDictionary *)loginInfo;

/**
 * @method logout
 */
- (void)logout;

/**
 * @method loginInfo
 */
- (NSDictionary *)loginInfo;

/// 设置灵敏度
/// @param level level
- (void)updateCalibrationLevel:(NSNumber *)level;

/// 获取缓存的灵敏度
- (NSNumber *)calibrationLevel;

@end

NS_ASSUME_NONNULL_END
