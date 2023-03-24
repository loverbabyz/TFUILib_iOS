//
//  TFHBDNavigationBar.h
//  TFHBDNavigationBar
//
//  Created by Listen on 2018/3/23.
//

#import <UIKit/UIKit.h>

@interface TFHBDNavigationBar : UINavigationBar

@property(nonatomic, strong, readonly) UIImageView *shadowImageView;
@property(nonatomic, strong, readonly) UIVisualEffectView *fakeView;
@property(nonatomic, strong, readonly) UIImageView *backgroundImageView;
@property(nonatomic, strong, readonly) UILabel *backButtonLabel;
@property(nonatomic, strong, readonly) UIView *hbd_backgroundView;

@end


@interface UILabel (TFNavigationBarTransition)

@property(nonatomic, strong) UIColor *tf_hbd_specifiedTextColor;

@end
