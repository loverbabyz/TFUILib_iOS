//
//  UIView+TFMASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "TFMASUtilities.h"
#import "TFMASConstraintMaker.h"
#import "TFMASViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating TFMASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface TF_MAS_VIEW (TFMASAdditions)

/**
 *	following properties return a new TFMASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_left;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_top;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_right;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_bottom;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_leading;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_trailing;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_width;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_height;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_centerX;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_centerY;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_baseline;
@property (nonatomic, strong, readonly) TFMASViewAttribute *(^tf_mas_attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_firstBaseline;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_leftMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_rightMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_topMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_bottomMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_leadingMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_trailingMargin;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_centerXWithinMargins;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_safeAreaLayoutGuide API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id tf_mas_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)tf_mas_closestCommonSuperview:(TF_MAS_VIEW *)view;

/**
 *  Creates a TFMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)tf_mas_makeConstraints:(void(NS_NOESCAPE ^)(TFMASConstraintMaker *make))block;

/**
 *  Creates a TFMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)tf_mas_updateConstraints:(void(NS_NOESCAPE ^)(TFMASConstraintMaker *make))block;

/**
 *  Creates a TFMASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)tf_mas_remakeConstraints:(void(NS_NOESCAPE ^)(TFMASConstraintMaker *make))block;

@end
