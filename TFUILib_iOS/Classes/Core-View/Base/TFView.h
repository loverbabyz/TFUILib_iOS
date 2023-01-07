//
//  TFView.h
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFUILibCategory.h"
#import "TFUILibMacro.h"

@interface TFView : UIView

@property (nonatomic, strong) id data;

/**
 *  从XIB获取视图
 */
+ (id)loadViewFromXib;

/**
 *  初始化视图
 */
- (void)initViews;

/**
 *  自动布局视图
 */
- (void)autolayoutViews;

/**
 *  绑定数据
 */
- (void)bindData;

/**
 设置安全区
 */
- (void)setSafeAreaInset:(UIEdgeInsets)safeAreaInsets;

/// view高度
+ (CGFloat)viewHeight;

@end
