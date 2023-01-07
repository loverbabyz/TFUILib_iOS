//
//  UIViewController+TFHud.m
//  TFUILib
//
//  Created by Daniel on 16/3/21.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIViewController+TFHud.h"
#import "UIViewController+Ext.h"
#import "TFHud.h"

@implementation UIViewController (TFHud)

#pragma mark HUD

- (void)showHud
{
    MAIN_THREAD(^(){
        [TFHud showLoadingWithText:@"加载中..."
                      textPosition:kTextPositionTypeRight
                            atView:[[UIApplication sharedApplication] keyWindow]];
    });
}

- (void)showHudWithText:(NSString*)text
{
    MAIN_THREAD(^(){
        [TFHud showLoadingWithText:text
                         textPosition:kTextPositionTypeRight
                            atView:[[UIApplication sharedApplication] keyWindow]];
    });
}

- (void)showHudWithText:(NSString*)text dismissAfter:(NSTimeInterval)delay
{
    [self showHudWithText:text];
    
    __weak __typeof(&*self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf hideHud];
    });
}

- (void)hideHud
{
    MAIN_THREAD(^(){
        [TFHud hideInView:[[UIApplication sharedApplication] keyWindow]];
    });
}

@end
