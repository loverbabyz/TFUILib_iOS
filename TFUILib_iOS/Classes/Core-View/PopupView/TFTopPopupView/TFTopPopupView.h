//
//  TFTopPopupView.h
//  AFPopup
//
//  Created by Alvaro Franco on 3/7/14.
//  Copyright (c) 2014 xiayiyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFView.h"


typedef enum : NSUInteger
{
    /**
     *  无动画
     */
    kTopPopupViewAnimateNone = 0,
    /**
     *  从上往下动画
     */
    kTopPopupViewAnimateClassic = 1,
} TFTopPopupViewAnimateType;

typedef void (^TFTopPopupViewBlock)(void);

@interface TFTopPopupView : TFView

/**
 *  初始化
 *
 *  @param popupView 要显示的视图
 */
- (instancetype)initWithPopupView:(UIView*)popupView andHeight:(CGFloat)height;

/**
 *  显示视图
 *
 *  @param type 动画类型
 */
- (void)showWithAnimateType:(TFTopPopupViewAnimateType)type;

/**
 *  显示视图
 */
- (void)show;

/**
 *  隐藏视图
 */
- (void)hide;

@end
