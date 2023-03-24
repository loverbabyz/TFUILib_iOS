//
//  TFMASConstraint+Private.h
//  Masonry
//
//  Created by Nick Tymchenko on 29/04/14.
//  Copyright (c) 2014 cloudling. All rights reserved.
//

#import "TFMASConstraint.h"

@protocol TFMASConstraintDelegate;


@interface TFMASConstraint ()

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *	Usually TFMASConstraintMaker but could be a parent TFMASConstraint
 */
@property (nonatomic, weak) id<TFMASConstraintDelegate> delegate;

/**
 *  Based on a provided value type, is equal to calling:
 *  NSNumber - setOffset:
 *  NSValue with CGPoint - setPointOffset:
 *  NSValue with CGSize - setSizeOffset:
 *  NSValue with TFMASEdgeInsets - setInsets:
 */
- (void)setLayoutConstantWithValue:(NSValue *)value;

@end


@interface TFMASConstraint (Abstract)

/**
 *	Sets the constraint relation to given NSLayoutRelation
 *  returns a block which accepts one of the following:
 *    TFMASViewAttribute, UIView, NSValue, NSArray
 *  see readme for more details.
 */
- (TFMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation;

/**
 *	Override to set a custom chaining behaviour
 */
- (TFMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end


@protocol TFMASConstraintDelegate <NSObject>

/**
 *	Notifies the delegate when the constraint needs to be replaced with another constraint. For example
 *  A TFMASViewConstraint may turn into a TFMASCompositeConstraint when an array is passed to one of the equality blocks
 */
- (void)constraint:(TFMASConstraint *)constraint shouldBeReplacedWithConstraint:(TFMASConstraint *)replacementConstraint;

- (TFMASConstraint *)constraint:(TFMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute;

@end
