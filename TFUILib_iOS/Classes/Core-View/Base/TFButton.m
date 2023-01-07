//
//  TFButton.m
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFButton.h"

#define BORDERWIDTH (1.0) // 边框宽度

#define HEXCOLORINBUTTON(c,a)  [UIColor colorWithRed:((c>>16)&0xFF)/255.0 \
green:((c>>8)&0xFF)/255.0 \
blue:(c&0xFF)/255.0 \
alpha:a]

#define kImageWithName(Name) ([UIImage imageNamed:Name])

#define kBigImageWithName(Name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:Name ofType:nil]])

//    获得按钮的大小
#define fl_btnWidth self.bounds.size.width
#define fl_btnHeight self.bounds.size.height

//    获得按钮中UILabel文本的大小
#define fl_labelWidth self.titleLabel.bounds.size.width
#define fl_labelHeight self.titleLabel.bounds.size.height

//    获得按钮中image图标的大小
#define fl_imageWidth self.imageView.bounds.size.width
#define fl_imageHeight self.imageView.bounds.size.height



@interface TFButton()

/**
 *  点击事件
 */
@property (nonatomic, copy)void(^actionBlock)(void);

/**
 *  长按事件
 */
@property (nonatomic, copy)void(^longPressBlock)(void);

@end

@implementation TFButton

#pragma mark - functions

- (instancetype)initWithFrame:(CGRect)frame alignmentStatus:(TFAlignmentStatus)status
{
    if (self = [super initWithFrame:frame])
    {
        _gapLeft = 10;
        _gapBetween = 10;
        _status = status;
        
        // 点击事件
        [self addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        
        //button长按事件
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        
        //定义按的时间
        longPress.minimumPressDuration = 0.8;
        [self addGestureRecognizer:longPress];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _gapLeft = 0;
        _gapBetween = 10;
        _status = TFAlignmentStatusNormal;
        [self addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame alignmentStatus:TFAlignmentStatusNormal];
    
    return self;
}

-(void)setGapBetween:(CGFloat)gapBetween
{
    _gapBetween = gapBetween;
    
    [self layoutSubviews];
}

- (void)setGapLeft:(CGFloat)gapLeft {
    _gapLeft = gapLeft;
    
    [self layoutSubviews];
}

- (void)setStatus:(TFAlignmentStatus)status
{
    _status = status;
    
    [self layoutSubviews];
}

#pragma mark - 左对齐
- (void)alignmentLeft
{
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = self.gapLeft;
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = CGRectGetWidth(titleFrame) + self.gapBetween;
    
    //    重写赋值frame
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
    
    CGRect selfNewFrame = self.frame;
    selfNewFrame.size = CGSizeMake(self.imageView.right, self.height);
    self.frame = selfNewFrame;
}

#pragma mark - 右对齐
- (void)alignmentRight
{
    CGRect imageFrame = self.imageView.frame;
    imageFrame.origin.x = self.gapLeft;
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = CGRectGetWidth(imageFrame) + self.gapBetween;
    
    //    重写赋值frame
    self.titleLabel.frame = titleFrame;
    self.imageView.frame = imageFrame;
    
    CGRect selfNewFrame = self.frame;
    selfNewFrame.size = CGSizeMake(self.titleLabel.right, self.height);
    self.frame = selfNewFrame;
}

#pragma mark - 居中对齐
- (void)alignmentCenter
{
    //    设置文本的坐标
    CGFloat labelX = (fl_btnWidth - fl_labelWidth -fl_imageWidth - self.gapBetween) * 0.5;
    CGFloat labelY = (fl_btnHeight - fl_labelHeight) * 0.5;
    
    //    设置label的frame
    self.titleLabel.frame = CGRectMake(labelX, labelY, fl_labelWidth, fl_labelHeight);
    
    //    设置图片的坐标
    CGFloat imageX = CGRectGetMaxX(self.titleLabel.frame) + self.gapBetween;
    CGFloat imageY = (fl_btnHeight - fl_imageHeight) * 0.5;
    
    //    设置图片的frame
    self.imageView.frame = CGRectMake(imageX, imageY, fl_imageWidth, fl_imageHeight);
}

#pragma mark - 图标在上，文本在下(居中)
- (void)alignmentTop
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    //CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    self.imageView.frame = CGRectMake((fl_btnWidth - fl_imageWidth) * 0.5, (fl_btnHeight-fl_labelHeight-fl_imageHeight-self.gapBetween)*0.5, fl_imageWidth, fl_imageHeight);
    self.titleLabel.frame = CGRectMake(0, (fl_btnHeight-fl_labelHeight-fl_imageHeight-self.gapBetween)*0.5+fl_imageHeight+self.gapBetween, fl_btnWidth, fl_labelHeight);
}

#pragma mark - 图标在下，文本在上(居中)
- (void)alignmentBottom
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 计算文本的的宽度
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    // CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    
    self.titleLabel.frame = CGRectMake(0, (fl_btnHeight-fl_labelHeight-fl_imageHeight-self.gapBetween)*0.5, fl_btnWidth, fl_labelHeight);
    self.imageView.frame = CGRectMake((fl_btnWidth - fl_imageWidth) * 0.5, (fl_btnHeight-fl_labelHeight-fl_imageHeight-self.gapBetween)*0.5+fl_labelHeight+self.gapBetween, fl_imageWidth, fl_imageHeight);
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 判断
    if (_status == TFAlignmentStatusNormal)
    {
        
    }
    else if (_status == TFAlignmentStatusLeft)
    {
        [self alignmentLeft];
    }
    else if (_status == TFAlignmentStatusCenter)
    {
        [self alignmentCenter];
    }
    else if (_status == TFAlignmentStatusRight)
    {
        [self alignmentRight];
    }
    else if (_status == TFAlignmentStatusTop)
    {
        [self alignmentTop];
    }
    else if (_status == TFAlignmentStatusBottom)
    {
        [self alignmentBottom];
    }
}

