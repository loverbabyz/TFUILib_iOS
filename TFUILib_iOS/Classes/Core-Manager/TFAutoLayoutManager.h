//
//  TFAutoLayoutManager.h
//  TFUILib_iOS
//
//  Created by Daniel on 2023/3/24.
//  Copyright © 2023 daniel.xiaofei@gmail.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TFAutoLayoutAlign) {
    TFAutoLayoutAlignTop,              // Top equals parent top
    TFAutoLayoutAlignTopHidden,        // Bottom equals parent top
    
    TFAutoLayoutAlignLeft,             // Left equals parent left
    TFAutoLayoutAlignLeftHidden,       // Right equals parent left
    
    TFAutoLayoutAlignBottom,           // Bottom equals parent bottom
    TFAutoLayoutAlignBottomHidden,     // Top equals parent bottom
    
    TFAutoLayoutAlignRight,            // Right equals parent right
    TFAutoLayoutAlignRightHidden,      // Left equals parent right
    
    TFAutoLayoutAlignCenter,           // Center equals parent center
};

@interface TFAutoLayoutManager : NSObject

/**
 *  @method makeViewMatchParent:
 */
+ (void)makeViewMatchParent:(UIView *)view;

/**
 *  @method makeViewMatchParent:margin:
 */
+ (void)makeViewMatchParent:(UIView *)view margin:(UIEdgeInsets)margin;

/**
 *  @method makeView:align:margin:
 */
+ (void)makeView:(UIView *)view align:(TFAutoLayoutAlign)alignment margin:(UIEdgeInsets)margin;

#pragma mark - Leading

/**
 *  @method view:leading:
 */
+ (void)view:(UIView *)view leading:(CGFloat)constant;

/**
 *  @method view:leading:to:attribute:
 */
+ (void)view:(UIView *)view
     leading:(CGFloat)constant
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute;

/**
 *  @method view:leading:relatedBy:to:attribute:multiplier:
 */
+ (void)view:(UIView *)view
     leading:(CGFloat)constant
   relatedBy:(NSLayoutRelation)relation
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute
  multiplier:(CGFloat)multiplier;

#pragma mark - Training

/**
 *  @method view:training:
 */
+ (void)view:(UIView *)view training:(CGFloat)constant;

/**
 *  @method view:training:to:attribute:
 */
+ (void)view:(UIView *)view
    training:(CGFloat)constant
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute;

/**
 *  @method view:training:relatedBy:to:attribute:multiplier:
 */
+ (void)view:(UIView *)view
    training:(CGFloat)constant
   relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView
   attribute:(NSLayoutAttribute)attribute
  multiplier:(CGFloat)multiplier;

#pragma mark - Left

/**
 *  @method view:left:
 */
+ (void)view:(UIView *)view left:(CGFloat)constant;

/**
 *  @method view:left:to:attribute:
 */
+ (void)view:(UIView *)view left:(CGFloat)constant
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute;

/**
 *  @method view:left:relatedBy:to:attribute:multiplier:
 */
+ (void)view:(UIView *)view
        left:(CGFloat)constant
   relatedBy:(NSLayoutRelation)relation
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute
  multiplier:(CGFloat)multiplier;

#pragma mark - Top

/**
 *  @method view:top:
 */
+ (void)view:(UIView *)view top:(CGFloat)constant;

/**
 *  @method view:top:to:attribute:
 */
+ (void)view:(UIView *)view
         top:(CGFloat)constant
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute;

/**
 *  @method view:top:relatedBy:to:attribute:multiplier:
 */
+ (void)view:(UIView *)view
         top:(CGFloat)constant
   relatedBy:(NSLayoutRelation)relation
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute
  multiplier:(CGFloat)multiplier;

#pragma mark - Right

/**
 *  @method view:right:
 */
+ (void)view:(UIView *)view right:(CGFloat)constant;

/**
 *  @method view:right:to:attribute:
 */
+ (void)view:(UIView *)view
       right:(CGFloat)constant
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute;

/**
 *  @method view:right:relatedBy:to:attribute:multiplier:
 */
+ (void)view:(UIView *)view
       right:(CGFloat)constant
   relatedBy:(NSLayoutRelation)relation
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute
  multiplier:(CGFloat)multiplier;

#pragma mark - Bottom

/**
 *  @method view:bottom:
 */
+ (void)view:(UIView *)view bottom:(CGFloat)constant;

/**
 *  @method view:bottom:to:attribute:
 */
+ (void)view:(UIView *)view
      bottom:(CGFloat)constant
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute;

/**
 *  @method view:bottom:relatedBy:to:attribute:multiplier:
 */
+ (void)view:(UIView *)view
      bottom:(CGFloat)constant
   relatedBy:(NSLayoutRelation)relation
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute
  multiplier:(CGFloat)multiplier;

#pragma mark - Width

/**
 *  @method view:width:
 */
+ (void)view:(UIView *)view width:(CGFloat)constant;

/**
 *  @method view:width:relatedBy:
 */
+ (void)view:(UIView *)view width:(CGFloat)constant relatedBy:(NSLayoutRelation)relation;

/**
 *  @method view:width:relatedBy:to:attribute:multiplier:
 */
+ (void)view:(UIView *)view
       width:(CGFloat)constant
   relatedBy:(NSLayoutRelation)relation
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute
  multiplier:(CGFloat)multiplier;

#pragma mark - Height

/**
 *  @method view:height:
 */
+ (void)view:(UIView *)view height:(CGFloat)constant;

/**
 *  @method view:height:relatedBy:
 */
+ (void)view:(UIView *)view height:(CGFloat)constant relatedBy:(NSLayoutRelation)relation;

/**
 *  @method view:height:relatedBy:to:attribute:multiplier:
 */
+ (void)view:(UIView *)view
      height:(CGFloat)constant
   relatedBy:(NSLayoutRelation)relation
          to:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute
  multiplier:(CGFloat)multiplier;

#pragma mark - CenterX

/**
 *  @method view:centerXTo:
 */
+ (void)view:(UIView *)view centerXTo:(UIView * _Nullable)toView;

/**
 *  @method view:centerXTo:attribute:
 */
+ (void)view:(UIView *)view
   centerXTo:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute;

#pragma mark - CenterY

/**
 *  @method view:centerYTo:
 */
+ (void)view:(UIView *)view centerYTo:(UIView * _Nullable)toView;

/**
 *  @method view:centerYTo:attribute:
 */
+ (void)view:(UIView *)view
   centerYTo:(UIView * _Nullable)toView
   attribute:(NSLayoutAttribute)attribute;

#pragma mark - Update constraint

/**
 *  @method update:attribute:constant:
 */
+ (void)update:(UIView *)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant;

#pragma mark - Remove constraint

/**
 *  @method remove:attribute:
 */
+ (void)remove:(UIView *)view attribute:(NSLayoutAttribute)attribute;

@end

NS_ASSUME_NONNULL_END
