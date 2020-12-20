//
//  MasonyUtil.h
//  Treasure
//
//  Created by xiayiyong on 15/8/5.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 push pop present到rootViewController;
 */
#pragma mark - push
/**
 *  页面跳转
 */
void tf_pushViewController(UIViewController *vc, BOOL animated);

#pragma mark - pop
/**
 *  页面返回
 */
void tf_popToViewController(UIViewController *vc);
void tf_popToViewControllerWithClassName(NSString *className);
void tf_popViewController(void);
void tf_popToRootViewController(void);

#pragma mark - present dismiss

/**
 *  页面presente
 */
void tf_presentViewController(UIViewController *vc, BOOL animated, void (^ completion)(void));

/**
 页面关闭
 */
void tf_dismissViewController(void);

#pragma mark - RootViewController

/**
 *  获取根视图
 */
UIViewController *tf_getRootViewController(void);
UIView *tf_getRootView(void);

#pragma mark - toast

void tf_showToast(NSString *text);
void tf_showToastWithText(NSString *text);

@interface TFUIUtil : NSObject

@end