-(void)setFontSize:(CGFloat)fontSize
{
    self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self.layer setMasksToBounds:YES];
    
    //值越大，角度越圆
    [self.layer setCornerRadius:cornerRadius];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = [borderColor CGColor];
}

#pragma mark - 多边形按钮支持

// 绘制按钮时添加path遮罩
- (void)drawRect:(CGRect)rect
{
    if (self.path)
    {
         [super drawRect:rect];
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        shapLayer.path = self.path.CGPath;
        self.layer.mask = shapLayer;
    }
}

//覆盖方法，点击时判断点是否在path内，YES则响应，NO则不响应
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL resutl = [super pointInside:point withEvent:event];
    
    if (self.path)
    {
        //BOOL res = [super pointInside:point withEvent:event];
        if (resutl)
        {
            if ([self.path containsPoint:point])
            {
                resutl = YES;
            }
        }
    }
    
    return resutl;
}

#pragma mark - touch

- (void)touchAction:(void (^)(void))actionBlock
{
    _actionBlock = actionBlock;
}

- (void)longPressAction:(void(^)(void))actionBlock
{
    _longPressBlock = actionBlock;
}

- (void)touch:(id)sender
{
    if (_actionBlock)
    {
        _actionBlock();
    }
}

-(void)longPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (_longPressBlock)
    {
        _longPressBlock();
    }
}

#pragma mark - 设置按钮按钮全部状态背景

- (void)setNormalImage:(id)normalImage
     hightlightedImage:(id)hightlightedImage
         disabledImage:(id)disabledImage
{
    [self setNormalImage:normalImage];
    [self setHightlightedImage:hightlightedImage];
    [self setDisabledImage:disabledImage];
}

#pragma mark - 设置按钮按钮全部状态背景
- (void)setNormalBackgroundImage:(id)normalImage
     hightlightedBackgroundImage:(id)hightlightedImage
         disabledBackgroundImage:(id)disabledImage
{
    [self setNormalBackgroundImage:normalImage];
    [self setHightlightedBackgroundImage:hightlightedImage];
    [self setDisabledBackgroundImage:disabledImage];
}

- (void)setNormalBackgroundImage:(id)normalImage
         selectedBackgroundImage:(id)selectedBackgroundImage
         disabledBackgroundImage:(id)disabledImage {
    [self setNormalBackgroundImage:normalImage];
    [self setSelectedBackgroundImage:selectedBackgroundImage];
    [self setDisabledBackgroundImage:disabledImage];
}

#pragma mark - 设置按钮正常状态下的图片

- (void)setNormalImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        [self setImage:image forState:UIControlStateNormal];
    }
    else if ([image isKindOfClass:[UIColor class]])
    {
        [self setImage:[self imageWithColor:image] forState:UIControlStateNormal];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        if ([image length] > 0)
        {
            [self setImage:kImageWithName(image) forState:UIControlStateNormal];
        }
    }
}

