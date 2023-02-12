//
//  UIViewController+TFToast.m
//  TFUILib
//
//  Created by Daniel on 16/3/21.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIViewController+TFToast.h"
#import "UIViewController+Ext.h"
#import "TFToast.h"

#import <TFBaseLib_iOS/TFBaseMacro+System.h>

@implementation UIViewController (TFToast)

#pragma mark toast

- (void)showToast:(NSString*)text {
    MAIN_THREAD(^(){
        [TFToast showWithText:text duration:2.5 atView:APP_KEY_WINDOW type:kToastTypeTop offsetY:64];
    });
}

- (void)showToastWithText:(NSString*)text {
    MAIN_THREAD(^(){
        [TFToast showWithText:text duration:2.5 atView:APP_KEY_WINDOW type:kToastTypeTop offsetY:64];
    });
}

@end
