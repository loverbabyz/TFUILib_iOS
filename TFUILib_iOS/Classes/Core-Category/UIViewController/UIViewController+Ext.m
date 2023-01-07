//
//  UIViewController+Ext.m
//  TFUILib
//
//  Created by Daniel on 16/4/8.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIViewController+Ext.h"
#import "TFTabBarController.h"

@implementation UIViewController (Ext)

- (UIViewController*)toppestViewController
{
    return [self toppestViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)rootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

- (UIViewController*)toppestViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[TFTabBarController class]])
    {
        TFTabBarController* tabBarController = (TFTabBarController*)rootViewController;
        return [self toppestViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self toppestViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self toppestViewControllerWithRootViewController:nav.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self toppestViewControllerWithRootViewController:presentedViewController];
    }
    else
    {
        return rootViewController;
    }
}

-(CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

-(CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

@end

