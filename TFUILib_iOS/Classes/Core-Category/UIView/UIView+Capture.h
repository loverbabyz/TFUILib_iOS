//
//  UIView+Capture.h
//  TFUILib
//
//  Created by Daniel on 15/10/29.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Capture)

/**
 *  屏幕截屏
 */
- (UIImage *)captureScreenshot;

/**
 *  获取屏幕截图
 */
- (UIImage *)takeScreenshot;

/**
 *  获取屏幕截图
 */
- (UIImage *)capture;

@end
