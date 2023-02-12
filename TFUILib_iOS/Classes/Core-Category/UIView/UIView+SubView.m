//
//  UIView+SubView.m
//  TFBaseLib
//
//  Created by Daniel on 15/10/16.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIView+SubView.h"
#import <TFBaseLib_iOS/TFBaseMacro+System.h>

@implementation UIView (SubView)

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (UIView *)subViewWithTag:(int)tag
{
    for (UIView *v in self.subviews)
    {
        if (v.tag == tag)
        {
            return v;
        }
    }
    
    return nil;
}

- (UIEdgeInsets)tf_safeAreaInset {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:MAIN_SCREEN.bounds];
        window.windowLevel = UIWindowLevelStatusBar+1;
        UIEdgeInsets insets = window.safeAreaInsets;
        
        return insets;
    }
    
    return UIEdgeInsetsZero;
}

@end
