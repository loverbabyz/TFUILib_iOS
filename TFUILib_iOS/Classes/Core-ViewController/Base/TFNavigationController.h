//
//  TFNavigationController.h
//  Treasure
//
//  Created by Daniel on 15/7/2.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//  Usage: https://github.com/listenzz/TFHBDNavigationBar
//

#import <UIKit/UIKit.h>
#import "TFHBDNavigationController.h"

@interface TFNavigationController : TFHBDNavigationController

/**
 *  根视图
 */
@property (nonatomic, strong, readonly) UIViewController *rootViewController;

/**
 *  返回前一个viewController
 *
 */
@property (nonatomic, strong, readonly) UIViewController *previousViewController;

/**
 *  初始化视图
 */
- (void)initViews;

/**
 *  自动布局视图
 */
- (void)autolayoutViews;

/**
 *  绑定数据
 */
- (void)bindData;

@end
