//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+TFExtension.m
//  MJRefresh
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 小码哥. All rights reserved.
//

#import "UIScrollView+TFMJExtension.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@implementation UIScrollView (TFMJExtension)

static BOOL respondsToAdjustedContentInset_;

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        respondsToAdjustedContentInset_ = [self instancesRespondToSelector:@selector(adjustedContentInset)];
    });
}

- (UIEdgeInsets)tf_mj_inset
{
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        return self.adjustedContentInset;
    }
#endif
    return self.contentInset;
}

- (void)setTf_mj_insetT:(CGFloat)mj_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = mj_insetT;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)tf_mj_insetT
{
    return self.tf_mj_inset.top;
}

- (void)setTf_mj_insetB:(CGFloat)mj_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = mj_insetB;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)tf_mj_insetB
{
    return self.tf_mj_inset.bottom;
}

- (void)setTf_mj_insetL:(CGFloat)mj_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = mj_insetL;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)tf_mj_insetL
{
    return self.tf_mj_inset.left;
}

- (void)setTf_mj_insetR:(CGFloat)mj_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = mj_insetR;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)tf_mj_insetR
{
    return self.tf_mj_inset.right;
}

- (void)setTf_mj_offsetX:(CGFloat)mj_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = mj_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)tf_mj_offsetX
{
    return self.contentOffset.x;
}

- (void)setTf_mj_offsetY:(CGFloat)mj_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = mj_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)tf_mj_offsetY
{
    return self.contentOffset.y;
}

- (void)setTf_mj_contentW:(CGFloat)mj_contentW
{
    CGSize size = self.contentSize;
    size.width = mj_contentW;
    self.contentSize = size;
}

- (CGFloat)tf_mj_contentW
{
    return self.contentSize.width;
}

- (void)setTf_mj_contentH:(CGFloat)mj_contentH
{
    CGSize size = self.contentSize;
    size.height = mj_contentH;
    self.contentSize = size;
}

- (CGFloat)tf_mj_contentH
{
    return self.contentSize.height;
}
@end
#pragma clang diagnostic pop
