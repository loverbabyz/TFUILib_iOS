//
//  UIView+TFMASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "View+TFMASAdditions.h"

#ifdef MAS_SHORTHAND

/**
 *	Shorthand view additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface TF_MAS_VIEW (TFMASShorthandAdditions)

@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_left;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_top;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_right;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_bottom;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_leading;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_trailing;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_width;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_height;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_centerX;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_centerY;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_baseline;
@property (nonatomic, strong, readonly) TFMASViewAttribute *(^attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_firstBaseline;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_leftMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_rightMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_topMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_bottomMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_leadingMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_trailingMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_centerXWithinMargins;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

- (NSArray *)tf_makeConstraints:(void(^)(TFMASConstraintMaker *make))block;
- (NSArray *)tf_updateConstraints:(void(^)(TFMASConstraintMaker *make))block;
- (NSArray *)tf_remakeConstraints:(void(^)(TFMASConstraintMaker *make))block;

@end

#define MAS_ATTR_FORWARD(attr)  \
- (TFMASViewAttribute *)attr {    \
    return [self tf_mas_##attr];   \
}

@implementation TF_MAS_VIEW (TFMASShorthandAdditions)

MAS_ATTR_FORWARD(tf_top);
MAS_ATTR_FORWARD(tf_left);
MAS_ATTR_FORWARD(tf_bottom);
MAS_ATTR_FORWARD(tf_right);
MAS_ATTR_FORWARD(tf_leading);
MAS_ATTR_FORWARD(tf_trailing);
MAS_ATTR_FORWARD(tf_width);
MAS_ATTR_FORWARD(tf_height);
MAS_ATTR_FORWARD(tf_centerX);
MAS_ATTR_FORWARD(tf_centerY);
MAS_ATTR_FORWARD(tf_baseline);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

MAS_ATTR_FORWARD(tf_firstBaseline);
MAS_ATTR_FORWARD(tf_lastBaseline);

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

MAS_ATTR_FORWARD(tf_leftMargin);
MAS_ATTR_FORWARD(tf_rightMargin);
MAS_ATTR_FORWARD(tf_topMargin);
MAS_ATTR_FORWARD(tf_bottomMargin);
MAS_ATTR_FORWARD(tf_leadingMargin);
MAS_ATTR_FORWARD(tf_trailingMargin);
MAS_ATTR_FORWARD(tf_centerXWithinMargins);
MAS_ATTR_FORWARD(tf_centerYWithinMargins);

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

MAS_ATTR_FORWARD(tf_safeAreaLayoutGuideTop);
MAS_ATTR_FORWARD(tf_safeAreaLayoutGuideBottom);
MAS_ATTR_FORWARD(tf_safeAreaLayoutGuideLeft);
MAS_ATTR_FORWARD(tf_safeAreaLayoutGuideRight);

#endif

- (TFMASViewAttribute *(^)(NSLayoutAttribute))attribute {
    return [self tf_mas_attribute];
}

- (NSArray *)tf_makeConstraints:(void(NS_NOESCAPE ^)(TFMASConstraintMaker *))block {
    return [self tf_mas_makeConstraints:block];
}

- (NSArray *)tf_updateConstraints:(void(NS_NOESCAPE ^)(TFMASConstraintMaker *))block {
    return [self tf_mas_updateConstraints:block];
}

- (NSArray *)tf_remakeConstraints:(void(NS_NOESCAPE ^)(TFMASConstraintMaker *))block {
    return [self tf_mas_remakeConstraints:block];
}

@end

#endif
