//
//  TFPushNotificationView.m
//  TFNotifier
//
//  Created by xiayiyong on 15/5/21.
//  Copyright (c) 2015年 xiayiyong. All rights reserved.
//

#import "TFPushNotificationView.h"
#import <Accelerate/Accelerate.h>
#import <AudioToolbox/AudioToolbox.h>

@interface TFPushNotificationView ()
{
    TFPushNotificationViewTouchBlock _notifierBarClickBlock;
}

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, assign) UIEdgeInsets edge;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIImage *defaultIcon;
@property (nonatomic, strong) NSString *appName;

@end

@implementation TFPushNotificationView

+ (TFPushNotificationView*)shareInstance
{
    static dispatch_once_t onceToken;
    static TFPushNotificationView *notifier;
    dispatch_once(&onceToken, ^ {
        notifier = [[self alloc] init];
        notifier.transform = CGAffineTransformMakeTranslation(0, -notifier.frame.size.height);
    });
    return notifier;
}

#pragma --mark class method
+(TFPushNotificationView*)showWithMessageRemain:(NSString*)note block:(TFPushNotificationViewTouchBlock)block
{
    return [[self class] showWithMessageRemain:note appName:nil block:block];
}

+(TFPushNotificationView*)showWithMessageRemain:(NSString*)message
                                   appName:(NSString*)appName
                                  block:(TFPushNotificationViewTouchBlock)block
{
    return [[self class] showWithMessage:message appName:appName appIcon:nil dismissAfter:-1 block:block];
}

+(TFPushNotificationView*)showWithMessage:(NSString*)message block:(TFPushNotificationViewTouchBlock)block
{
    return [[self class] showWithMessage:message dismissAfter:2 block:block];
}

+(TFPushNotificationView*)showWithMessage:(NSString*)message
                             appName:(NSString*)appName
                             appIcon:(UIImage*)appIcon
                            block:(TFPushNotificationViewTouchBlock)block
{
    return [[self class] showWithMessage:message appName:appName appIcon:appIcon dismissAfter:2 block:block];
}

+ (TFPushNotificationView*)showWithMessage:(NSString *)message
                      dismissAfter:(NSTimeInterval)delay
                             block:(TFPushNotificationViewTouchBlock)block
{
    return [[self class] showWithMessage:message appName:nil appIcon:nil dismissAfter:delay block:block];
}

+(TFPushNotificationView*)showWithMessage:(NSString*)message
                             appName:(NSString*)appName
                             appIcon:(UIImage*)appIcon
                     dismissAfter:(NSTimeInterval)delay
                            block:(TFPushNotificationViewTouchBlock)block
{
    TFPushNotificationView *bar =  [[self shareInstance] showWithMessage:message
                                                            name:appName?:[self shareInstance].appName
                                                            icon:appIcon?:[self shareInstance].defaultIcon
                                                           block:block];
    [[self class] dismissAfter:delay];
    
    return bar;
}

+ (void)dismiss
{
    [[self shareInstance] dismiss];
}

+ (void)dismissAfter:(NSTimeInterval)delay;
{
    if(delay<0)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:[self shareInstance]  selector:@selector(dismiss) object:nil];
    }
    else
    {
        [[self shareInstance] performSelector:@selector(dismiss) withObject:nil afterDelay:delay];
    }
}

#pragma --mark init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.windowLevel = UIWindowLevelStatusBar + 1.0;
        self.hidden = NO;
        self.autoresizesSubviews = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.800];
        
        UIApplication *sharedApplication = [UIApplication sharedApplication];
        self.frame = sharedApplication.statusBarFrame;
        
        [self addSubview:self.iconView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailLabel];
    }
    return self;
}

#pragma --mark getter setter
-(UIFont *)font
{
    if (!_font)
    {
        _font =[UIFont systemFontOfSize:14.0];
    }
    return _font;
}

-(UIEdgeInsets)edge
{
    return  UIEdgeInsetsMake(8.0, 50.0, 20.0, 5.0);
}

- (UIImageView *)iconView;
{
    if (!_iconView)
    {
        _iconView = [[UIImageView alloc] initWithFrame:self.bounds];
        _iconView.clipsToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel;
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = self.font;
        _nameLabel.textAlignment = NSTextAlignmentJustified;
        _nameLabel.clipsToBounds = YES;
        _nameLabel.numberOfLines = 2;

    }
    return _nameLabel;
}

