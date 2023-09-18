//
//  UIViewController+Goto.h
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import <UIKit/UIKit.h>
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
#import "define_enum.h"


FOUNDATION_EXPORT NSString * const DDLoginInfoSelectedNotification;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Goto)

/// 主页面
+ (void)gotoRootViewController;

/// 登录页面
+ (void)gotoLoginViewController;

/// 登录用户切换页面
+ (void)gotoLoginInfoViewController;

/// 新增数据
+ (void)gotoAddViewController:(AddType)type;

@end

NS_ASSUME_NONNULL_END
