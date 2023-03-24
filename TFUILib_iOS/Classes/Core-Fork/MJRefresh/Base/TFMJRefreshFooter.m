//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  TFMJRefreshFooter.m
//  TFMJRefresh
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "TFMJRefreshFooter.h"
#import "UIScrollView+TFMJRefresh.h"
#import "UIView+TFMJExtension.h"

@interface TFMJRefreshFooter()

@end

@implementation TFMJRefreshFooter
#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:(TFMJRefreshComponentAction)refreshingBlock
{
    TFMJRefreshFooter *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    TFMJRefreshFooter *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置自己的高度
    self.tf_mj_h = TFMJRefreshFooterHeight;
    
    // 默认不会自动隐藏
//    self.automaticallyHidden = NO;
}

#pragma mark . 链式语法部分 .

- (instancetype)linkTo:(UIScrollView *)scrollView {
    scrollView.tf_mj_footer = self;
    return self;
}

#pragma mark - 公共方法
- (void)endRefreshingWithNoMoreData
{
    TFMJRefreshDispatchAsyncOnMainQueue(self.state = TFMJRefreshStateNoMoreData;)
}

- (void)noticeNoMoreData
{
    [self endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData
{
    TFMJRefreshDispatchAsyncOnMainQueue(self.state = TFMJRefreshStateIdle;)
}

- (void)setAutomaticallyHidden:(BOOL)automaticallyHidden
{
    _automaticallyHidden = automaticallyHidden;
}
@end
