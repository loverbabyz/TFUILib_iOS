//
//  TFPopoverView.m
//  TFUILib
//
//  Created by Daniel on 16/4/7.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFPopoverView.h"

#define DEGREES_TO_RADIANS(degrees) ((3.14159265359 * degrees) / 180)

@interface TFPopoverView()

@property (nonatomic, strong, readwrite) UIControl *blackOverlay;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign, readwrite) TFPopoverViewPosition popoverPosition;
@property (nonatomic, assign) CGPoint arrowShowPoint;
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, assign) CGRect contentViewFrame;
@property (nonatomic, strong) UIColor *contentColor;
@property (nonatomic, assign) CGFloat betweenAtViewAndArrowHeight;
@property (nonatomic, assign) CGFloat sideEdge;

@end

@implementation TFPopoverView

{
    BOOL _setNeedsReset;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self commonInit];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self commonInit];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInit];
    }

    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *arrow = [[UIBezierPath alloc] init];
    UIColor *contentColor = self.contentColor;
    // the point in the ourself view coordinator
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    CGSize arrowSize = self.arrowSize;
    CGFloat cornerRadius = self.cornerRadius;
    CGSize size = self.bounds.size;
    
    switch (self.popoverPosition)
    {
        case kPopoverViewPositionDown:
        {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, 0)];
            [arrow
             addLineToPoint:CGPointMake(arrowPoint.x + arrowSize.width * 0.5, arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius,
                                                arrowSize.height + cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(270.0)
                           endAngle:DEGREES_TO_RADIANS(0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width, size.height - cornerRadius)];
            [arrow
             addArcWithCenter:CGPointMake(size.width - cornerRadius, size.height - cornerRadius)
             radius:cornerRadius
             startAngle:DEGREES_TO_RADIANS(0)
             endAngle:DEGREES_TO_RADIANS(90.0)
             clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, size.height)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, size.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(90)
                           endAngle:DEGREES_TO_RADIANS(180.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, arrowSize.height + cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, arrowSize.height + cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(180.0)
                           endAngle:DEGREES_TO_RADIANS(270)
                          clockwise:YES];
            [arrow
             addLineToPoint:CGPointMake(arrowPoint.x - arrowSize.width * 0.5, arrowSize.height)];
        }
            break;
        case kPopoverViewPositionUp:
        {
            [arrow moveToPoint:CGPointMake(arrowPoint.x, size.height)];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x - arrowSize.width * 0.5,
                                              size.height - arrowSize.height)];
            [arrow addLineToPoint:CGPointMake(cornerRadius, size.height - arrowSize.height)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius,
                                                size.height - arrowSize.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(90.0)
                           endAngle:DEGREES_TO_RADIANS(180.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(0, cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(cornerRadius, cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(180.0)
                           endAngle:DEGREES_TO_RADIANS(270.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width - cornerRadius, 0)];
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius, cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(270.0)
                           endAngle:DEGREES_TO_RADIANS(0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(size.width,
                                              size.height - arrowSize.height - cornerRadius)];
            [arrow addArcWithCenter:CGPointMake(size.width - cornerRadius,
                                                size.height - arrowSize.height - cornerRadius)
                             radius:cornerRadius
                         startAngle:DEGREES_TO_RADIANS(0)
                           endAngle:DEGREES_TO_RADIANS(90.0)
                          clockwise:YES];
            [arrow addLineToPoint:CGPointMake(arrowPoint.x + arrowSize.width * 0.5,
                                              size.height - arrowSize.height)];
        }
            break;
    }
    [contentColor setFill];
    [arrow fill];
}

