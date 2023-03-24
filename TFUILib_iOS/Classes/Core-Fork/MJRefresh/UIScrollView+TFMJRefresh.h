//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+TFMJRefresh.h
//  TFMJRefresh
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  给ScrollView增加下拉刷新、上拉刷新、 左滑刷新的功能

#import <UIKit/UIKit.h>
#if __has_include("TFMJRefreshConst.h")
#import "TFMJRefreshConst.h"
#endif

@class TFMJRefreshHeader, TFMJRefreshFooter, TFMJRefreshTrailer;

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (TFMJRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic, nullable) TFMJRefreshHeader *tf_mj_header;
@property (strong, nonatomic, nullable) TFMJRefreshHeader *tf_header TFMJRefreshDeprecated("使用tf_mj_header");
/** 上拉刷新控件 */
@property (strong, nonatomic, nullable) TFMJRefreshFooter *tf_mj_footer;
@property (strong, nonatomic, nullable) TFMJRefreshFooter *tf_footer TFMJRefreshDeprecated("使用tf_mj_footer");

/** 左滑刷新控件 */
@property (strong, nonatomic, nullable) TFMJRefreshTrailer *tf_mj_trailer;

#pragma mark - other
- (NSInteger)mj_totalDataCount;

@end

NS_ASSUME_NONNULL_END
