//
//  UIViewController+TFHBD.m
//  TFHBDNavigationBar
//
//  Created by Listen on 2018/3/23.
//

#import "UIViewController+TFHBD.h"
#import <objc/runtime.h>
#import "TFHBDNavigationController.h"

@implementation UIViewController (TFHBD)

- (BOOL)tf_hbd_blackBarStyle {
    return self.tf_hbd_barStyle == UIBarStyleBlack;
}

- (void)setTf_hbd_blackBarStyle:(BOOL)hbd_blackBarStyle {
    self.tf_hbd_barStyle = hbd_blackBarStyle ? UIBarStyleBlack : UIBarStyleDefault;
}

- (UIBarStyle)tf_hbd_barStyle {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return [obj integerValue];
    }
    return [UINavigationBar appearance].barStyle;
}

- (void)setTf_hbd_barStyle:(UIBarStyle)hbd_barStyle {
    objc_setAssociatedObject(self, @selector(tf_hbd_barStyle), @(hbd_barStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)tf_hbd_barTintColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTf_hbd_barTintColor:(UIColor *)tintColor {
    objc_setAssociatedObject(self, @selector(tf_hbd_barTintColor), tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)tf_hbd_barImage {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTf_hbd_barImage:(UIImage *)image {
    objc_setAssociatedObject(self, @selector(tf_hbd_barImage), image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)tf_hbd_tintColor {
    id obj = objc_getAssociatedObject(self, _cmd);
    return (obj ?: [UINavigationBar appearance].tintColor) ?: UIColor.blackColor;
}

- (void)setTf_hbd_tintColor:(UIColor *)tintColor {
    objc_setAssociatedObject(self, @selector(tf_hbd_tintColor), tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)tf_hbd_titleTextAttributes {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (obj) {
        return obj;
    }

    UIBarStyle barStyle = self.tf_hbd_barStyle;
    NSDictionary *attributes = [UINavigationBar appearance].titleTextAttributes;
    if (attributes) {
        if (!attributes[NSForegroundColorAttributeName]) {
            NSMutableDictionary *mutableAttributes = [attributes mutableCopy];
            if (barStyle == UIBarStyleBlack) {
                [mutableAttributes addEntriesFromDictionary:@{NSForegroundColorAttributeName: UIColor.whiteColor}];
            } else {
                [mutableAttributes addEntriesFromDictionary:@{NSForegroundColorAttributeName: UIColor.blackColor}];
            }
            return mutableAttributes;
        }
        return attributes;
    }

    if (barStyle == UIBarStyleBlack) {
        return @{NSForegroundColorAttributeName: UIColor.whiteColor};
    } else {
        return @{NSForegroundColorAttributeName: UIColor.blackColor};
    }
}

- (void)setTf_hbd_titleTextAttributes:(NSDictionary *)attributes {
    objc_setAssociatedObject(self, @selector(tf_hbd_titleTextAttributes), attributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)tf_hbd_extendedLayoutDidSet {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (void)setTf_hbd_extendedLayoutDidSet:(BOOL)didSet {
    objc_setAssociatedObject(self, @selector(tf_hbd_extendedLayoutDidSet), @(didSet), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGFloat)tf_hbd_barAlpha {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (self.tf_hbd_barHidden) {
        return 0;
    }
    return obj ? [obj floatValue] : 1.0f;
}

- (void)setTf_hbd_barAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, @selector(tf_hbd_barAlpha), @(alpha), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)tf_hbd_barHidden {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (void)setTf_hbd_barHidden:(BOOL)hidden {
    if (hidden) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
        self.navigationItem.titleView = [UIView new];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.titleView = nil;
    }
    objc_setAssociatedObject(self, @selector(tf_hbd_barHidden), @(hidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)tf_hbd_barShadowHidden {
    id obj = objc_getAssociatedObject(self, _cmd);
    return self.tf_hbd_barHidden || obj ? [obj boolValue] : NO;
}

- (void)setTf_hbd_barShadowHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, @selector(tf_hbd_barShadowHidden), @(hidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)tf_hbd_backInteractive {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : YES;
}

- (void)setTf_hbd_backInteractive:(BOOL)interactive {
    objc_setAssociatedObject(self, @selector(tf_hbd_backInteractive), @(interactive), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)tf_hbd_swipeBackEnabled {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : YES;
}

- (void)setTf_hbd_swipeBackEnabled:(BOOL)enabled {
    objc_setAssociatedObject(self, @selector(tf_hbd_swipeBackEnabled), @(enabled), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)tf_hbd_clickBackEnabled {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : YES;
}

- (void)setTf_hbd_clickBackEnabled:(BOOL)enabled {
    objc_setAssociatedObject(self, @selector(tf_hbd_clickBackEnabled), @(enabled), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)tf_hbd_splitNavigationBarTransition {
    id obj = objc_getAssociatedObject(self, _cmd);
    return obj ? [obj boolValue] : NO;
}

- (void)setTf_hbd_splitNavigationBarTransition:(BOOL)splitNavigationBarTransition {
    objc_setAssociatedObject(self, @selector(tf_hbd_splitNavigationBarTransition), @(splitNavigationBarTransition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)tf_hbd_computedBarShadowAlpha {
    return self.tf_hbd_barShadowHidden ? 0 : self.tf_hbd_barAlpha;
}

- (UIImage *)tf_hbd_computedBarImage {
    UIImage *image = self.tf_hbd_barImage;
    if (!image) {
        if (self.tf_hbd_barTintColor != nil) {
            return nil;
        }
        image = [[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault];
    }
    return image;
}

- (UIColor *)tf_hbd_computedBarTintColor {
    if (self.tf_hbd_barHidden) {
        return UIColor.clearColor;
    }

    if (self.tf_hbd_barImage) {
        return nil;
    }

    UIColor *color = self.tf_hbd_barTintColor;
    if (!color) {
        if ([[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault] != nil) {
            return nil;
        }
        if ([UINavigationBar appearance].barTintColor != nil) {
            color = [UINavigationBar appearance].barTintColor;
        } else {
            color = [UINavigationBar appearance].barStyle == UIBarStyleDefault ? [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:0.8] : [UIColor colorWithRed:28 / 255.0 green:28 / 255.0 blue:28 / 255.0 alpha:0.729];
        }
    }
    return color;
}

- (void)tf_hbd_setNeedsUpdateNavigationBar {
    if (self.navigationController && [self.navigationController isKindOfClass:[TFHBDNavigationController class]]) {
        TFHBDNavigationController *nav = (TFHBDNavigationController *) self.navigationController;
        if (self == nav.topViewController) {
            [nav updateNavigationBarForViewController:self];
            [nav setNeedsStatusBarAppearanceUpdate];
        }
    }
}

@end
