//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  UIScrollView+TFMJRefresh.m
//  MJRefresh
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIScrollView+TFMJRefresh.h"
#import "TFMJRefreshHeader.h"
#import "TFMJRefreshFooter.h"
#import "TFMJRefreshTrailer.h"
#import <objc/runtime.h>

@implementation UIScrollView (TFMJRefresh)

#pragma mark - header
static const char TFMJRefreshHeaderKey = '\0';
- (void)setTf_mj_header:(TFMJRefreshHeader *)mj_header
{
    if (mj_header != self.tf_mj_header) {
        // 删除旧的，添加新的
        [self.tf_mj_header removeFromSuperview];
        
        if (mj_header) {
            [self insertSubview:mj_header atIndex:0];
        }
        // 存储新的
        objc_setAssociatedObject(self, &TFMJRefreshHeaderKey,
                                 mj_header, OBJC_ASSOCIATION_RETAIN);
    }
}

- (TFMJRefreshHeader *)tf_mj_header
{
    return objc_getAssociatedObject(self, &TFMJRefreshHeaderKey);
}

#pragma mark - footer
static const char MJRefreshFooterKey = '\0';
- (void)setTf_mj_footer:(TFMJRefreshFooter *)mj_footer
{
    if (mj_footer != self.tf_mj_footer) {
        // 删除旧的，添加新的
        [self.tf_mj_footer removeFromSuperview];
        if (mj_footer) {
            [self insertSubview:mj_footer atIndex:0];
        }
        // 存储新的
        objc_setAssociatedObject(self, &MJRefreshFooterKey,
                                 mj_footer, OBJC_ASSOCIATION_RETAIN);
    }
}

- (TFMJRefreshFooter *)tf_mj_footer
{
    return objc_getAssociatedObject(self, &MJRefreshFooterKey);
}

#pragma mark - footer
static const char MJRefreshTrailerKey = '\0';
- (void)setTf_mj_trailer:(TFMJRefreshTrailer *)mj_trailer {
    if (mj_trailer != self.tf_mj_trailer) {
        // 删除旧的，添加新的
        [self.tf_mj_trailer removeFromSuperview];
        if (mj_trailer) {
            [self insertSubview:mj_trailer atIndex:0];
        }
        // 存储新的
        objc_setAssociatedObject(self, &MJRefreshTrailerKey,
                                 mj_trailer, OBJC_ASSOCIATION_RETAIN);
    }
}

- (TFMJRefreshTrailer *)tf_mj_trailer {
    return objc_getAssociatedObject(self, &MJRefreshTrailerKey);
}

#pragma mark - 过期
- (void)setTf_footer:(TFMJRefreshFooter *)footer
{
    self.tf_mj_footer = footer;
}

- (TFMJRefreshFooter *)tf_footer
{
    return self.tf_mj_footer;
}

- (void)setTf_header:(TFMJRefreshHeader *)header
{
    self.tf_mj_header = header;
}

- (TFMJRefreshHeader *)tf_header
{
    return self.tf_mj_header;
}

#pragma mark - other
- (NSInteger)mj_totalDataCount
{
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;

        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    } else if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;

        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

@end
