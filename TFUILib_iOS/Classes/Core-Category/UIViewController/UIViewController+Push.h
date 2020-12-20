//
//  UIViewController+Push.h
//  TFUILib
//
//  Created by xiayiyong on 16/3/21.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Push)

/**
 *  获取APP根ViewController
 */
- (UIViewController *)getRootViewController;

/**
 *  返回方法
 */
- (void)back;

/**
 *  是否模块化的VC
 *
 *  @param vc
 *
 *  @return
 */

#pragma mark - push pop

/**
 *  push方法
 *
 *  @param vc 控制器
 */
- (void)pushViewController:(UIViewController *)vc;

/**
 push方法

 @param vc 控制器
 @param animated 是否带动画
 */
- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated;

/**
 *  pop方法
 */
- (void)popViewController;

/**
 *  pop方法
 *
 *  @param vc 控制器
 */
-(void) popToViewController:(UIViewController *)vc;

/**
 *  pop方法
 *
 *  @param className to控制器
 */
-(void) popToViewControllerWithClassName:(NSString *)className;

/**
 *  pop到root
 */
-(void) popToRootViewController;

/**
 *  pop到root
 */
-(void) popToRootViewControllerAnimated:(BOOL)animated;

#pragma mark- present dismissView

/**
 *  弹出模态视图
 */
- (void)presentViewController:(UIViewController *)vc;

/**
 *  隐藏模态视图
 */
- (void)dismissViewController;

#pragma mark- module
/**
 *  模块化pop视图
 */
- (void)popModuleViewController;

/**
 *  模块化pop视图
 */
- (void)popModuleViewController:(UIViewController *)vc;

/**
 *  是否是模块vc
 *
 *  @param vc UIViewController
 */
-(BOOL) isModuleViewController:(UIViewController *)vc;

@end
