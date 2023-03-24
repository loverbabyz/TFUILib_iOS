//
//  TFAutoLayoutManager.m
//  TFUILib_iOS
//
//  Created by Daniel on 2023/3/24.
//  Copyright © 2023 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFAutoLayoutManager.h"
#import <TFBaseLib_iOS/NSObject+Swizzle.h>
#import <objc/runtime.h>

#pragma mark - UIView (TF)

@interface UIView (TF)

/**
 * @property x
 */
@property (nonatomic, assign) CGFloat x;

/**
 * @property y
 */
@property (nonatomic, assign) CGFloat y;

/**
 * @property width
 */
@property (nonatomic, assign) CGFloat width;

/**
 * @property height
 */
@property (nonatomic, assign) CGFloat height;

/**
 * @property maxY
 */
@property (nonatomic, assign) CGFloat maxY;

/**
 * @property maxX
 */
@property (nonatomic, assign) CGFloat maxX;

/**
 * @property origin
 */
@property (nonatomic, assign) CGPoint origin;

/**
 * @property size
 */
@property (nonatomic, assign) CGSize size;

/**
 * @property centerX
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 * @property centerY
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

- (void)setRadiiCorner:(CGFloat)radii borderWidth:(CGFloat)width borderColor:(UIColor *)color;

@end

#pragma mark - Hierarchy

@interface UIView (TF_UIView_Hierarchy)

- (UIView *)closestSuperview:(UIView *)view;

@end

#pragma mark - AutoLayout

@interface UIView (TF_UIView_Autolayout)

@property (nonatomic, strong, readonly) NSArray<NSLayoutConstraint *> *allConstraints;

@end

@interface UIView (TF_UIView_Snapshot)

- (UIImage *)screenshot;

- (UIImage *)screenshotForCroppingRect:(CGRect)rect;

@end
@implementation UIView (TF)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX {
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY {
    CGRect frame = self.frame;
    frame.origin.y = newY;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newWidth {
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newHeight {
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    [self setY:maxY - self.height];
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX {
    [self setX:maxX - self.width];
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect r = self.frame;
    r.origin = origin;
    self.frame = r;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect r = self.frame;
    r.size = size;
    self.frame = r;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}


- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect
                                                  byRoundingCorners:corners
                                                        cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

- (void)setRadiiCorner:(CGFloat)radii borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    self.layer.cornerRadius = radii;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}


@end

#pragma mark - Hierarchy

@implementation UIView (TF_UIView_Hierarchy)

- (UIView *)closestSuperview:(UIView *)view {
    UIView *item = self.superview;
    while (item) {
        if (item == view) {
            return item;
        }
        item = item.superview;
    }
    return nil;
}

@end


#pragma mark - AutoLayout

@implementation UIView (TF_UIView_Autolayout)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [super load];

        // Swizzle addConstraint methods
        Class clazz = [self class];
        /**
         * Just need to swizzle addConstraint and removeConstraint
         * In fact addConstraints will call into addConstraint
         */
        
        [UIView safe_swizzleMethod:@selector(addConstraint:) tarClass:NSStringFromClass(clazz) tarSel:@selector(TF_addConstraint:)];
    });
}

- (void)TF_addConstraint:(NSLayoutConstraint *)constraint {
    // Call original addContraint
    [self TF_addConstraint:constraint];

    if (constraint) {
        // Check and set owner for constraint, useing key->value
        [constraint setValue:self forKey:@"owner"];
    }
}

- (NSArray<NSLayoutConstraint *> *)allConstraints {
    NSMutableArray<NSLayoutConstraint *> *allConstraints = [NSMutableArray<NSLayoutConstraint *> array];
    UIView *view = self;
    while (view) {
        for (NSLayoutConstraint *constraint in view.constraints) {
            if (constraint.firstItem == self || constraint.secondItem == self) {
                [allConstraints addObject:constraint];
            }
        }
        view = view.superview;
    }
    return allConstraints;
}

@end

#pragma mark - Snapshot

@implementation UIView (TF_UIView_Snapshot)

- (UIImage *)screenshot {
    return [self screenshotForCroppingRect:self.bounds];
}

- (UIImage *)screenshotForCroppingRect:(CGRect)croppingRect {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        CGFloat scale = [UIScreen mainScreen].scale;
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.opaque, scale);
    }
    else {
        UIGraphicsBeginImageContext(croppingRect.size);
    }
    
    // Create a graphics context and translate it the view we want to crop so
    // that even in grabbing (0,0), that origin point now represents the actual
    // cropping origin desired:
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL) return nil;
    CGContextTranslateCTM(context, -croppingRect.origin.x, -croppingRect.origin.y);
    
    [self layoutIfNeeded];
    [self.layer renderInContext:context];
    // [self drawViewHierarchyInRect:croppingRect afterScreenUpdates:NO];
    
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenshotImage;
}

