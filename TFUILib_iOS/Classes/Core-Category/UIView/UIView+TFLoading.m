//
//  UIView+TFLoading.m
//  loading
//
//  Created by xiayiyong on 15/9/9.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIView+TFLoading.h"

#define DISAPEAR_DURATION 0.f

@implementation UIView (TFLoading)

- (void)showLoading
{
    [TFLoadingView showWithText:@"" activityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite atView:self offsetY:0];
}

- (void)showLoadingWithText:(NSString*)text
{
    [TFLoadingView showWithText:text activityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite atView:self offsetY:0];
}

- (void)hideLoading
{
    [TFLoadingView hideAtView:self];
}

@end
