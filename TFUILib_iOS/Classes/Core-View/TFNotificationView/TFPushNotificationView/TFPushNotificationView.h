//
//  TFPushNotificationView.h
//  TFNotifier
//
//  Created by xiayiyong on 15/5/21.
//  Copyright (c) 2015年 xiayiyong. All rights reserved.
//  from https://github.com/shaojiankui/JKNotifier
//

#import <UIKit/UIKit.h>
@class TFPushNotificationView;

typedef void(^TFPushNotificationViewTouchBlock)(NSString *name,NSString *detail,TFPushNotificationView *notifier);

@interface TFPushNotificationView : UIWindow

/**
 *  显示消息
 *
 *  @param message 消息内容
 *  @param block   回调
 */
+(TFPushNotificationView*)showWithMessage:(NSString*)message block:(TFPushNotificationViewTouchBlock)block;

/**
 *  显示消息
 *
 *  @param message        消息内容
 *  @param delay   消失时间
 *  @param block          回调
 */
+(TFPushNotificationView*)showWithMessage:(NSString*)message
                         dismissAfter:(NSTimeInterval)delay
                                block:(TFPushNotificationViewTouchBlock)block;

/**
 *  显示消息
 *
 *  @param message        消息内容
 *  @param appName        app名称
 *  @param appIcon        appIcon
 *  @param delay   消失时间
 *  @param block          回调
 */
+(TFPushNotificationView*)showWithMessage:(NSString*)message
                             appName:(NSString*)appName
                             appIcon:(UIImage*)appIcon
                     dismissAfter:(NSTimeInterval)delay
                            block:(TFPushNotificationViewTouchBlock)block;

/**
 *  关闭
 */
+ (void)dismiss;

/**
 *  关闭
 *
 *  @param delay 延迟关闭时间
 */
+ (void)dismissAfter:(NSTimeInterval)delay;

/**
 *  关闭
 */
- (void)dismiss;

@end
