//
//  UIView+Shake.h
//  UIView+Shake
//
//  Created by Daniel on 15/7/1.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ShakeDirection) {
    ShakeDirectionHorizontal = 0,
    ShakeDirectionVertical
};

@interface UIView (Shake)

/**
 *  摇一摇
 */
- (void)shake;

/**
 *  摇一摇
 *
 *  @param times 时间
 *  @param delta 角度
 */
- (void)shake:(int)times withDelta:(CGFloat)delta;

/**
 *  摇一摇
 *
 *  @param times   时间
 *  @param delta   角度
 *  @param handler 回调
 */
- (void)shake:(int)times withDelta:(CGFloat)delta completion:(void((^)(void)))handler;
/**
 *  摇一摇
 *
 *  @param times    时间
 *  @param delta    角度
 *  @param interval 速度
 */
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval;

/**
 *  摇一摇
 *
 *  @param times    时间
 *  @param delta    角度
 *  @param interval 速度
 *  @param handler  回调
 */
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void((^)(void)))handler;
/**
 *  摇一摇
 *
 *  @param times          时间
 *  @param delta          角度
 *  @param interval       速度
 *  @param shakeDirection 方向
 */
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection;

/**
 *  摇一摇
 *
 *  @param times          时间
 *  @param delta          角度
 *  @param interval       速度
 *  @param shakeDirection 方向
 *  @param completion     回调
 */
- (void)shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completion:(void(^)(void))completion;

@end
