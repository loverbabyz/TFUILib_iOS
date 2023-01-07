//
//  UIViewController+TFLoading.h
//  TFUILib
//
//  Created by Daniel on 16/3/21.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TFLoading)

#pragma mark-  loadinfgview

/**
 *  显示Loading
 */
- (void)showLoading;

/**
 *  显示Loading
 *
 *  @param text 提示信息
 */
- (void)showLoadingWithText:(NSString*)text;

/**
 *  隐藏Loading
 */
- (void)hideLoading;

@end
