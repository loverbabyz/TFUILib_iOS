//
//  UIView+Loading.h
//  loading
//
//  Created by Daniel on 15/9/9.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFLoadingView.h"

@interface UIView (TFLoading)

/**
 *  显示Loading视图
 */
-(void)showLoading;

/**
 *  显示Loading视图
 *
 *  @param text 提示信息
 */
-(void)showLoadingWithText:(NSString *)text;

/**
 *  隐藏Loading视图
 */
-(void)hideLoading;

@end
