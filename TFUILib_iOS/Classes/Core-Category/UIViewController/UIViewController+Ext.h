//
//  UIViewController+Ext.h
//  TFUILib
//
//  Created by Daniel on 16/4/8.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Ext)

/**
 *  获取最顶层vc
 */
- (UIViewController*)toppestViewController;

/**
 *  获取最顶层vc
 */
- (UIViewController*)rootViewController;

/**
 *  屏幕宽度
 */
-(CGFloat)screenWidth;

/**
 *  屏幕高度
 */
-(CGFloat)screenHeight;

@end