@end

#pragma mark - NSLayoutConstraint

@interface NSLayoutConstraint (TF)

@property (nonatomic, assign, readonly) UIView *owner;

- (void)remove;

@end
static NSString *kTFLayoutConstraintOwnerKey = nil;

@implementation NSLayoutConstraint (TF)

- (void)setOwner:(UIView *)owner {
    if (owner &&
        [owner isKindOfClass:[UIView class]] &&
        [owner.constraints containsObject:self]) {
        objc_setAssociatedObject(self, &kTFLayoutConstraintOwnerKey, owner, OBJC_ASSOCIATION_ASSIGN);
    }
    else {
        objc_setAssociatedObject(self, &kTFLayoutConstraintOwnerKey, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}

- (UIView *)owner {
    return objc_getAssociatedObject(self, &kTFLayoutConstraintOwnerKey);
}

- (void)remove {
    [self.owner removeConstraint:self];
}

@end
#pragma mark - TFAutoLayoutManager

@implementation TFAutoLayoutManager

#pragma mark - Constraints (Match/Align)

+ (void)makeViewMatchParent:(UIView *)view {
    [self makeViewMatchParent:view margin:UIEdgeInsetsZero];
}

+ (void)makeViewMatchParent:(UIView *)view margin:(UIEdgeInsets)margin {
    [self view:view leading:margin.left];
    [self view:view training:margin.right];
    [self view:view top:margin.top];
    [self view:view bottom:margin.bottom];
}

+ (void)makeView:(UIView *)view align:(TFAutoLayoutAlign)alignment margin:(UIEdgeInsets)margin {
    if (!view || !view.superview) {
        return;
    }
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self removeAllConstraintsFromParent:view];
    
    if (alignment == TFAutoLayoutAlignLeft ||
        alignment == TFAutoLayoutAlignRight ||
        alignment == TFAutoLayoutAlignCenter ||
        alignment == TFAutoLayoutAlignLeftHidden ||
        alignment == TFAutoLayoutAlignRightHidden) {
        
        if (alignment == TFAutoLayoutAlignCenter) {
            [self view:view centerXTo:nil];
        }
        else if (alignment == TFAutoLayoutAlignLeft) {
            [self view:view left:margin.left];
        }
        else if (alignment == TFAutoLayoutAlignLeftHidden) {
            [self view:view right:0 to:nil attribute:NSLayoutAttributeLeft];
        }
        else if (alignment == TFAutoLayoutAlignRight) {
            [self view:view right:margin.right];
        }
        else if (alignment == TFAutoLayoutAlignRightHidden) {
            [self view:view left:0 to:nil attribute:NSLayoutAttributeRight];
        }
        
        [self view:view centerYTo:nil];
    }
    else if (alignment == TFAutoLayoutAlignTop ||
             alignment == TFAutoLayoutAlignBottom ||
             alignment == TFAutoLayoutAlignTopHidden ||
             alignment == TFAutoLayoutAlignBottomHidden) {
        
        if (alignment == TFAutoLayoutAlignTop) {
            [self view:view top:margin.top to:nil attribute:NSLayoutAttributeTop];
        }
        else if (alignment == TFAutoLayoutAlignTopHidden) {
            [self view:view bottom:0 to:nil attribute:NSLayoutAttributeTop];
        }
        else if (alignment == TFAutoLayoutAlignBottom) {
            [self view:view bottom:margin.bottom to:nil attribute:NSLayoutAttributeBottom];
        }
        else if (alignment == TFAutoLayoutAlignBottomHidden) {
            [self view:view top:0 to:nil attribute:NSLayoutAttributeBottom];
        }
        
        [self view:view centerXTo:nil];
    }
}

#pragma mark - Constraints (Leading)

+ (void)view:(UIView *)view leading:(CGFloat)constant {
    [self view:view leading:constant to:nil attribute:NSLayoutAttributeLeading];
}

+ (void)view:(UIView *)view leading:(CGFloat)constant
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute {
    [self view:view leading:constant relatedBy:NSLayoutRelationEqual
            to:toView attribute:attribute multiplier:1.0];
}

+ (void)view:(UIView *)view leading:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute
            multiplier:(CGFloat)multiplier {
    if (!view || !view.superview) {
        return;
    }
    [self view:view firstAttribute:NSLayoutAttributeLeading
            to:(toView? toView : view.superview) secondAttribute:attribute
      relation:relation multiplier:multiplier constant:constant];
}

#pragma mark - Constraints (Training)

+ (void)view:(UIView *)view training:(CGFloat)constant {
    [self view:view training:constant to:nil attribute:NSLayoutAttributeTrailing];
}

+ (void)view:(UIView *)view training:(CGFloat)constant
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute {
    [self view:view training:constant relatedBy:NSLayoutRelationEqual
            to:toView attribute:attribute multiplier:1.0];
}

+ (void)view:(UIView *)view training:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute
            multiplier:(CGFloat)multiplier {
    if (!view || !view.superview) {
        return;
    }
    [self view:view firstAttribute:NSLayoutAttributeTrailing
            to:(toView? toView : view.superview) secondAttribute:attribute
      relation:relation multiplier:multiplier constant:constant * -1];
}

#pragma mark - Constraints (Left)

+ (void)view:(UIView *)view left:(CGFloat)constant {
    [self view:view left:constant to:nil attribute:NSLayoutAttributeLeft];
}

+ (void)view:(UIView *)view left:(CGFloat)constant
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute {
    [self view:view left:constant relatedBy:NSLayoutRelationEqual
            to:toView attribute:attribute multiplier:1.0];
}

+ (void)view:(UIView *)view left:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute
            multiplier:(CGFloat)multiplier {
    if (!view || !view.superview) {
        return;
    }
    [self view:view firstAttribute:NSLayoutAttributeLeft
            to:(toView? toView : view.superview) secondAttribute:attribute
      relation:relation multiplier:multiplier constant:constant];
}

#pragma mark - Constraints (Top)

+ (void)view:(UIView *)view top:(CGFloat)constant {
    [self view:view top:constant to:nil attribute:NSLayoutAttributeTop];
}

+ (void)view:(UIView *)view top:(CGFloat)constant
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute {
    [self view:view top:constant relatedBy:NSLayoutRelationEqual
            to:toView attribute:attribute multiplier:1.0];
}

+ (void)view:(UIView *)view top:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute
            multiplier:(CGFloat)multiplier {
    if (!view || !view.superview) {
        return;
    }
    [self view:view firstAttribute:NSLayoutAttributeTop
            to:(toView? toView : view.superview) secondAttribute:attribute
      relation:relation multiplier:multiplier constant:constant];
}

#pragma mark - Constraints (Right)

+ (void)view:(UIView *)view right:(CGFloat)constant {
    [self view:view right:constant to:nil attribute:NSLayoutAttributeRight];
}

+ (void)view:(UIView *)view right:(CGFloat)constant
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute {
    [self view:view right:constant relatedBy:NSLayoutRelationEqual
            to:toView attribute:attribute multiplier:1.0];
}

+ (void)view:(UIView *)view right:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute
            multiplier:(CGFloat)multiplier {
    if (!view || !view.superview) {
        return;
    }
    [self view:view firstAttribute:NSLayoutAttributeRight
            to:(toView? toView : view.superview) secondAttribute:attribute
      relation:relation multiplier:multiplier constant:constant * -1];
}

#pragma mark - Constraints (Bottom)

+ (void)view:(UIView *)view bottom:(CGFloat)constant {
    [self view:view bottom:constant to:nil attribute:NSLayoutAttributeBottom];
}

+ (void)view:(UIView *)view bottom:(CGFloat)constant
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute {
    [self view:view bottom:constant relatedBy:NSLayoutRelationEqual
            to:toView attribute:attribute multiplier:1.0];
}

+ (void)view:(UIView *)view bottom:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute
            multiplier:(CGFloat)multiplier {
    if (!view || !view.superview) {
        return;
    }
    [self view:view firstAttribute:NSLayoutAttributeBottom
            to:(toView? toView : view.superview) secondAttribute:attribute
      relation:relation multiplier:multiplier constant:constant * -1];
}

#pragma mark - Constraints (Width)

+ (void)view:(UIView *)view width:(CGFloat)constant {
    [self view:view width:constant relatedBy:NSLayoutRelationEqual];
}

+ (void)view:(UIView *)view width:(CGFloat)constant relatedBy:(NSLayoutRelation)relation {
    [self view:view width:constant relatedBy:relation
            to:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0];
}

+ (void)view:(UIView *)view width:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute
            multiplier:(CGFloat)multiplier {
    [self view:view firstAttribute:NSLayoutAttributeWidth
            to:toView secondAttribute:attribute
      relation:relation multiplier:multiplier constant:constant];
}

#pragma mark - Constraints (Height)

+ (void)view:(UIView *)view height:(CGFloat)constant {
    [self view:view height:constant relatedBy:NSLayoutRelationEqual];
}

+ (void)view:(UIView *)view height:(CGFloat)constant relatedBy:(NSLayoutRelation)relation {
    [self view:view height:constant relatedBy:relation
            to:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0];
}

+ (void)view:(UIView *)view height:(CGFloat)constant relatedBy:(NSLayoutRelation)relation
          to:(UIView *)toView attribute:(NSLayoutAttribute)attribute
            multiplier:(CGFloat)multiplier {
    [self view:view firstAttribute:NSLayoutAttributeHeight
            to:toView secondAttribute:attribute
      relation:relation multiplier:multiplier constant:constant];
}

#pragma mark - Constraints (CenterX)

+ (void)view:(UIView *)view centerXTo:(UIView *)toView {
    [self view:view centerXTo:toView attribute:NSLayoutAttributeCenterX];
}

+ (void)view:(UIView *)view centerXTo:(UIView *)toView attribute:(NSLayoutAttribute)attribute {
    if (!view || !view.superview) {
        return;
    }
    [self view:view firstAttribute:NSLayoutAttributeCenterX
            to:(toView? toView : view.superview) secondAttribute:attribute
      relation:NSLayoutRelationEqual multiplier:1.0 constant:0];
}

#pragma mark - Constraints (CenterY)

+ (void)view:(UIView *)view centerYTo:(UIView *)toView {
    [self view:view centerYTo:toView attribute:NSLayoutAttributeCenterY];
}

+ (void)view:(UIView *)view centerYTo:(UIView *)toView attribute:(NSLayoutAttribute)attribute {
    if (!view || !view.superview) {
        return;
    }
    [self view:view firstAttribute:NSLayoutAttributeCenterY
            to:(toView? toView : view.superview) secondAttribute:attribute
      relation:NSLayoutRelationEqual multiplier:1.0 constant:0];
}

#pragma mark - Constraints (Common)

+ (void)view:(UIView *)view firstAttribute:(NSLayoutAttribute)firstAttribute
          to:(UIView *)toView secondAttribute:(NSLayoutAttribute)secondAttribute
    relation:(NSLayoutRelation)relation multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
    NSLayoutConstraint *constraint = [self constrint:view
                                           attribute:firstAttribute
                                            relation:relation
                                                  to:toView];
    if (constraint) {
        constraint.constant = constant;
    }
    else {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        constraint = [NSLayoutConstraint constraintWithItem:view
                                                  attribute:firstAttribute
                                                  relatedBy:relation
                                                     toItem:toView
                                                  attribute:secondAttribute
                                                 multiplier:multiplier
                                                   constant:constant];
        [self addConstraint:constraint view:view to:toView];
    }
}

