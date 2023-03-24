//
//  UIViewController+TFHBD.h
//  TFHBDNavigationBar
//
//  Created by Listen on 2018/3/23.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TFHBD)

@property(nonatomic, assign) IBInspectable BOOL tf_hbd_blackBarStyle;
@property(nonatomic, assign) UIBarStyle tf_hbd_barStyle;
@property(nonatomic, strong) IBInspectable UIColor *tf_hbd_barTintColor;
@property(nonatomic, strong) IBInspectable UIImage *tf_hbd_barImage;
@property(nonatomic, strong) IBInspectable UIColor *tf_hbd_tintColor;
@property(nonatomic, strong) NSDictionary *tf_hbd_titleTextAttributes;
@property(nonatomic, assign) IBInspectable CGFloat tf_hbd_barAlpha;
@property(nonatomic, assign) IBInspectable BOOL tf_hbd_barHidden;
@property(nonatomic, assign) IBInspectable BOOL tf_hbd_barShadowHidden;
@property(nonatomic, assign) IBInspectable BOOL tf_hbd_backInteractive;
@property(nonatomic, assign) IBInspectable BOOL tf_hbd_swipeBackEnabled;
@property(nonatomic, assign) IBInspectable BOOL tf_hbd_clickBackEnabled;
@property(nonatomic, assign) IBInspectable BOOL tf_hbd_splitNavigationBarTransition;

// computed
@property(nonatomic, assign, readonly) CGFloat tf_hbd_computedBarShadowAlpha;
@property(nonatomic, strong, readonly) UIColor *tf_hbd_computedBarTintColor;
@property(nonatomic, strong, readonly) UIImage *tf_hbd_computedBarImage;

// 这个属性是内部使用的
@property(nonatomic, assign) BOOL tf_hbd_extendedLayoutDidSet;

- (void)tf_hbd_setNeedsUpdateNavigationBar;

@end
