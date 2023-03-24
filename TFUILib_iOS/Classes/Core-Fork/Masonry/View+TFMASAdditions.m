//
//  UIView+TFMASAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+TFMASAdditions.h"
#import <objc/runtime.h>

@implementation TF_MAS_VIEW (TFMASAdditions)

- (NSArray *)tf_mas_makeConstraints:(void(^)(TFMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    TFMASConstraintMaker *constraintMaker = [[TFMASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)tf_mas_updateConstraints:(void(^)(TFMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    TFMASConstraintMaker *constraintMaker = [[TFMASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)tf_mas_remakeConstraints:(void(^)(TFMASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    TFMASConstraintMaker *constraintMaker = [[TFMASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (TFMASViewAttribute *)tf_mas_left {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (TFMASViewAttribute *)tf_mas_top {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (TFMASViewAttribute *)tf_mas_right {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (TFMASViewAttribute *)tf_mas_bottom {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (TFMASViewAttribute *)tf_mas_leading {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (TFMASViewAttribute *)tf_mas_trailing {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (TFMASViewAttribute *)tf_mas_width {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (TFMASViewAttribute *)tf_mas_height {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (TFMASViewAttribute *)tf_mas_centerX {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (TFMASViewAttribute *)tf_mas_centerY {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (TFMASViewAttribute *)tf_mas_baseline {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (TFMASViewAttribute *(^)(NSLayoutAttribute))tf_mas_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (TFMASViewAttribute *)tf_mas_firstBaseline {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (TFMASViewAttribute *)tf_mas_lastBaseline {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (TFMASViewAttribute *)tf_mas_leftMargin {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (TFMASViewAttribute *)tf_mas_rightMargin {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (TFMASViewAttribute *)tf_mas_topMargin {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (TFMASViewAttribute *)tf_mas_bottomMargin {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (TFMASViewAttribute *)tf_mas_leadingMargin {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (TFMASViewAttribute *)tf_mas_trailingMargin {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (TFMASViewAttribute *)tf_mas_centerXWithinMargins {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (TFMASViewAttribute *)tf_mas_centerYWithinMargins {
    return [[TFMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

- (TFMASViewAttribute *)tf_mas_safeAreaLayoutGuide {
    return [[TFMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (TFMASViewAttribute *)tf_mas_safeAreaLayoutGuideTop {
    return [[TFMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (TFMASViewAttribute *)tf_mas_safeAreaLayoutGuideBottom {
    return [[TFMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (TFMASViewAttribute *)tf_mas_safeAreaLayoutGuideLeft {
    return [[TFMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
}
- (TFMASViewAttribute *)tf_mas_safeAreaLayoutGuideRight {
    return [[TFMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
}

#endif

#pragma mark - associated properties

- (id)tf_mas_key {
    return objc_getAssociatedObject(self, @selector(tf_mas_key));
}

- (void)setTf_mas_key:(id)key {
    objc_setAssociatedObject(self, @selector(tf_mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)tf_mas_closestCommonSuperview:(TF_MAS_VIEW *)view {
    TF_MAS_VIEW *closestCommonSuperview = nil;

    TF_MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        TF_MAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
