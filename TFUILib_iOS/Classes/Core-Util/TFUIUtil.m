//
//  MasonyUtil.m
//  Treasure
//
//  Created by Daniel on 15/8/5.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//
//
#define MODLUE_VIEW_CONTROLLER_TAG  888

#import "TFUIUtil.h"
#import "TFViewController.h"

@interface TFUIUtil()

+ (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated;
+ (void)popToViewController:(UIViewController *)vc;
+ (void)popToViewControllerWithClassName:(NSString *)className;
+ (void)popViewController;
+ (void)popToRootViewController;

+ (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;
+ (void)dismissViewController;

+ (UIViewController *) getRootViewController;
+ (UIView *) getRootView;

/**
 *  在顶部显示一个Toast，持续2.5秒
 *
 *  @param text 要显示的文字
 */
+ (void)showToast:(NSString*)text;

/**
 *   在顶部显示一个Toast，持续2.5秒
 *
 *  @param text text
 */
+ (void)showToastWithText:(NSString*)text;

@end

@implementation TFUIUtil

/*
 push pop
 */
+ (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated
{
    UIViewController *rootVC = [TFUIUtil getRootViewController];
    [rootVC pushViewController:vc animated:animated];
}

+ (void)popToViewController:(UIViewController *)vc
{
    UIViewController *rootVC = [TFUIUtil getRootViewController];
    [rootVC popToViewController:vc];
}

+ (void)popToViewControllerWithClassName:(NSString *)className
{
    UIViewController *rootVC = [TFUIUtil getRootViewController];
    [rootVC popToViewControllerWithClassName:className];
}

+ (void)popViewController
{
    UIViewController *rootVC = [TFUIUtil getRootViewController];
    [rootVC popViewController];
}

+ (void)popToRootViewController
{
    MAIN_THREAD(^(){
        UIViewController *rootVC = [TFUIUtil getRootViewController];
        [rootVC popToRootViewController];
    });
}

/*
 present dismiss
 */
+ (void)presentViewController:(UIViewController *)vc animated:(BOOL)animated completion:(void (^ __nullable)(void))completion
{
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    
    UIViewController *rootVC = [TFUIUtil getRootViewController];
    [rootVC presentViewController:vc animated:animated completion:completion];
}

+ (void)dismissViewController
{
    UIViewController *rootVC = [TFUIUtil getRootViewController];
    [rootVC dismissViewController];
}

+ (UIViewController *)getRootViewController
{
    UIViewController *rootVC=[[UIApplication sharedApplication].delegate window].rootViewController;
    return rootVC;
}

+ (UIView *)getRootView
{
    UIView *rootVC=[[UIApplication sharedApplication].delegate window].rootViewController.view;
    return rootVC;
}

#pragma mark toast

+ (void)showToast:(NSString*)text
{
    UIViewController *rootVC = [TFUIUtil getRootViewController];
    [rootVC showToast:text];
}

+ (void)showToastWithText:(NSString*)text
{
    UIViewController *rootVC = [TFUIUtil getRootViewController];
    [rootVC showToastWithText:text];
}

@end

#pragma mark - push

void tf_pushViewController(UIViewController *vc, BOOL animated)
{
    [TFUIUtil pushViewController:vc animated:animated];
}

#pragma mark - pop
void tf_popToViewController(UIViewController *vc)
{
    [TFUIUtil popToViewController:vc];
}

void tf_popToViewControllerWithClassName(NSString *className)
{
    [TFUIUtil popToViewControllerWithClassName:className];
}

void tf_popViewController()
{
    [TFUIUtil popViewController];
}

void tf_popToRootViewController()
{
    [TFUIUtil popToRootViewController];
}

#pragma mark - present dismiss
void tf_presentViewController(UIViewController *vc, BOOL animated, void (^ completion)(void))
{
    [TFUIUtil presentViewController:vc animated:animated completion:completion];
}

void tf_dismissViewController()
{
    [TFUIUtil dismissViewController];
}

UIViewController *tf_getRootViewController()
{
    return [TFUIUtil getRootViewController];
}

UIView *tf_getRootView()
{
    return [TFUIUtil getRootView];
}

void tf_showToast(NSString *text)
{
    return [TFUIUtil showToast:text];
}

void tf_showToastWithText(NSString *text)
{
    return [TFUIUtil showToastWithText:text];
}