#pragma mark - Update

+ (void)update:(UIView *)view attribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant {
    for (NSLayoutConstraint *constraint in view.allConstraints) {
        if (constraint.firstItem == view && constraint.firstAttribute == attribute) {
            constraint.constant = constant;
        }
    }
}

+ (void)remove:(UIView *)view attribute:(NSLayoutAttribute)attribute {
    for (NSLayoutConstraint *constraint in view.allConstraints) {
        if (constraint.firstItem == view && constraint.firstAttribute == attribute) {
            // remove does not take effect to allConstraints, do not care about array issue
            [constraint remove];
        }
    }
}

#pragma mark - Constaints (Remove)

+ (void)removeAllConstraintsFromParent:(UIView *)view {
    NSArray<NSLayoutConstraint *> *allConstraints = view.allConstraints;
    for (NSLayoutConstraint *constraint in allConstraints) {
        // Constraint owner is not view, must be view's parent in hierarchy
        if (constraint.owner != view) {
            if (constraint.firstItem == view || constraint.secondItem == view) {
                // remove does not take effect to allConstraints, do not care about array issue
                [constraint remove];
            }
        }
    }
}

#pragma mark - Constraints (Getters)

+ (NSLayoutConstraint *)constrint:(UIView *)view
                        attribute:(NSLayoutAttribute)attribute
                         relation:(NSLayoutRelation)relation
                               to:(UIView *)toView {
    NSArray<NSLayoutConstraint *> *allConstraints = view.allConstraints;
    for (NSLayoutConstraint *constraint in allConstraints) {
        if (constraint.firstItem == view &&
            constraint.firstAttribute == attribute &&
            constraint.relation == relation) {
            return constraint;
        }
    }
    return nil;
}

#pragma mark - Constraints (Add)

// Add constraint for view related to view
+ (void)addConstraint:(NSLayoutConstraint *)constraint view:(UIView *)view to:(UIView *)toView {
    if (!toView) {
        [view addConstraint:constraint];return;
    }
    if (toView.superview == view.superview || toView == view.superview) {
        [view.superview addConstraint:constraint];return;
    }
    
    UIView *item = [view closestSuperview:toView];
    if (item) {
        [item addConstraint:constraint];return;
    }
    
    item = [toView closestSuperview:view];
    if (item) {
        [item addConstraint:constraint];
    }
}

@end
