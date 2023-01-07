//
//  UIViewController+NavigationButton.m
//  TFUILib
//
//  Created by Daniel on 16/3/21.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+NavigationButton.h"
#import "UIViewController+Push.h"
#import "TFUIUtil.h"
#import "TFButton.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@implementation UIViewController (NavigationButton)

#pragma mark init button

#pragma mark - middle view

-(void)initTitle:(NSString*)title
{
    [self.navigationItem setTitle:title];
}

-(void)initTitle:(NSString *)title
           color:(UIColor *)titleColor
{
    [self.navigationItem setTitle:title];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:titleColor,
      NSForegroundColorAttributeName,nil]];
}

- (void)initMiddleView:(UIView*)view
{
    self.navigationItem.titleView = view;
}

#pragma mark - left

- (void)initLeftImage:(NSString *)strImage
{
    [self initLeftImage:strImage
         highLightImage:strImage
               selector:@selector(leftButtonEvent)];
}

-(void)initLeftImage:(NSString *)strImage
      highLightImage:(NSString *)highLightImage
{
    [self initLeftImage:strImage
         highLightImage:highLightImage
               selector:@selector(leftButtonEvent)];
}

- (void)initLeftImage:(NSString *)strImage
             selector:(SEL)selector
{
    [self initLeftImage:strImage
         highLightImage:strImage
               selector:selector];
}

-(void)initLeftImage:(NSString *)strImage
      highLightImage:(NSString *)highLightImage
            selector:(SEL)selector
{
    CGRect rect   = CGRectMake(0, -2*SCREEN_WIDTH/320, [UIImage imageNamed:strImage].size.width, 44);
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)initLeftTitle:(NSString *)strTitle
{
    [self initLeftTitle:strTitle selector:@selector(leftButtonEvent)];
    
}

- (void)initLeftTitle:(NSString *)strTitle
             selector:(SEL)selector
{
    [self initLeftTitle:strTitle
                  color:[UIColor blackColor]
               selector:selector];
}

- (void)initLeftTitle:(NSString *)strTitle
                color:(UIColor *)color
{
    [self initLeftTitle:strTitle
                  color:color
               selector:@selector(leftButtonEvent)];
}

- (void)initLeftTitle:(NSString *)strTitle
                color:(UIColor *)color
             selector:(SEL)selector
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [btn sizeToFit];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)initLeftImage:(NSString *)strImage
                title:(NSString *)strTitle
                color:(UIColor *)color
{
    [self initLeftImage:strImage
                  title:strTitle
                  color:color
               selector:@selector(leftButtonEvent)];
}

-(void)initLeftImage:(NSString *)strImage
      highLightImage:(NSString *)highLightImage
               title:(NSString *)strTitle
               color:(UIColor *)color
{
    [self initLeftImage:strImage
         highLightImage:highLightImage
                  title:strTitle
                  color:color
               selector:@selector(leftButtonEvent)];
}

- (void)initLeftImage:(NSString *)strImage
                title:(NSString *)strTitle
                color:(UIColor *)color
             selector:(SEL)selector
{
    [self initLeftImage:strImage
         highLightImage:strImage
                  title:strTitle
                  color:color
               selector:selector];
}

-(void)initLeftImage:(NSString *)strImage
      highLightImage:(NSString *)highLightImage
               title:(NSString *)strTitle
               color:(UIColor *)color
            selector:(SEL)selector
{
    CGRect rect = CGRectMake(0, -2*SCREEN_WIDTH/320, 60, 44);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)initLeftWithArray:(NSArray *)buttonArray {
    [self initButtonWithArray:buttonArray leftSide:YES];
}

#pragma mark - right

- (void)initRightImage:(NSString *)strImage
{
    [self initRightImage:strImage highLightImage:strImage];
}

-(void)initRightImage:(NSString *)strImage
       highLightImage:(NSString *)highLightImage
{
    [self initRightImage:strImage
          highLightImage:highLightImage
                selector:@selector(rightButtonEvent)];
}

- (void)initRightImage:(NSString *)strImage
              selector:(SEL)selector
{
    [self initRightImage:strImage
          highLightImage:strImage
                selector:selector];
}

-(void)initRightImage:(NSString *)strImage
       highLightImage:(NSString *)highLightImage
             selector:(SEL)selector
{
    CGRect rect = CGRectMake(0, -2*SCREEN_WIDTH/320, [UIImage imageNamed:strImage].size.width, 44);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)initRightTitle:(NSString *)strTitle
{
    [self initRightTitle:strTitle color:[UIColor blackColor]];
}

