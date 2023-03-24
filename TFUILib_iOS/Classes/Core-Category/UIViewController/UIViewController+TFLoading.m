//
//  UIViewController+TFLoading.m
//  TFUILib
//
//  Created by Daniel on 16/3/21.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIViewController+TFLoading.h"
#import "TFLoadingView.h"

@implementation UIViewController (TFLoading)

#pragma mark loading

- (void)showLoading
{
    TF_MAIN_THREAD(^(){
        [TFLoadingView showWithText:@"" activityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite atView:self.view offsetY:0];
    });
}

- (void)showLoadingWithText:(NSString*)text
{
    TF_MAIN_THREAD(^(){
        [TFLoadingView showWithText:text activityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite atView:self.view offsetY:0];
    });
}

- (void)hideLoading
{
    TF_MAIN_THREAD(^(){
        [TFLoadingView hideAtView:self.view];
    });
}

@end
