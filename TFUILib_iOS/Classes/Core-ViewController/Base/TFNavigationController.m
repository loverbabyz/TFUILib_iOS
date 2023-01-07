//
//  TFNavigationController.m
//  Treasure
//
//  Created by Daniel on 15/7/2.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFNavigationController.h"
#import "TFTabBarController.h"

@interface TFNavigationController ()

@end

@implementation TFNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    return [super initWithRootViewController:rootViewController];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.interactivePopGestureRecognizer.delegate = nil;
    
    [self initViews];
    [self autolayoutViews];
    [self bindData];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color alpha:(NSInteger)alpha
{
    [self.navigationBar setBgColor:color];
    [self.navigationBar setElementsAlpha:alpha];
}

#pragma mark- init autolayout bind

- (void)initViews
{
    
}

- (void)autolayoutViews
{
    
}

- (void)bindData
{
    
}

#pragma mark - Setter Getter -

- (UIViewController *)previousViewController
{
    UIViewController *previousVC = nil;
    if (self.viewControllers.count != 0)
    {
        previousVC = self.viewControllers[self.viewControllers.count-2];
    }
    
    return previousVC;
}

- (void)setRootViewController:(TFViewController *)rootViewController
{
    
}

- (UIViewController *)rootViewController
{
    return self.viewControllers.firstObject;
}

#pragma mark - 屏幕旋转

- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

@end
