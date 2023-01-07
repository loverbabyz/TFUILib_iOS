//
//  UIAlertController+Block.m
//  TFUILib
//
//  Created by Daniel on 16/1/28.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIAlertController+Block.h"
#import <objc/runtime.h>

@implementation UIAlertController (Block)

#pragma mark - alertview

+ (void)showAlertViewWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                block:(void (^)(NSInteger buttonIndex))block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelButtonTitle != nil && cancelButtonTitle.length > 0)
    {
        int start=0;
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                                if (block!=nil)
                                                                {
                                                                    block(start);
                                                                }
                                                            }];
        
        [alert addAction:alertAction];
    }
    
    if (otherButtonTitles != nil)
    {
        int start=0;
        
        if (cancelButtonTitle != nil && cancelButtonTitle.length > 0)
        {
            start++;
        }
        
        for (int i=0; i<otherButtonTitles.count; i++)
        {
            NSString *item=otherButtonTitles[i];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:item
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
                                                                    if (block!=nil)
                                                                    {
                                                                        block(i+start);
                                                                    }
                                                                    
                                                                }];
            
            [alert addAction:alertAction];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        [alert show];
    });
}

+ (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
                  buttonTitles:(NSArray *)buttonTitles
                         block:(void (^)(NSInteger buttonIndex))block
{
    [UIAlertController showAlertViewWithTitle:title message:message cancelButtonTitle:nil otherButtonTitles:buttonTitles block:block];
}

#pragma mark - actionsheet

+ (void) showActionSheetWithTitle:(NSString *)title
     cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
     otherButtonTitles:(NSArray *)otherButtonTitles
                 block:(void (^)(NSInteger))block
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (cancelButtonTitle != nil && cancelButtonTitle.length > 0)
    {
        int start=0;
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                                if (block!=nil)
                                                                {
                                                                    block(start);
                                                                }
                                                            }];
        
        [alert addAction:alertAction];
    }
    
    if (destructiveButtonTitle != nil && destructiveButtonTitle.length > 0)
    {
        int start=0;
        
        if (cancelButtonTitle!=nil&&cancelButtonTitle.length>0)
        {
            start++;
        }
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:destructiveButtonTitle
                                                              style:UIAlertActionStyleDestructive
                                                            handler:^(UIAlertAction *action) {
                                                                if (block!=nil)
                                                                {
                                                                    block(start);
                                                                }
                                                            }];
        
        [alert addAction:alertAction];
    }
    
    if (otherButtonTitles != nil)
    {
        int start=0;
        
        if (cancelButtonTitle!=nil&&cancelButtonTitle.length>0)
        {
            start++;
        }
        if (destructiveButtonTitle!=nil&&destructiveButtonTitle.length>0)
        {
            start++;
        }
        
        for (int i = 0; i < otherButtonTitles.count; i++)
        {
            NSString *item = otherButtonTitles[i];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:item
                                                                  style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction *action) {
                                                                    if (block!=nil)
                                                                    {
                                                                        block(i+start);
                                                                    }
                                                                    
                                                                }];
            
            [alert addAction:alertAction];
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(void){
        
        [alert show];
    });
}

+ (void) showActionSheetWithTitle:(NSString *)title
                cancelButtonTitle:(NSString *)cancelButtonTitle
           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                            block:(void (^)(NSInteger))block
{
    [UIAlertController showActionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil block:block];
}

+ (void) showActionSheetWithTitle:(NSString *)title
                cancelButtonTitle:(NSString *)cancelButtonTitle
                otherButtonTitles:(NSArray *)otherButtonTitles
                            block:(void (^)(NSInteger))block
{
    [UIAlertController showActionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:otherButtonTitles block:block];
}

- (void)show
{
    [[self topShowViewController] presentViewController:self
                                               animated:YES
                                             completion:nil];
}

#pragma --mark t

- (UIViewController*)topShowViewController
{
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        
        return [self topViewControllerWithRootViewController:presentedViewController];
    }
    else
    {
        return rootViewController;
    }
}

+ (BOOL)isIosVersion8AndAfter
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ;
}

@end
