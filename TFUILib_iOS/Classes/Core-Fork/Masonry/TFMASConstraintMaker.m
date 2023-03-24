//
//  MASConstraintMaker.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "TFMASConstraintMaker.h"
#import "TFMASViewConstraint.h"
#import "TFMASCompositeConstraint.h"
#import "TFMASConstraint+Private.h"
#import "TFMASViewAttribute.h"
#import "View+TFMASAdditions.h"

@interface TFMASConstraintMaker () <TFMASConstraintDelegate>

@property (nonatomic, weak) TF_MAS_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation TFMASConstraintMaker

- (id)initWithView:(TF_MAS_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [TFMASViewConstraint installedConstraintsForView:self.view];
        for (TFMASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (TFMASConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(TFMASConstraint *)constraint shouldBeReplacedWithConstraint:(TFMASConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (TFMASConstraint *)constraint:(TFMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    TFMASViewAttribute *viewAttribute = [[TFMASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    TFMASViewConstraint *newConstraint = [[TFMASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:TFMASViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        TFMASCompositeConstraint *compositeConstraint = [[TFMASCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (TFMASConstraint *)addConstraintWithAttributes:(TFMASAttribute)attrs {
    __unused TFMASAttribute anyAttribute = (TFMASAttributeLeft | TFMASAttributeRight | TFMASAttributeTop | TFMASAttributeBottom | TFMASAttributeLeading
                                          | TFMASAttributeTrailing | TFMASAttributeWidth | TFMASAttributeHeight | TFMASAttributeCenterX
                                          | TFMASAttributeCenterY | TFMASAttributeBaseline
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
                                          | TFMASAttributeFirstBaseline | TFMASAttributeLastBaseline
#endif
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
                                          | TFMASAttributeLeftMargin | TFMASAttributeRightMargin | TFMASAttributeTopMargin | TFMASAttributeBottomMargin
                                          | TFMASAttributeLeadingMargin | TFMASAttributeTrailingMargin | TFMASAttributeCenterXWithinMargins
                                          | TFMASAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & TFMASAttributeLeft) [attributes addObject:self.view.tf_mas_left];
    if (attrs & TFMASAttributeRight) [attributes addObject:self.view.tf_mas_right];
    if (attrs & TFMASAttributeTop) [attributes addObject:self.view.tf_mas_top];
    if (attrs & TFMASAttributeBottom) [attributes addObject:self.view.tf_mas_bottom];
    if (attrs & TFMASAttributeLeading) [attributes addObject:self.view.tf_mas_leading];
    if (attrs & TFMASAttributeTrailing) [attributes addObject:self.view.tf_mas_trailing];
    if (attrs & TFMASAttributeWidth) [attributes addObject:self.view.tf_mas_width];
    if (attrs & TFMASAttributeHeight) [attributes addObject:self.view.tf_mas_height];
    if (attrs & TFMASAttributeCenterX) [attributes addObject:self.view.tf_mas_centerX];
    if (attrs & TFMASAttributeCenterY) [attributes addObject:self.view.tf_mas_centerY];
    if (attrs & TFMASAttributeBaseline) [attributes addObject:self.view.tf_mas_baseline];
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    if (attrs & TFMASAttributeFirstBaseline) [attributes addObject:self.view.tf_mas_firstBaseline];
    if (attrs & TFMASAttributeLastBaseline) [attributes addObject:self.view.tf_mas_lastBaseline];
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    if (attrs & TFMASAttributeLeftMargin) [attributes addObject:self.view.tf_mas_leftMargin];
    if (attrs & TFMASAttributeRightMargin) [attributes addObject:self.view.tf_mas_rightMargin];
    if (attrs & TFMASAttributeTopMargin) [attributes addObject:self.view.tf_mas_topMargin];
    if (attrs & TFMASAttributeBottomMargin) [attributes addObject:self.view.tf_mas_bottomMargin];
    if (attrs & TFMASAttributeLeadingMargin) [attributes addObject:self.view.tf_mas_leadingMargin];
    if (attrs & TFMASAttributeTrailingMargin) [attributes addObject:self.view.tf_mas_trailingMargin];
    if (attrs & TFMASAttributeCenterXWithinMargins) [attributes addObject:self.view.tf_mas_centerXWithinMargins];
    if (attrs & TFMASAttributeCenterYWithinMargins) [attributes addObject:self.view.tf_mas_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (TFMASViewAttribute *a in attributes) {
        [children addObject:[[TFMASViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    TFMASCompositeConstraint *constraint = [[TFMASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (TFMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (TFMASConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (TFMASConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (TFMASConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (TFMASConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (TFMASConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (TFMASConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (TFMASConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (TFMASConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (TFMASConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (TFMASConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (TFMASConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (TFMASConstraint *(^)(TFMASAttribute))attributes {
    return ^(TFMASAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (TFMASConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (TFMASConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif


#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (TFMASConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (TFMASConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (TFMASConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (TFMASConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (TFMASConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (TFMASConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (TFMASConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (TFMASConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (TFMASConstraint *)edges {
    return [self addConstraintWithAttributes:TFMASAttributeTop | TFMASAttributeLeft | TFMASAttributeRight | TFMASAttributeBottom];
}

- (TFMASConstraint *)size {
    return [self addConstraintWithAttributes:TFMASAttributeWidth | TFMASAttributeHeight];
}

- (TFMASConstraint *)center {
    return [self addConstraintWithAttributes:TFMASAttributeCenterX | TFMASAttributeCenterY];
}

#pragma mark - grouping

- (TFMASConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        TFMASCompositeConstraint *constraint = [[TFMASCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