- (void)initRightTitle:(NSString *)strTitle selector:(SEL)selector
{
    [self initRightTitle:strTitle
                   color:[UIColor blackColor]
                selector:selector];
}

- (void)initRightTitle:(NSString *)strTitle color:(UIColor *)color;
{
    [self initRightTitle:strTitle
                   color:color
                selector:@selector(rightButtonEvent)];
}

- (void)initRightTitle:(NSString *)strTitle
                 color:(UIColor *)color
              selector:(SEL)selector
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [btn sizeToFit];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)initRightImage:(NSString *)strImage
                 title:(NSString *)strTitle
                 color:(UIColor *)color
{
    [self initRightImage:strImage
          highLightImage:strImage
                   title:strTitle color:color];
}

-(void)initRightImage:(NSString *)strImage
       highLightImage:(NSString *)highLightImage
                title:(NSString *)strTitle
                color:(UIColor *)color
{
    [self initRightImage:strImage
          highLightImage:highLightImage
                   title:strTitle
                   color:color
                selector:@selector(rightButtonEvent)];
}

- (void)initRightImage:(NSString *)strImage
                 title:(NSString *)strTitle
                 color:(UIColor *)color
              selector:(SEL)selector
{
    [self initRightImage:strImage
          highLightImage:strImage
                   title:strTitle
                   color:color
                selector:selector];
}

-(void)initRightImage:(NSString *)strImage
       highLightImage:(NSString *)highLightImage
                title:(NSString *)strTitle
                color:(UIColor *)color
             selector:(SEL)selector
{
    CGRect rect = CGRectMake(0, -2*SCREEN_WIDTH/320, 60, 44);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highLightImage] forState:UIControlStateHighlighted];
    [btn setTitle:strTitle forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.backgroundColor = [UIColor clearColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)resetLeftTitle:(NSString*)str
{
    UIButton *btn = self.navigationItem.leftBarButtonItem.customView;
    [btn setTitle:str forState:UIControlStateNormal];
}

- (void)resetRightTitle:(NSString*)str
{
    UIButton *btn = self.navigationItem.rightBarButtonItem.customView;
    [btn setTitle:str forState:UIControlStateNormal];
}

- (void)initBackButton
{
    UIViewController *rootVC=[self getRootViewController];
    
    if (![rootVC isKindOfClass:[UINavigationController class]])
    {
        return;
    }
    
    UINavigationController *rootNav= (UINavigationController *)rootVC;
    if (rootNav.viewControllers.count>=1 && self!=rootNav.viewControllers.firstObject)
    {
        UIImage *backImage = [UIImage imageNamed:@"icon_back_normal"];
        if (backImage) {
            [self initLeftImage:@"icon_back_normal"];
        } else {
            [self initLeftTitle:NSLocalizedString(@"back", @"返回")];
        }
    }
}

- (void)initRightWithArray:(NSArray *)buttonArray {
    [self initButtonWithArray:buttonArray leftSide:NO];
}

#pragma mark event

- (void)leftButtonEvent
{
    if ([self respondsToSelector:@selector(back)])
    {
        [self back];
    }
}

- (void)rightButtonEvent
{
    
}

#pragma mark button event

- (void)hideLeftButton
{
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
}

-(void)showLeftButton
{
    self.navigationItem.leftBarButtonItem.customView.hidden = NO;
}

- (void)hideRightButton
{
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
}

-(void)showRightButton
{
    self.navigationItem.rightBarButtonItem.customView.hidden = NO;
}

- (void)enableLeftButton
{
    if (self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem.enabled = YES;
    }
}

- (void)enableRightButton
{
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)disableLeftButton
{
    if (self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem.enabled = NO;
    }
}

- (void)disableRightButton
{
    if (self.navigationItem.rightBarButtonItem)
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

#pragma mark - private method

- (void)initButtonWithArray:(NSArray<TFButton *> *)buttonArray leftSide:(BOOL)leftSide{
    if (!buttonArray || buttonArray.count < 0) {
        NSAssert(YES, @"初始化数组不能为空");
        
        return;
    }
    NSMutableArray *buttonItems = [NSMutableArray arrayWithCapacity:buttonArray.count];
    [buttonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj) {
            return;
        }
        
        // 如果为非TFButton的对象，终止循环
        Class class = NSClassFromString(NSStringFromClass([obj class]));
        if (![class isSubclassOfClass:[TFButton class]]) {
            *stop = true;
        }
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:obj];
        [buttonItems addObject:item];
    }];
    
    if (leftSide) {
        self.navigationItem.leftBarButtonItems = buttonItems;
    } else {
        self.navigationItem.rightBarButtonItems = buttonItems;
    }
}

@end
