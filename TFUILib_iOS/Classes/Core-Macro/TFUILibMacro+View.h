//
//  TFUILibMacro+View.h
//  Treasure
//
//  Created by Daniel on 15/9/14.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#ifndef TF_FRAME
#define TF_FRAME(x,y,width,height) CGRectMake(x, y, width, height)
#endif
/**
 *  Main Screen
 */
#ifndef TF_MAIN_SCREEN
#define TF_MAIN_SCREEN [UIScreen mainScreen]
#endif

/**
 *  app的UIApplication
 */
#ifndef TF_APP_APPLICATION
#define TF_APP_APPLICATION [UIApplication sharedApplication]
#endif

/**
 *  屏幕宽
 */
#ifndef TF_SCREEN_WIDTH
#define TF_SCREEN_WIDTH (TF_MAIN_SCREEN.bounds.size.width)
#endif

/**
 *  屏幕高度
 */
#ifndef TF_SCREEN_HEIGHT
#define TF_SCREEN_HEIGHT (TF_MAIN_SCREEN.bounds.size.height)
#endif

#ifndef TF_IS_IPHONE
#define TF_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#endif

/**
 *  导航栏高度
 */
#ifndef TF_NAV_BAR_HEIGHT
#define TF_NAV_BAR_HEIGHT 44.0
#endif

/**
 *  工具栏高度
 */
#ifndef TF_TAB_BAR_HEIGHT
#define TF_TAB_BAR_HEIGHT 49.0
#endif

/**
 *  状态栏高度
 */
#ifndef TF_STATUS_BAR_HEIGHT
#define TF_STATUS_BAR_HEIGHT ([TF_APP_APPLICATION statusBarFrame].size.height)
#endif

/**
 *  导航栏高度
 */
#ifndef TF_NAV_BAR_HEIGHT2
#define TF_NAV_BAR_HEIGHT2 (self.navigationController.navigationBar.bounds.size.height)
#endif

/**
 *  状态栏高度
 */
#ifndef TF_TAB_BAR_HEIGHT2
#define TF_TAB_BAR_HEIGHT2 (self.tabBarController.tabBar.bounds.size.height)
#endif

/**
 *  设备是iPhone6
 */
#ifndef TF_TARGET_IPHONE_6
#define TF_TARGET_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334),[TF_MAIN_SCREEN currentMode].size) : NO)
#endif

/**
 *  设备是iPhone6P
 */
#ifndef TF_TARGET_IPHONE_6PLUS
#define TF_TARGET_IPHONE_6PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208),[TF_MAIN_SCREEN currentMode].size) : NO)
#endif


#ifndef TF_IS_IPHONE_X
#define TF_IS_IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [TF_APP_APPLICATION delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#endif

#ifndef TF_TopMargin
#define TF_TopMargin (TF_IS_IPHONE_X ? 24.0 : 0.0)
#endif

#ifndef TF_BottomMargin
#define TF_BottomMargin (TF_IS_IPHONE_X ? 34.0 : 0)
#endif

#ifndef TF_TabBarHeight
#define TF_TabBarHeight (49.0 + TF_BottomMargin)
#endif

#ifndef TF_NavigationBarHeight
#define TF_NavigationBarHeight (64 + TF_TopMargin)
#endif

