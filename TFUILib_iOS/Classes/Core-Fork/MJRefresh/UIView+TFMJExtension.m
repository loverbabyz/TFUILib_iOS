//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIView+TFExtension.m
//  TFMJRefresh
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIView+TFMJExtension.h"

@implementation UIView (TFMJExtension)
- (void)setTf_mj_x:(CGFloat)mj_x
{
    CGRect frame = self.frame;
    frame.origin.x = mj_x;
    self.frame = frame;
}

- (CGFloat)tf_mj_x
{
    return self.frame.origin.x;
}

- (void)setTf_mj_y:(CGFloat)mj_y
{
    CGRect frame = self.frame;
    frame.origin.y = mj_y;
    self.frame = frame;
}

- (CGFloat)tf_mj_y
{
    return self.frame.origin.y;
}

- (void)setTf_mj_w:(CGFloat)mj_w
{
    CGRect frame = self.frame;
    frame.size.width = mj_w;
    self.frame = frame;
}

- (CGFloat)tf_mj_w
{
    return self.frame.size.width;
}

- (void)setTf_mj_h:(CGFloat)mj_h
{
    CGRect frame = self.frame;
    frame.size.height = mj_h;
    self.frame = frame;
}

- (CGFloat)tf_mj_h
{
    return self.frame.size.height;
}

- (void)setTf_mj_size:(CGSize)mj_size
{
    CGRect frame = self.frame;
    frame.size = mj_size;
    self.frame = frame;
}

- (CGSize)tf_mj_size
{
    return self.frame.size;
}

- (void)setTf_mj_origin:(CGPoint)mj_origin
{
    CGRect frame = self.frame;
    frame.origin = mj_origin;
    self.frame = frame;
}

- (CGPoint)tf_mj_origin
{
    return self.frame.origin;
}
@end