- (void)layoutSubviews
{
    if (_setNeedsReset == NO)
    {
        return;
    }
    
    CGRect frame = self.contentViewFrame;
    
    CGFloat frameMidx = self.arrowShowPoint.x - CGRectGetWidth(frame) * 0.5;
    frame.origin.x = frameMidx;
    
    // we don't need the edge now
    CGFloat sideEdge = 0.0;
    if (CGRectGetWidth(frame) < CGRectGetWidth(self.containerView.frame))
    {
        sideEdge = self.sideEdge;
    }
    
    // righter the edge
    CGFloat outerSideEdge = CGRectGetMaxX(frame) - CGRectGetWidth(self.containerView.bounds);
    if (outerSideEdge > 0)
    {
        frame.origin.x -= (outerSideEdge + sideEdge);
    }
    else
    {
        if (CGRectGetMinX(frame) < 0)
        {
            frame.origin.x += ABS(CGRectGetMinX(frame)) + sideEdge;
        }
    }
    
    self.frame = frame;
    
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    
    CGPoint anchorPoint;
    switch (self.popoverPosition)
    {
        case kPopoverViewPositionDown:
        {
            frame.origin.y = self.arrowShowPoint.y;
            anchorPoint = CGPointMake(arrowPoint.x / CGRectGetWidth(frame), 0);
        } break;
        case kPopoverViewPositionUp:
        {
            frame.origin.y = self.arrowShowPoint.y - CGRectGetHeight(frame) - self.arrowSize.height;
            anchorPoint = CGPointMake(arrowPoint.x / CGRectGetWidth(frame), 1);
        } break;
    }
    
    CGPoint lastAnchor = self.layer.anchorPoint;
    self.layer.anchorPoint = anchorPoint;
    self.layer.position = CGPointMake(
                                      self.layer.position.x + (anchorPoint.x - lastAnchor.x) * self.layer.bounds.size.width,
                                      self.layer.position.y + (anchorPoint.y - lastAnchor.y) * self.layer.bounds.size.height);
    
    frame.size.height += self.arrowSize.height;
    self.frame = frame;
    _setNeedsReset = NO;
}

#pragma mark- atpoint method

- (void)showAtPoint:(CGPoint)point
             inView:(UIView *)containerView
    withContentView:(UIView *)contentView
     popoverPostion:(TFPopoverViewPosition)position
{
    CGFloat contentWidth = CGRectGetWidth(contentView.bounds);
    CGFloat contentHeight = CGRectGetHeight(contentView.bounds);
    CGFloat containerWidth = CGRectGetWidth(containerView.bounds);
    CGFloat containerHeight = CGRectGetHeight(containerView.bounds);

    NSAssert(contentWidth > 0 && contentHeight > 0,
             @"DXPopover contentView bounds.size should not be zero");
    NSAssert(containerWidth > 0 && containerHeight > 0,
             @"DXPopover containerView bounds.size should not be zero");
    NSAssert(containerWidth >= (contentWidth + self.contentInset.left + self.contentInset.right),
             @"DXPopover containerView width %f should be wider than contentViewWidth %f & "
             @"contentInset %@",
             containerWidth, contentWidth, NSStringFromUIEdgeInsets(self.contentInset));

    if (!self.blackOverlay)
    {
        self.blackOverlay = [[UIControl alloc] init];
        self.blackOverlay.autoresizingMask =
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    self.blackOverlay.frame = containerView.bounds;

    UIColor *maskColor;
    switch (self.maskType)
    {
        case kPopoverViewrMaskTypeBlack:
            maskColor = [UIColor colorWithWhite:0.0 alpha:0.3];
            break;
        case kPopoverViewMaskTypeNone:
        {
            maskColor = [UIColor clearColor];
            self.blackOverlay.userInteractionEnabled = YES;
        }
            break;
        default:
            break;
    }

    self.blackOverlay.backgroundColor = maskColor;

    [containerView addSubview:self.blackOverlay];
    [self.blackOverlay addTarget:self
                          action:@selector(dismiss)
                forControlEvents:UIControlEventTouchUpInside];

    self.containerView = containerView;
    self.contentView = contentView;
    self.popoverPosition = position;
    self.arrowShowPoint = point;

    CGRect contentFrame = [containerView convertRect:contentView.frame toView:containerView];
    BOOL isEdgeZero = UIEdgeInsetsEqualToEdgeInsets(self.contentInset, UIEdgeInsetsZero);
    // if the edgeInset is not be setted, we use need set the contentViews cornerRadius
    if (isEdgeZero)
    {
        self.contentView.layer.cornerRadius = self.cornerRadius;
        self.contentView.layer.masksToBounds = YES;
    }
    else
    {
        contentFrame.size.width += self.contentInset.left + self.contentInset.right;
        contentFrame.size.height += self.contentInset.top + self.contentInset.bottom;
    }

    self.contentViewFrame = contentFrame;

    [self show];
}

- (void)showAtPoint:(CGPoint)point
             inView:(UIView *)containerView
           withText:(NSAttributedString *)text
     popoverPostion:(TFPopoverViewPosition)position
{
    UILabel *textLabel = [UILabel new];
    textLabel.attributedText = text;
    [textLabel sizeToFit];
    textLabel.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0);
    [self showAtPoint:point inView:containerView withContentView:textLabel popoverPostion:position];
}

