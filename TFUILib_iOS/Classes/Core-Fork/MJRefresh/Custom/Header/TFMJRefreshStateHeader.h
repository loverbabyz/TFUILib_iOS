//
//  TFMJRefreshStateHeader.h
//  TFMJRefresh
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#if __has_include("TFMJRefreshHeader.h")
#import "TFMJRefreshHeader.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TFMJRefreshStateHeader : TFMJRefreshHeader
#pragma mark - 刷新时间相关
/** 利用这个block来决定显示的更新时间文字 */
@property (copy, nonatomic, nullable) NSString *(^lastUpdatedTimeText)(NSDate * _Nullable lastUpdatedTime);
/** 显示上一次刷新时间的label */
@property (weak, nonatomic, readonly) UILabel *lastUpdatedTimeLabel;

#pragma mark - 状态相关
/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (instancetype)setTitle:(NSString *)title forState:(TFMJRefreshState)state;
@end

@interface TFMJRefreshStateHeader (ChainingGrammar)

- (instancetype)modifyLastUpdatedTimeText:(NSString * (^)(NSDate * _Nullable lastUpdatedTime))handler;

@end

NS_ASSUME_NONNULL_END
