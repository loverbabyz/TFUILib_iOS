//
//  UIView+BlurEffect.m
//  TFUILib
//
//  Created by sunxiaofei on 16/6/4.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIView+BlurEffect.h"
#import <TFBaseLib_iOS/TFBaseMacro+System.h>

@implementation UIView (BlurEffect)

- (void)blueEffectWithStyle:(UIBlurEffectStyle)style
{
    if ([SYSTEM_VERSION floatValue] < 8.0f)
    {
#ifdef DEBUG
        NSAssert(YES, @"Only support iOS 8.0+");
#endif
        
        return;
    }
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
    effectview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:effectview];
}

@end
