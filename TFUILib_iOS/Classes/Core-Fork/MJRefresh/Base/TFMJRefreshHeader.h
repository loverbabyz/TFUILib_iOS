//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  TFMJRefreshHeader.h
//  TFMJRefresh
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  下拉刷新控件:负责监控用户下拉的状态

#if __has_include("TFMJRefreshComponent.h")
#import "TFMJRefreshComponent.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TFMJRefreshHeader : TFMJRefreshComponent
/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(TFMJRefreshComponentAction)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 这个key用来存储上一次下拉刷新成功的时间 */
@property (copy, nonatomic) NSString *lastUpdatedTimeKey;
/** 上一次下拉刷新成功的时间 */
@property (strong, nonatomic, readonly, nullable) NSDate *lastUpdatedTime;

/** 忽略多少scrollView的contentInset的top */
@property (assign, nonatomic) CGFloat ignoredScrollViewContentInsetTop;

/** 默认是关闭状态, 如果遇到 CollectionView 的动画异常问题可以尝试打开 */
@property (nonatomic) BOOL isCollectionViewAnimationBug;
@end

NS_ASSUME_NONNULL_END
