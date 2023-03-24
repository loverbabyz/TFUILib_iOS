//
//  TFHBDNavigationController.h
//  TFHBDNavigationBar
//
//  Created by Listen on 2018/3/23.
//

#import <UIKit/UIKit.h>

@interface TFHBDNavigationController : UINavigationController

- (void)updateNavigationBarForViewController:(UIViewController *)vc;

@end

@interface UINavigationController (UINavigationBar) <UINavigationBarDelegate>

@end

@protocol TFHBDNavigationTransitionProtocol <NSObject>

- (void)handleNavigationTransition:(UIScreenEdgePanGestureRecognizer *)pan;

@end
