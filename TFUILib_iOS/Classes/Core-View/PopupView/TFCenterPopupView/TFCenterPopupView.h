//
//  Created by Daniel on 16/3/30.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFView.h"

typedef enum : NSUInteger
{
    /**
     *  无动画
     */
    kCenterPopupViewAnimateNone = 0,
    /**
     *  弹性动画
     */
    kCenterPopupViewAnimateSpring = 1,
    /**
     *  渐隐渐现动画
     */
    kCenterPopupViewAnimateFade = 2,
} TFCenterPopupViewAnimateType;

typedef void (^TFCenterPopupViewBlock)(void);

@interface TFCenterPopupView : TFView

/**
 *  初始化
 *
 *  @param popupView 要显示的视图
 */
- (instancetype)initWithPopupView:(UIView*)popupView;

/**
 *  显示视图
 *
 *  @param type 动画类型
 */
- (void)showWithAnimateType:(TFCenterPopupViewAnimateType)type;

/**
 *  显示视图
 */
- (void)show;

/**
 *  隐藏视图
 */
- (void)hide;

@end

