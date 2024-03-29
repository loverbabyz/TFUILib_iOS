//
//  TFHubView.m
//  demo
//
//  Created by Daniel on 16/3/3.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFHubView.h"

#import <QuartzCore/QuartzCore.h>

CGFloat const RKNotificationHubDefaultDiameter = 30;
static CGFloat const kCountMagnitudeAdaptationRatio = 0.3;

static CGFloat const kPopStartRatio = .85;
static CGFloat const kPopOutRatio = 1.05;
static CGFloat const kPopInRatio = .95;

static CGFloat const kBlinkDuration = 0.1;
static CGFloat const kBlinkAlpha = 0.1;

static CGFloat const kFirstBumpDistance = 8.0;
static CGFloat const kBumpTimeSeconds = 0.13;
static CGFloat const SECOND_BUMP_DIST = 4.0;
static CGFloat const kBumpTimeSeconds2 = 0.1;

@interface RKView : UIView

@property (nonatomic) BOOL isUserChangingBackgroundColor;

@end

@implementation RKView

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (self.isUserChangingBackgroundColor)
    {
        super.backgroundColor = backgroundColor;
        self.isUserChangingBackgroundColor = NO;
    }
}

@end


@implementation TFHubView
{
    int curOrderMagnitude;
    UILabel *countLabel;
    RKView *redCircle;
    CGPoint initialCenter;
    CGRect baseFrame;
    CGRect initialFrame;
    BOOL isIndeterminateMode;
}

@synthesize hubView;

#pragma mark - SETUP

- (id)initWithView:(UIView *)view
{
    self = [super init];
    if (!self) return nil;
    
    [self setView:view andCount:0];
    
    return self;
}

- (id)initWithBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self = [self initWithView:[barButtonItem valueForKey:@"view"]];
    [self scaleCircleBySize:0.7];
    [self moveCircleByX:-5.0 Y:0];
    
    return self;
}

- (void)setView:(UIView *)view andCount:(NSUInteger)startCount
{
    curOrderMagnitude = 0;
    
    CGRect frame = view.frame;
    
    isIndeterminateMode = NO;
    
    redCircle = [[RKView alloc]init];
    redCircle.userInteractionEnabled = NO;
    redCircle.isUserChangingBackgroundColor = YES;
    redCircle.backgroundColor = [UIColor redColor];
    
    countLabel = [[UILabel alloc]initWithFrame:redCircle.frame];
    countLabel.userInteractionEnabled = NO;
    self.count = startCount;
    [countLabel setTextAlignment:NSTextAlignmentCenter];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.backgroundColor = [UIColor clearColor];
    
    [self setCircleFrame:CGRectMake(frame.size.width- (RKNotificationHubDefaultDiameter*2/3), -RKNotificationHubDefaultDiameter/3, RKNotificationHubDefaultDiameter, RKNotificationHubDefaultDiameter)];
    
    [view addSubview:redCircle];
    [view addSubview:countLabel];
    [view bringSubviewToFront:redCircle];
    [view bringSubviewToFront:countLabel];
    hubView = view;
    [self checkZero];
}

- (void)setCircleFrame:(CGRect)frame
{
    [redCircle setFrame:frame];
    initialCenter = CGPointMake(frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    baseFrame = frame;
    initialFrame = frame;
    countLabel.frame = redCircle.frame;
    redCircle.layer.cornerRadius = frame.size.height/2;
    [countLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:frame.size.width/2]];
    [self expandToFitLargerDigits];
}

- (void)moveCircleByX:(CGFloat)x Y:(CGFloat)y
{
    CGRect frame = redCircle.frame;
    frame.origin.x += x;
    frame.origin.y += y;
    [self setCircleFrame:frame];
}

- (void)scaleCircleBySize:(CGFloat)scale
{
    CGRect fr = initialFrame;
    CGFloat width = fr.size.width * scale;
    CGFloat height = fr.size.height * scale;
    CGFloat wdiff = (fr.size.width - width) / 2;
    CGFloat hdiff = (fr.size.height - height) / 2;
    
    CGRect frame = CGRectMake(fr.origin.x + wdiff, fr.origin.y + hdiff, width, height);
    [self setCircleFrame:frame];
}

- (void)setCircleColor:(UIColor*)circleColor textColor:(UIColor*)textColor
{
    redCircle.isUserChangingBackgroundColor = YES;
    redCircle.backgroundColor = circleColor;
    [countLabel setTextColor:textColor];
}

- (void)hideCount
{
    countLabel.hidden = YES;
    isIndeterminateMode = YES;
}

- (void)showCount
{
    isIndeterminateMode = NO;
    [self checkZero];
}

#pragma mark - ATTRIBUTES

- (void)increment
{
    [self incrementBy:1];
}

- (void)incrementBy:(NSUInteger)amount
{
    self.count += amount;
}

- (void)decrement
{
    [self decrementBy:1];
}

- (void)decrementBy:(NSUInteger)amount
{
    if (amount >= self.count) {
        self.count = 0;
        return;
    }
    self.count -= amount;
}

- (void)setCount:(NSUInteger)newCount
{
    _count = newCount;
    countLabel.text = [NSString stringWithFormat:@"%@", @(self.count)];
    [self checkZero];
    [self expandToFitLargerDigits];
}

- (void)setFont:(UIFont *)font
{
    [countLabel setFont:[UIFont fontWithName:font.fontName size:redCircle.frame.size.width/2]];
}

- (UIFont *)font
{
    return countLabel.font;
}

#pragma mark - ANIMATION

