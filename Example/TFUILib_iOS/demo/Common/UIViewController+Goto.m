//
//  UIViewController+Goto.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import "UIViewController+goto.h"
#import "DDNavigationController.h"
#import "AppDelegate.h"
#import "DDHomeViewController.h"
#import "DDLoginViewController.h"
#import "DDDetailViewController.h"
#import "DDLoginInfoViewController.h"

NSString * const DDLoginInfoSelectedNotification = @"DDLoginInfoSelectedNotification";

@implementation UIViewController (Goto)

+ (void)gotoRootViewController {
    [TF_APP_DELEGATE.window setRootViewController:[[DDNavigationController alloc] initWithRootViewController:[DDHomeViewController new]]];
    [TF_APP_DELEGATE.window makeKeyAndVisible];
}

+ (void)gotoLoginViewController {
    [TF_APP_DELEGATE.window setRootViewController:[[DDNavigationController alloc] initWithRootViewController:[DDLoginViewController new]]];
    [TF_APP_DELEGATE.window makeKeyAndVisible];
}

+ (void)gotoLoginInfoViewController {
    DDLoginInfoViewController *viewController = [DDLoginInfoViewController new];
    [tf_getRootViewController() presentViewController:viewController animated:YES completion:^{

    }];
}

+ (void)gotoAddViewController:(AddType)type {
    DDDetailViewController *viewController = [DDDetailViewController new];
    viewController.type = type;
    [tf_getRootViewController() presentViewController:viewController animated:YES completion:^{

    }];
}

+ (void)gotoXXViewController {
//    [tf_getRootViewController() pushViewController:[DDLoginViewController new]];
}

@end
