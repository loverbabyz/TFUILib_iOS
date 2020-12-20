//
//  TFTabBarController.h
//  Treasure
//
//  Created by xiayiyong on 15/7/2.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFViewController.h"
#import "TFCustomTabBarItem.h"
#import "TFCustomTabBar.h"

/**
 *  TFTabBarController
 */
@interface TFTabBarController : TFViewController <TFCustomTabBarSelectDelegate>

/**
 *  TbaBarController 的子控制器
 */
@property (nullable, nonatomic, strong) NSArray *viewControllers;

/**
 *  TabBar标题数组
 */
@property (nullable, nonatomic, strong) NSArray *tabBarTitles;

/**
 *  TabBar选择状态图片数组
 */
@property (nullable, nonatomic, strong) NSArray *tabBarSelectedImages;

/**
 *  TabBar正常状态图片数组
 */
@property (nullable, nonatomic, strong) NSArray *tabBarNormalImages;

/**
 *  TabBar正常状态标题颜色(统一设置，如需分别设置，请使用VC.tabBarItem.titleNormalColor)
 */
@property (nullable, nonatomic, strong) UIColor *tabBarTitleColor;

/**
 *  TabBar选择状态标题颜色(统一设置，如需分别设置，请使用VC.tabBarItem.titleSelectColor)
 */
@property (nullable, nonatomic, strong) UIColor *selectedTabBarTitleColor;

/**
 *  TabBarItem正常状态背景色(统一设置，如需分别设置，请使用VC.tabBarItem.backgroundColor)
 */
@property (nullable, nonatomic, strong) UIColor *tabBarItemBGColor;

/**
 *  TabBarItem选择状态背景色(统一设置，如需分别设置，请使用VC.tabBarItem.selectBackgroundColor)
 */
@property (nullable, nonatomic, strong) UIColor *selectedTabBarItemBGColor;

/**
 *  Badge背景色(统一设置，如需分别设置，请使用VC.tabBarItem.badgeBackgroundColor)
 */
@property (nullable, nonatomic, strong) UIColor *badgeBackgroundColor;

/**
 *  Badge字体色(统一设置，如需分别设置，请使用VC.tabBarItem.badgeStringColor)
 */
@property (nullable, nonatomic, strong) UIColor *badgeStringColor;

/**
 *  选中的VC
 */
@property (nullable, nonatomic, readonly,strong) TFViewController *selectedViewController;

/**
 *  选中的Index
 */
@property (nonatomic, assign) NSUInteger selectedIndex;

/**
 *  视图是否到TabBard顶部结束（若视图在TabBar顶部结束，则TabBar背景色为白色，否则TabBar半透明）
 */
@property (nonatomic, assign) BOOL tabBarTranslucent;

/**
 *  tabBar背景图片(设置image为空时，恢复默认半透明效果；image不为空时，没有半透明效果)
 */
@property (nullable, nonatomic, strong) UIImage * tabBarBackgroundImage;

/**
 *  移除子控制器
 *
 *  @param index 子控制器Index
 */
- (void)removeViewControllerAtIndex:(NSUInteger)index;

/**
 *  插入子控制器
 *
 *  @param vc 子控制器
 *  @param title 标题
 *  @param normalImage 正常状态图片
 *  @param selectedImage 选中状态图片
 *  @param index 插入Index
 */
- (void)insertViewController:(UIViewController * _Nullable)vc
                       title:(NSString * _Nullable)title
                 normalImage:(UIImage * _Nullable)normalImage
               selectedImage:(UIImage * _Nullable)selectedImage
                     atIndex:(NSUInteger)index;

/**
 *  设置badge值
 *
 *  @param badge badge值
 *  @param index Index
 */
- (void)setBadge:(NSString * _Nullable)badge atIndex:(NSUInteger)index;

/**
 *  设置TabBar隐藏/显示
 *
 *  @param hidden   是否隐藏
 *  @param animated 是否有动画
 */
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end

/**
 *  TFViewController的TFTabBarControllerItem分类
 */
@interface UIViewController (TFTabBarControllerItem)

/**
 *  tabBarItem
 */
@property (null_resettable, nonatomic, strong) TFCustomTabBarItem *tfTabBarItem;

/**
 *  tabBarController
 */
@property (nullable, nonatomic, readonly, strong) TFTabBarController *tfTabBarController;

@end