- (void)showAtPoint:(CGPoint)point
             inView:(UIView *)containerView
    withContentView:(UIView *)contentView
{
    [self showAtPoint:(CGPoint)point
               inView:containerView
      withContentView:contentView
       popoverPostion:kPopoverViewPositionDown];
}

- (void)showAtPoint:(CGPoint)point
             inView:(UIView *)containerView
    withText:(NSAttributedString *)text
{
    [self showAtPoint:(CGPoint)point
               inView:containerView
      withText:text
       popoverPostion:kPopoverViewPositionDown];
}

#pragma mark- atview method

- (void)showAtView:(UIView *)atView
inView:(UIView *)containerView
   withContentView:(UIView *)contentView
    popoverPostion:(TFPopoverViewPosition)position
{
    CGFloat betweenArrowAndAtView = self.betweenAtViewAndArrowHeight;
    CGFloat contentViewHeight = CGRectGetHeight(contentView.bounds);
    CGRect atViewFrame = [containerView convertRect:atView.frame toView:containerView];

    BOOL upCanContain = CGRectGetMinY(atViewFrame) >= contentViewHeight + betweenArrowAndAtView;
    BOOL downCanContain =
    (CGRectGetHeight(containerView.bounds) -
     (CGRectGetMaxY(atViewFrame) + betweenArrowAndAtView)) >= contentViewHeight;
    NSAssert((upCanContain || downCanContain),
             @"DXPopover no place for the popover show, check atView frame %@ "
             @"check contentView bounds %@ and containerView's bounds %@",
             NSStringFromCGRect(atViewFrame), NSStringFromCGRect(contentView.bounds),
             NSStringFromCGRect(containerView.bounds));

    CGPoint atPoint = CGPointMake(CGRectGetMidX(atViewFrame), 0);
    TFPopoverViewPosition popoverPosition;
    if (upCanContain)
    {
        popoverPosition = kPopoverViewPositionUp;
        atPoint.y = CGRectGetMinY(atViewFrame) - betweenArrowAndAtView;
    }
    else
    {
        popoverPosition = kPopoverViewPositionDown;
        atPoint.y = CGRectGetMaxY(atViewFrame) + betweenArrowAndAtView;
    }

    // if they are all yes then it shows in the bigger container
    if (upCanContain && downCanContain)
    {
        CGFloat upHeight = CGRectGetMinY(atViewFrame);
        CGFloat downHeight = CGRectGetHeight(containerView.bounds) - CGRectGetMaxY(atViewFrame);
        BOOL useUp = upHeight > downHeight;

        // except you set outsider
        if (position != 0)
        {
            useUp = position == kPopoverViewPositionUp ? YES : NO;
        }
        if (useUp)
        {
            popoverPosition = kPopoverViewPositionUp;
            atPoint.y = CGRectGetMinY(atViewFrame) - betweenArrowAndAtView;
        }
        else
        {
            popoverPosition = kPopoverViewPositionDown;
            atPoint.y = CGRectGetMaxY(atViewFrame) + betweenArrowAndAtView;
        }
    }

    [self showAtPoint:atPoint inView:containerView withContentView:contentView popoverPostion:popoverPosition];
}

