//
//  TFMJRefreshAutoNormalFooter.m
//  MJRefresh
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "TFMJRefreshAutoNormalFooter.h"
#import "NSBundle+TFMJRefresh.h"
#import "UIView+TFMJExtension.h"
#import "UIScrollView+TFMJExtension.h"
#import "UIScrollView+TFMJRefresh.h"

@interface TFMJRefreshAutoNormalFooter()
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation TFMJRefreshAutoNormalFooter
#pragma mark - 懒加载子控件
- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:_activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
    [self setNeedsLayout];
}
#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 130000
    if (@available(iOS 13.0, *)) {
        _activityIndicatorViewStyle = UIActivityIndicatorViewStyleMedium;
        return;
    }
#endif
        
    _activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.loadingView.constraints.count) return;
    
    // 圈圈
    CGFloat loadingCenterX = self.tf_mj_w * 0.5;
    if (!self.isRefreshingTitleHidden) {
        loadingCenterX -= self.stateLabel.tf_mj_textWidth * 0.5 + self.labelLeftInset;
    }
    CGFloat loadingCenterY = self.tf_mj_h * 0.5;
    self.loadingView.center = CGPointMake(loadingCenterX, loadingCenterY);
}

- (void)setState:(TFMJRefreshState)state
{
    TFMJRefreshCheckState
    
    // 根据状态做事情
    if (state == TFMJRefreshStateNoMoreData || state == TFMJRefreshStateIdle) {
        [self.loadingView stopAnimating];
    } else if (state == TFMJRefreshStateRefreshing) {
        [self.loadingView startAnimating];
    }
}

@end