- (void)pop
{
    const float height = baseFrame.size.height;
    const float width = baseFrame.size.width;
    const float pop_start_h = height * kPopStartRatio;
    const float pop_start_w = width * kPopStartRatio;
    const float time_start = 0.05;
    const float pop_out_h = height * kPopOutRatio;
    const float pop_out_w = width * kPopOutRatio;
    const float time_out = .2;
    const float pop_in_h = height * kPopInRatio;
    const float pop_in_w = width * kPopInRatio;
    const float time_in = .05;
    const float pop_end_h = height;
    const float pop_end_w = width;
    const float time_end = 0.05;
    
    CABasicAnimation *startSize = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    startSize.duration = time_start;
    startSize.beginTime = 0;
    startSize.fromValue = @(pop_end_h / 2);
    startSize.toValue = @(pop_start_h / 2);
    startSize.removedOnCompletion = FALSE;
    
    CABasicAnimation *outSize = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    outSize.duration = time_out;
    outSize.beginTime = time_start;
    outSize.fromValue = startSize.toValue;
    outSize.toValue = @(pop_out_h / 2);
    outSize.removedOnCompletion = FALSE;
    
    CABasicAnimation *inSize = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    inSize.duration = time_in;
    inSize.beginTime = time_start+time_out;
    inSize.fromValue = outSize.toValue;
    inSize.toValue = @(pop_in_h / 2);
    inSize.removedOnCompletion = FALSE;
    
    CABasicAnimation *endSize = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    endSize.duration = time_end;
    endSize.beginTime = time_in+time_out+time_start;
    endSize.fromValue = inSize.toValue;
    endSize.toValue = @(pop_end_h / 2);
    endSize.removedOnCompletion = FALSE;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setDuration: time_start+time_out+time_in+time_end];
    [group setAnimations:@[startSize, outSize, inSize, endSize]];
    
    [redCircle.layer addAnimation:group forKey:nil];
    
    [UIView animateWithDuration:time_start animations:^{
        CGRect frame = self->redCircle.frame;
        CGPoint center = self->redCircle.center;
        frame.size.height = pop_start_h;
        frame.size.width = pop_start_w;
        self->redCircle.frame = frame;
        self->redCircle.center = center;
    }completion:^(BOOL complete){
        [UIView animateWithDuration:time_out animations:^{
            CGRect frame = self->redCircle.frame;
            CGPoint center = self->redCircle.center;
            frame.size.height = pop_out_h;
            frame.size.width = pop_out_w;
            self->redCircle.frame = frame;
            self->redCircle.center = center;
        }completion:^(BOOL complete){
            [UIView animateWithDuration:time_in animations:^{
                CGRect frame = self->redCircle.frame;
                CGPoint center = self->redCircle.center;
                frame.size.height = pop_in_h;
                frame.size.width = pop_in_w;
                self->redCircle.frame = frame;
                self->redCircle.center = center;
            }completion:^(BOOL complete){
                [UIView animateWithDuration:time_end animations:^{
                    CGRect frame = self->redCircle.frame;
                    CGPoint center = self->redCircle.center;
                    frame.size.height = pop_end_h;
                    frame.size.width = pop_end_w;
                    self->redCircle.frame = frame;
                    self->redCircle.center = center;
                }];
            }];
        }];
    }];
}

- (void)blink
{
    [self setAlpha:kBlinkAlpha];
    
    [UIView animateWithDuration:kBlinkDuration animations:^{
        [self setAlpha:1];
    }completion:^(BOOL complete){
        [UIView animateWithDuration:kBlinkDuration animations:^{
            [self setAlpha:kBlinkAlpha];
        }completion:^(BOOL complete){
            [UIView animateWithDuration:kBlinkDuration animations:^{
                [self setAlpha:1];
            }];
        }];
    }];
}

- (void)bump
{
    if (!CGPointEqualToPoint(initialCenter,redCircle.center))
    {
        //%%% canel previous animation
    }
    
    [self bumpCenterY:0];
    [UIView animateWithDuration:kBumpTimeSeconds animations:^{
        [self bumpCenterY:kFirstBumpDistance];
    }completion:^(BOOL complete){
        [UIView animateWithDuration:kBumpTimeSeconds animations:^{
            [self bumpCenterY:0];
        }completion:^(BOOL complete){
            [UIView animateWithDuration:kBumpTimeSeconds2 animations:^{
                [self bumpCenterY:SECOND_BUMP_DIST];
            }completion:^(BOOL complete){
                [UIView animateWithDuration:kBumpTimeSeconds2 animations:^{
                    [self bumpCenterY:0];
                }];
            }];
        }];
    }];
}

#pragma mark - HELPERS

- (void)bumpCenterY:(float)yVal
{
    CGPoint center = redCircle.center;
    center.y = initialCenter.y-yVal;
    redCircle.center = center;
    countLabel.center = center;
}

- (void)setAlpha:(float)alpha
{
    redCircle.alpha = alpha;
    countLabel.alpha = alpha;
}

- (void)checkZero
{
    if (self.count <= 0)
    {
        redCircle.hidden = YES;
        countLabel.hidden = YES;
    }
    else
    {
        redCircle.hidden = NO;
        if (!isIndeterminateMode)
        {
            countLabel.hidden = NO;
        }
    }
}

- (void)expandToFitLargerDigits
{
    int orderOfMagnitude = log10((double)self.count);
    orderOfMagnitude = (orderOfMagnitude >= 2) ? orderOfMagnitude : 1;
    CGRect frame = initialFrame;
    frame.size.width = initialFrame.size.width * (1 + kCountMagnitudeAdaptationRatio * (orderOfMagnitude - 1));
    frame.origin.x = initialFrame.origin.x - (frame.size.width - initialFrame.size.width) / 2;
    
    [redCircle setFrame:frame];
    initialCenter = CGPointMake(frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    baseFrame = frame;
    countLabel.frame = redCircle.frame;
    curOrderMagnitude = orderOfMagnitude;
}

@end

