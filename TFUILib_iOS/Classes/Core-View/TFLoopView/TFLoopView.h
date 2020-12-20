//
//  TFLoopView.h
//  图片轮播控件
//
//  Created by Daniel on 2020/7/8.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//  https://github.com/gsdios/SDCycleScrollView
//

#import <UIKit/UIKit.h>
#import "TFView.h"

/**
 *  PageContol位置
 */
typedef NS_ENUM(NSUInteger, TFLoopViewPageContolAliment)
{
    /**
     *  右边位置
     */
    TFLoopViewPageContolAlimentRight,
    /**
     *  中间位置
     */
    TFLoopViewPageContolAlimentCenter
};

/**
 *  PageContol样式
 */
typedef NS_ENUM(NSUInteger, TFLoopViewPageContolStyle)
{
    /**
     *  系统自带经典样式
     */
    TFLoopViewPageContolStyleClassic,
    /**
     *  动画效果
     */
    TFLoopViewPageContolStyleAnimated,
    /**
     *  不显示pagecontrol
     */
    TFLoopViewPageContolStyleNone
};

@class TFLoopView;

@protocol TFLoopViewDelegate <NSObject>

@optional

/**
 *  点击图片回调
 *
 *  @param loopView TFLoopView
 *  @param index           图片Index
 */
- (void)loopView:(TFLoopView *)loopView didSelectItemAtIndex:(NSInteger)index;

/**
 *  图片滚动回调
 *
 *  @param loopView TFLoopView
 *  @param index           图片Index
 */
- (void)loopView:(TFLoopView *)loopView didScrollToIndex:(NSInteger)index;

@end

@interface TFLoopView : TFView<UICollectionViewDataSource>

/**
 *  每个view对应要显示的view数组
 */
@property (nonatomic, strong) NSArray *viewGroup;

/**
 *  每张图片对应要显示的文字数组
 */
@property (nonatomic, strong) NSArray *titlesGroup;

/**
 *  自动滚动间隔时间,默认2s
 */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/**
 *  是否无限循环,默认Yes
 */
@property(nonatomic,assign) BOOL infiniteLoop;

/**
 *  是否自动滚动,默认Yes
 */
@property(nonatomic,assign) BOOL autoScroll;

/**
 *  是否需要手势滑动
 */
@property(nonatomic,assign) BOOL isNeedScroll;

/**
 *  delegate
 */
@property (nonatomic, weak) id<TFLoopViewDelegate> delegate;

/**
 *  block监听点击方式
 */
@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);

/**
 *  轮播图片的ContentMode，默认为 UIViewContentModeScaleToFill
 */
@property (nonatomic, assign) UIViewContentMode bannerViewContentMode;

/**
 *  占位图，用于网络未加载到图片时
 */
@property (nonatomic, strong) UIImage *placeholderImage;

/**
 *  是否显示分页控件
 */
@property (nonatomic, assign) BOOL showPageControl;

/**
 *  是否在只有一张图时隐藏pagecontrol，默认为YES
 */
@property(nonatomic) BOOL hidesForSinglePage;

/**
 *  pagecontrol 样式，默认为动画样式
 */
@property (nonatomic, assign) TFLoopViewPageContolStyle pageControlStyle;

/**
 *  分页控件位置
 */
@property (nonatomic, assign) TFLoopViewPageContolAliment pageControlAliment;

/**
 *  分页控件小圆标大小
 */
@property (nonatomic, assign) CGSize pageControlDotSize;

/**
 *  当前分页控件小圆标颜色
 */
@property (nonatomic, strong) UIColor *currentPageDotColor;

/**
 *  其他分页控件小圆标颜色
 */
@property (nonatomic, strong) UIColor *pageDotColor;

/**
 *  当前分页控件小圆标图片
 */
@property (nonatomic, strong) UIImage *currentPageDotImage;

/**
 *  其他分页控件小圆标图片
 */
@property (nonatomic, strong) UIImage *pageDotImage;

/**
 *  分页控件位置
 */
@property (nonatomic, assign) float pageControlDistanceFormBottom;

/**
 *  轮播文字label字体颜色
 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;

/**
 *  轮播文字label字体大小
 */
@property (nonatomic, strong) UIFont  *titleLabelTextFont;

/**
 *  轮播文字label背景颜色
 */
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;

/**
 *  轮播文字label高度
 */
@property (nonatomic, assign) CGFloat titleLabelHeight;

/**
 *  初始轮播图
 *
 *  @param frame 轮播视图大小
 *  @param viewGroup 视图数组
 *  @param placeholderImage 占位图片
 *  @param delegate 代理
 *
 *  @return 轮播视图
 */
+ (instancetype)loopViewWithFrame:(CGRect)frame viewGroup:(NSArray *)viewGroup placeholderImage:(UIImage *)placeholderImage delegate:(id<TFLoopViewDelegate>)delegate;

/**
 *  初始轮播图（推荐使用）
 *
 *  @param frame 轮播视图大小
 *  @param viewGroup 视图数组
 *  @param placeholderImage 占位图片
 *  @param block 回调
 *
 *  @return 轮播视图
 */
+ (instancetype)loopViewWithFrame:(CGRect)frame viewGroup:(NSArray *)viewGroup placeholderImage:(UIImage *)placeholderImage block:(void(^)(NSInteger currentIndex))block;

/**
 *  注册cell的class文件，默认ReuseIdentifier为指定class的名称
 *
 *  @param className 类名称
 */
- (void)registerClass:(Class)className;

/**
 *  注册cell Nib文件，默认ReuseIdentifier为指定class的名称
 *
 *  @param className Nib文件类名称
 */
- (void)registerNib:(Class)className;

/**
 *  清除图片缓存（此次升级后统一使用SDWebImage管理图片加载和缓存）
 */
+ (void)clearImagesCache;

/**
 *  清除图片缓存（兼容旧版本方法）
 */
- (void)clearCache;

@end
