//
//  TFMASConstraintMaker.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "TFMASConstraint.h"
#import "TFMASUtilities.h"

typedef NS_OPTIONS(NSInteger, TFMASAttribute) {
    TFMASAttributeLeft = 1 << NSLayoutAttributeLeft,
    TFMASAttributeRight = 1 << NSLayoutAttributeRight,
    TFMASAttributeTop = 1 << NSLayoutAttributeTop,
    TFMASAttributeBottom = 1 << NSLayoutAttributeBottom,
    TFMASAttributeLeading = 1 << NSLayoutAttributeLeading,
    TFMASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    TFMASAttributeWidth = 1 << NSLayoutAttributeWidth,
    TFMASAttributeHeight = 1 << NSLayoutAttributeHeight,
    TFMASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    TFMASAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    TFMASAttributeBaseline = 1 << NSLayoutAttributeBaseline,
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    TFMASAttributeFirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    TFMASAttributeLastBaseline = 1 << NSLayoutAttributeLastBaseline,
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    TFMASAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    TFMASAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    TFMASAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    TFMASAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    TFMASAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    TFMASAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    TFMASAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    TFMASAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

/**
 *  Provides factory methods for creating MASConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface TFMASConstraintMaker : NSObject

/**
 *	The following properties return a new TFMASViewConstraint
 *  with the first item set to the makers associated view and the appropriate TFMASViewAttribute
 */
@property (nonatomic, strong, readonly) TFMASConstraint *left;
@property (nonatomic, strong, readonly) TFMASConstraint *top;
@property (nonatomic, strong, readonly) TFMASConstraint *right;
@property (nonatomic, strong, readonly) TFMASConstraint *bottom;
@property (nonatomic, strong, readonly) TFMASConstraint *leading;
@property (nonatomic, strong, readonly) TFMASConstraint *trailing;
@property (nonatomic, strong, readonly) TFMASConstraint *width;
@property (nonatomic, strong, readonly) TFMASConstraint *height;
@property (nonatomic, strong, readonly) TFMASConstraint *centerX;
@property (nonatomic, strong, readonly) TFMASConstraint *centerY;
@property (nonatomic, strong, readonly) TFMASConstraint *baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) TFMASConstraint *firstBaseline;
@property (nonatomic, strong, readonly) TFMASConstraint *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) TFMASConstraint *leftMargin;
@property (nonatomic, strong, readonly) TFMASConstraint *rightMargin;
@property (nonatomic, strong, readonly) TFMASConstraint *topMargin;
@property (nonatomic, strong, readonly) TFMASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) TFMASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) TFMASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) TFMASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) TFMASConstraint *centerYWithinMargins;

#endif

/**
 *  Returns a block which creates a new TFMASCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  TFMASAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) TFMASConstraint *(^attributes)(TFMASAttribute attrs);

/**
 *	Creates a TFMASCompositeConstraint with type MASCompositeConstraintTypeEdges
 *  which generates the appropriate TFMASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) TFMASConstraint *edges;

/**
 *	Creates a TFMASCompositeConstraint with type MASCompositeConstraintTypeSize
 *  which generates the appropriate TFMASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) TFMASConstraint *size;

/**
 *	Creates a TFMASCompositeConstraint with type MASCompositeConstraintTypeCenter
 *  which generates the appropriate TFMASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) TFMASConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any TFMASConstraint are created with this view as the first item
 *
 *	@return	a new TFMASConstraintMaker
 */
- (id)initWithView:(TF_MAS_VIEW *)view;

/**
 *	Calls install method on any MASConstraints which have been created by this maker
 *
 *	@return	an array of all the installed MASConstraints
 */
- (NSArray *)install;

- (TFMASConstraint * (^)(dispatch_block_t))group;

@end