- (UILabel *)detailLabel;
{
    if (!_detailLabel)
    {
        _detailLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _detailLabel.textColor = [UIColor whiteColor];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.font = self.font;
        _detailLabel.textAlignment = NSTextAlignmentJustified;
        _detailLabel.clipsToBounds = YES;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_notifierBarClickBlock)
    {
        _notifierBarClickBlock(self.nameLabel.text?:@"",self.detailLabel.text?:@"",[TFPushNotificationView shareInstance]);
    }
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath  *round = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((CGRectGetWidth(self.frame)-35)/2, CGRectGetHeight(self.frame)-12, 35, 5) byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(10, 10)];
    [[UIColor lightGrayColor] setFill];
    [round fill];
}

-(void)show:(NSString*)message appName:(NSString*)appName appIcon:(UIImage*)appIcon block:(TFPushNotificationViewTouchBlock)block
{
    self.nameLabel.text = appName;
    self.detailLabel.text = message;
    self.iconView.image = appIcon;
    
    self.iconView.frame = CGRectMake(15, 7, 20, 20);
    
    CGFloat nameLabelHeight  =  MIN(40, [self heightWithString:appName fontSize:self.font.pointSize width:CGRectGetWidth(self.frame)-self.edge.left-self.edge.right]);
    self.nameLabel.frame = CGRectMake(self.edge.left, self.edge.top, CGRectGetWidth(self.frame)-self.edge.left-self.edge.right,nameLabelHeight);

    
    CGFloat detailLabelHeight =  MIN(CGRectGetHeight([UIScreen mainScreen].bounds)-40-self.edge.bottom, [self heightWithString:message fontSize:self.font.pointSize width:CGRectGetWidth(self.frame)-self.edge.left-self.edge.right]);
    
    self.detailLabel.frame = CGRectMake(self.edge.left,
                             CGRectGetMaxY(self.nameLabel.frame),
                             CGRectGetWidth(self.frame)-self.edge.left-self.edge.right,detailLabelHeight);
    
    CGFloat selfHeight = MIN(CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetMaxY(self.detailLabel.frame)+self.edge.bottom);
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame),selfHeight);

    [self setNeedsDisplay];
    
    _notifierBarClickBlock = [block copy];
}

#pragma --instance method
-(TFPushNotificationView*)showWithMessage:(NSString*)message name:(NSString*)appName icon:(UIImage*)appIcon block:(TFPushNotificationViewTouchBlock)block
{
    TFPushNotificationView *notifierBar=[TFPushNotificationView shareInstance];
    [notifierBar.layer removeAllAnimations];
    notifierBar.userInteractionEnabled = YES;
    
    AudioServicesPlaySystemSound(1007);
    
    [notifierBar show:message appName:appName appIcon:appIcon block:block];
    [UIView animateWithDuration:(0.4)
                     animations:^{
                         notifierBar.alpha = 1.0;
                         notifierBar.transform = CGAffineTransformIdentity;
                     }];
    return notifierBar;
}

- (void)dismiss
{
    [[NSRunLoop currentRunLoop] cancelPerformSelector:@selector(dismiss) target:self argument:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    
    TFPushNotificationView *notifierBar=[TFPushNotificationView shareInstance];
    [UIView animateWithDuration:0.4
                     animations:^{
                         notifierBar.transform = CGAffineTransformMakeTranslation(0, -notifierBar.frame.size.height);
                     } completion:^(BOOL finished) {
                         notifierBar.userInteractionEnabled = NO;
                     }];
}

#pragma --mark helper

-(NSString*)appName
{
    if (!_appName)
    {
        _appName =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]?:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    }
    return _appName;
}

-(UIImage*)defaultIcon
{
    if (!_defaultIcon)
    {
        NSString *bundlePath = [[NSBundle bundleForClass:self.class] pathForResource:@"TFPushNotificationView" ofType:@"bundle"];
        NSString *defaultImagePath = [bundlePath stringByAppendingPathComponent:@"TFNotifier_default_icon@2x.png"];
        UIImage *defaultImage = [UIImage imageWithContentsOfFile:defaultImagePath];
        _defaultIcon = [self loadPlistIcon];
        if (_defaultIcon==nil)
        {
            _defaultIcon=defaultImage;
        };
    }
    return _defaultIcon;
}

- (CGFloat)widthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}

- (CGFloat)heightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}

-(UIImage*)loadPlistIcon
{
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage *shareImage = [UIImage imageNamed:icon];
    
    return shareImage;
}

@end
