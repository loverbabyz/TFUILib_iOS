//
//  TFNavigationMenu.h
//  TFNavigationMenu
//
//  Created by Daniel on 02/08/2015.
//  Copyright (c) 2015 xiayiyong. All rights reserved.
//  from https://github.com/PerfectFreeze/PFNavigationDropdownMenu
//

#import <UIKit/UIKit.h>
#import "TFView.h"

typedef void (^TFNavigationMenuBlock)(NSInteger index);

@interface TFNavigationMenu : TFView

/**
 *  字体颜色
 */
@property (nonatomic, strong) UIColor *textColor;
/**
 *  字体
 */
@property (nonatomic, strong) UIFont *textFont;
/**
 *  cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 *  cell背景颜色
 */
@property (nonatomic, strong) UIColor *cellBackgroundColor;
/**
 *  cell文字颜色
 */
@property (nonatomic, strong) UIColor *cellTextColor;
/**
 *  cell字体
 */
@property (nonatomic, strong) UIFont *cellTextFont;
/**
 *  cell选中颜色
 */
@property (nonatomic, strong) UIColor *cellSelectedColor;
/**
 *  勾选图片
 */
@property (nonatomic, strong) UIImage *checkImage;
/**
 *  箭头图片
 */
@property (nonatomic, strong) UIImage *arrowImage;
/**
 *
 */
@property (nonatomic, assign) CGFloat arrowPadding;
/**
 *  动画时间
 */
@property (nonatomic, assign) NSTimeInterval animationDuration;
/**
 *  浮层颜色
 */
@property (nonatomic, strong) UIColor *maskBackgroundColor;
/**
 *  浮层透明度
 */
@property (nonatomic, assign) CGFloat maskBackgroundOpacity;

/**
 *  点击回调
 */
@property (nonatomic, copy) TFNavigationMenuBlock didSelectItemAtIndexHandler;

/**
 *  初始化
 *
 *  @param items 字符串列表
 *  @param block block
 */
- (instancetype)initWithItems:(NSArray *)items block:(TFNavigationMenuBlock)block;

@end
