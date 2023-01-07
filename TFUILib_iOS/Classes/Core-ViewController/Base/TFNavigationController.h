//
//  TFNavigationController.h
//  Treasure
//
//  Created by Daniel on 15/7/2.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFViewController.h"

@interface TFNavigationController : UINavigationController

/**
 *  根视图
 */
@property (nonatomic, strong) UIViewController *rootViewController;

/**
 *  返回前一个viewController
 *
 */
@property (nonatomic, strong, readonly) UIViewController *previousViewController;

/**
 *  设置背景颜色和透明度
 *
 *  @param color 背景颜色
 *  @param alpha  透明度
 */
- (void)setNavigationBarBackgroundColor:(UIColor *)color alpha:(NSInteger)alpha;

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
