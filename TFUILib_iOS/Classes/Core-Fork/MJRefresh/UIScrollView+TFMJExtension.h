//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+TFExtension.h
//  MJRefresh
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (TFMJExtension)
@property (readonly, nonatomic) UIEdgeInsets tf_mj_inset;

@property (assign, nonatomic) CGFloat tf_mj_insetT;
@property (assign, nonatomic) CGFloat tf_mj_insetB;
@property (assign, nonatomic) CGFloat tf_mj_insetL;
@property (assign, nonatomic) CGFloat tf_mj_insetR;

@property (assign, nonatomic) CGFloat tf_mj_offsetX;
@property (assign, nonatomic) CGFloat tf_mj_offsetY;

@property (assign, nonatomic) CGFloat tf_mj_contentW;
@property (assign, nonatomic) CGFloat tf_mj_contentH;
@end

NS_ASSUME_NONNULL_END