- (void)setNormalBackgroundImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        [self setBackgroundImage:image forState:UIControlStateNormal];
    }
    else if ([image isKindOfClass:[UIColor class]])
    {
        [self setBackgroundImage:[self imageWithColor:image] forState:UIControlStateNormal];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        if ([image length] > 0)
        {
            [self setBackgroundImage:kImageWithName(image) forState:UIControlStateNormal];
        }
    }
}

#pragma mark - 设置按钮Hightlighted状态下的图片

- (void)setHightlightedImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        [self setImage:image forState:UIControlStateHighlighted];
    }
    else if ([image isKindOfClass:[UIColor class]])
    {
        [self setImage:[self imageWithColor:image] forState:UIControlStateHighlighted];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        if ([image length] > 0)
        {
            [self setImage:kImageWithName(image) forState:UIControlStateHighlighted];
        }
    }
}

- (void)setHightlightedBackgroundImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
    }
    else if ([image isKindOfClass:[UIColor class]])
    {
        [self setBackgroundImage:[self imageWithColor:image] forState:UIControlStateHighlighted];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        if ([image length] > 0)
        {
            [self setBackgroundImage:kImageWithName(image) forState:UIControlStateHighlighted];
        }
    }
}

#pragma mark - 设置按钮Selected状态下的图片

- (void)setSelectedImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        [self setImage:image forState:UIControlStateSelected];
    }
    else if ([image isKindOfClass:[UIColor class]])
    {
        [self setImage:[self imageWithColor:image] forState:UIControlStateSelected];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        if ([image length] > 0)
        {
            [self setImage:kImageWithName(image) forState:UIControlStateSelected];
        }
    }
}

- (void)setSelectedBackgroundImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        [self setBackgroundImage:image forState:UIControlStateSelected];
    }
    else if ([image isKindOfClass:[UIColor class]])
    {
        [self setBackgroundImage:[self imageWithColor:image] forState:UIControlStateSelected];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        if ([image length] > 0)
        {
            [self setBackgroundImage:kImageWithName(image) forState:UIControlStateSelected];
        }
    }
}

#pragma mark - 设置按钮禁用状态下的图片

- (void)setDisabledImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        [self setImage:image forState:UIControlStateDisabled];
    }
    else if ([image isKindOfClass:[UIColor class]])
    {
        [self setImage:[self imageWithColor:image] forState:UIControlStateDisabled];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        [self setImage:kImageWithName(image) forState:UIControlStateDisabled];
    }
}

- (void)setDisabledBackgroundImage:(id)image
{
    if ([image isKindOfClass:[UIImage class]])
    {
        [self setBackgroundImage:image forState:UIControlStateDisabled];
    }
    else if ([image isKindOfClass:[UIColor class]])
    {
        [self setBackgroundImage:[self imageWithColor:image] forState:UIControlStateDisabled];
    }
    else if ([image isKindOfClass:[NSString class]])
    {
        [self setBackgroundImage:kImageWithName(image) forState:UIControlStateDisabled];
    }
}

-(UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIColor *)colorWithColor:(UIColor *)color alpha:(float)alpha
{
    if ([color isEqual:[UIColor whiteColor]])
    {
        return [UIColor colorWithWhite:1.000 alpha:alpha];
    }
    
    if ([color isEqual:[UIColor blackColor]])
    {
        return [UIColor colorWithWhite:0.000 alpha:alpha];
    }
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:alpha];
}

#pragma mark - 设置按钮

-(void)setNormalTitle:(NSString *)title
             textFont:(UIFont *)font
            textColor:(UIColor *)color
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    UIColor *disabledColor = [self colorWithColor:color alpha:0.5];
    [self setTitleColor:disabledColor forState:UIControlStateDisabled];
    self.titleLabel.font = font;
    [self sizeToFit];
}

-(void)setHighlightedTitle:(NSString *)title
                  textFont:(UIFont *)font
                 textColor:(UIColor *)color
{
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    self.titleLabel.font = font;
}

-(void)setSelectedTitle:(NSString *)title
               textFont:(UIFont *)font
              textColor:(UIColor *)color
{
    [self setTitle:title forState:UIControlStateSelected];
    [self setTitleColor:color forState:UIControlStateSelected];
    self.titleLabel.font = font;
}

@end