- (void)showAtView:(UIView *)atView
            inView:(UIView *)containerView
          withText:(NSAttributedString *)text
    popoverPostion:(TFPopoverViewPosition)position
{
    UILabel *textLabel = [UILabel new];
    textLabel.attributedText = text;
    [textLabel sizeToFit];
    textLabel.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsMake(3.0, 3.0, 3.0, 3.0);
    [self showAtView:atView inView:containerView withContentView:textLabel popoverPostion:position];
}

- (void)showAtView:(UIView *)atView
            inView:(UIView *)containerView
          withContentView:(UIView *)contentView
{
    [self showAtView:atView
              inView:containerView
            withContentView:contentView
      popoverPostion:kPopoverViewPositionDown];
}

- (void)showAtView:(UIView *)atView
            inView:(UIView *)containerView
          withText:(NSAttributedString *)text
{
    [self showAtView:atView
              inView:containerView
            withText:text
      popoverPostion:kPopoverViewPositionDown];
}

- (void)show
{
    _setNeedsReset = YES;
    [self setNeedsDisplay];
    
    CGRect contentViewFrame = self.contentView.frame;
    CGFloat originY = 0.0;
    if (self.popoverPosition == kPopoverViewPositionDown)
    {
        originY = self.arrowSize.height;
    }
    
    contentViewFrame.origin.x = self.contentInset.left;
    contentViewFrame.origin.y = originY + self.contentInset.top;
    
    self.contentView.frame = contentViewFrame;
    [self addSubview:self.contentView];
    [self.containerView addSubview:self];
    
    __weak typeof(self) weakSelf = self;
    
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    if (self.animationSpring)
    {
        [UIView animateWithDuration:self.animationIn
                              delay:0
             usingSpringWithDamping:0.7
              initialSpringVelocity:3
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             weakSelf.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             if (weakSelf.didShowHandler)
                             {
                                 weakSelf.didShowHandler();
                             }
                         }];
    }
    else
    {
        [UIView animateWithDuration:self.animationIn
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             weakSelf.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             if (weakSelf.didShowHandler)
                             {
                                 weakSelf.didShowHandler();
                             }
                         }];
    }
}

- (void)dismiss
{
    __weak typeof(self) weakSelf = self;
    
    if (self.superview)
    {
        [UIView animateWithDuration:self.animationOut
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             weakSelf.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
                         }
                         completion:^(BOOL finished) {
                             [weakSelf.contentView removeFromSuperview];
                             [weakSelf.blackOverlay removeFromSuperview];
                             [self removeFromSuperview];
                             if (weakSelf.didDismissHandler)
                             {
                                 weakSelf.didDismissHandler();
                             }
                         }];
    }
}

#pragma mark- other method

- (void)commonInit
{
    self.arrowSize = CGSizeMake(15.0, 12.0);
    self.cornerRadius = 5.0;
    self.backgroundColor = [UIColor whiteColor];
    self.animationIn = 0.4;
    self.animationOut = 0.3;
    self.animationSpring = YES;
    self.sideEdge = 10.0;
    self.maskType = kPopoverViewrMaskTypeBlack;
    self.betweenAtViewAndArrowHeight = 4.0;
    self.applyShadow = YES;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:[UIColor clearColor]];
    self.contentColor = backgroundColor;
}

- (void)setApplyShadow:(BOOL)applyShadow
{
    _applyShadow = applyShadow;
    if (_applyShadow)
    {
        self.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowRadius = 2.0;
    }
    else
    {
        self.layer.shadowColor = nil;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.0;
        self.layer.shadowRadius = 0.0;
    }
}

@end
