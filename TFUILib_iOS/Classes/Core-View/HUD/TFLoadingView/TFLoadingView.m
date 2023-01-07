//
//  TFLoadingView.m
//  TFUILib
//
//  Created by Daniel on 16/4/15.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFLoadingView.h"

#define GAP 5
#define ALERT_TEXT_WIDTH 200.f

@interface TFLoadingView()

/**
 *  指示器
 */
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

/**
 *  提示Label
 */
@property(nonatomic, strong) UILabel *textLabel;

@end

@implementation TFLoadingView

+ (void) showWithText:(NSString *)text
activityIndicatorViewStyle:(UIActivityIndicatorViewStyle)indicatorStyle
               atView:(UIView *)atView
              offsetY:(CGFloat)offsetY
{
    TFLoadingView *loadingView=[[TFLoadingView alloc]initWithText:text activityIndicatorViewStyle:indicatorStyle];
    [atView addSubview:loadingView];
    loadingView.center = CGPointMake(atView.center.x, atView.center.y+offsetY);
}

/**
 *  隐藏
 */
+(void)hideAtView:(UIView *)atView
{
    for (UIView *viewTemp in atView.subviews)
    {
        if([viewTemp isKindOfClass:[TFLoadingView class]])
        {
            TFLoadingView *vv = (TFLoadingView *)viewTemp;
            [vv hide];
        }
    }
}

- (instancetype) initWithText:(NSString *)text activityIndicatorViewStyle:(UIActivityIndicatorViewStyle)indicatorStyle
{
    self = [super initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    if (self)
    {
        //loadView
        self.backgroundColor = [UIColor clearColor];
        
        //indicator
        if (!indicatorStyle)
        {
            self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        }
        
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:indicatorStyle];
        [self.activityIndicatorView startAnimating];
        
        //alertText
        self.textLabel           = [[UILabel alloc] init];
        self.textLabel.tag       = 1;
        self.textLabel.text      = text!=nil?text:@"";
        self.textLabel.textColor = [UIColor lightGrayColor];

        [self addSubview:self.activityIndicatorView];
        [self addSubview:self.textLabel];
        
        [self.textLabel sizeToFit];
        if (self.textLabel.frame.size.width > ALERT_TEXT_WIDTH)
        {
            self.textLabel.numberOfLines = (NSInteger)ceilf(self.textLabel.frame.size.width/ALERT_TEXT_WIDTH);
            
            self.textLabel.frame = CGRectMake(0, 0, ALERT_TEXT_WIDTH, self.textLabel.frame.size.width*(NSInteger)ceilf(self.textLabel.frame.size.width/ALERT_TEXT_WIDTH));
            
            [self.textLabel sizeToFit];
        }
        
        //layout
        self.activityIndicatorView.frame = CGRectMake(GAP, self.center.y-(self.activityIndicatorView.frame.size.height/2), self.activityIndicatorView.frame.size.width + GAP, self.activityIndicatorView.frame.size.height + GAP);
        
        self.textLabel.frame = CGRectMake(self.activityIndicatorView.frame.size.width + GAP, self.center.y-(self.textLabel.frame.size.height/2), self.textLabel.frame.size.width, self.textLabel.frame.size.height);
        
        CGFloat width = self.activityIndicatorView.frame.size.width + self.textLabel.frame.size.width + GAP;
        self.frame = CGRectMake(0, 0, width, width);
        
        // background
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        [self sendSubviewToBack:effectView];
        
        self.cornerRadius = 5.0;   
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)showAtView:(UIView *)atView;
{
    [atView addSubview:self];
}

-(void)hide
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         weakSelf.alpha = 0.f;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}
@end

