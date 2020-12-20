//
//  TFMacro+View.h
//  Treasure
//
//  Created by xiayiyong on 15/9/14.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#define FRAME(x,y,width,height)  CGRectMake(x, y, width, height)

// 屏幕宽
#define SCREEN_WIDTH             ([UIScreen mainScreen].bounds.size.width)

// 屏幕高度
#define SCREEN_HEIGHT            ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 导航栏高度
#define NAV_BAR_HEIGHT           44.0

// 工具栏高度
#define TAB_BAR_HEIGHT           49.0

// 状态栏高度
#define STATUS_BAR_HEIGHT        ([[UIApplication sharedApplication] statusBarFrame].size.height)

// 导航栏高度
#define NAV_BAR_HEIGHT2          (self.navigationController.navigationBar.bounds.size.height)

// 状态栏高度
#define TAB_BAR_HEIGHT2          (self.tabBarController.tabBar.bounds.size.height)

#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define kTopMargin                  (IPHONE_X ? 24.0 : 0.0)
#define kBottomMargin               (IPHONE_X ? 34.0 : 0)

#define kTabBarHeight               (49.0 + kBottomMargin)
#define kNavigationBarHeight        (64 + kTopMargin)

