//
//  UIView+Masonry.m
//  Treasure
//
//  Created by Daniel on 15/9/9.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIView+Masonry.h"
#import "TFMasonry.h"

@implementation UIView (Masonry)

-(void)masViewEqualToSuperViewWithInsets:(UIEdgeInsets)insets
{
    if(self.superview == nil) return;
    
    [self tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        
        make.edges.equalTo(self.superview).with.insets(insets);
    }];
}

+ (void)centerView:(UIView *)view size:(CGSize)size
{
    [view tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        
        make.center.equalTo(view.superview);
        make.size.mas_equalTo(size);
    }];
}

+ (void)view:(UIView *)view edgeInset:(UIEdgeInsets)edgeInsets
{
    [view tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        
        make.edges.equalTo(view.superview).with.insets(edgeInsets);
    }];
}

+ (void)equalSpacingView:(NSArray *)views
               viewWidth:(CGFloat)width
              viewHeight:(CGFloat)height
          superViewWidth:(CGFloat)superViewWidth
{
    //每个视图之间的距离
    CGFloat padding = (superViewWidth -  width * views.count) / (views.count - 1);
    
    for (int i = 0; i < views.count; i++)
    {
        
        UIView *firstView   = views[0];
        UIView *lastView    = views[views.count-1];
        UIView *currentView = views[i];
        
        if (i == 0)
        {
            
            UIView *nextView = views[i + 1];
            
            [firstView tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(currentView.superview.tf_mas_centerY);
                make.left.equalTo(currentView.superview.tf_mas_left);
                make.right.equalTo(nextView.tf_mas_left).with.offset(-padding);
                make.height.mas_equalTo(height);
                make.width.equalTo(nextView);
            }];
            
        }
        else if (i == views.count-1)
        {
            
            UIView *previousView = views[i - 1];
            
            [lastView tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(lastView.superview.tf_mas_centerY);
                make.left.equalTo(previousView.tf_mas_right).with.offset(padding);
                make.right.equalTo(lastView.superview.tf_mas_right);
                make.height.mas_equalTo(width);
                make.width.equalTo(previousView);
            }];
            
        }
        else {
        
            UIView *previousView = views[i - 1];
            UIView *nextView = views[i+1];
            
            [currentView tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(currentView.superview.tf_mas_centerY);
                make.left.equalTo(previousView.tf_mas_right).with.offset(padding);
                make.right.equalTo(nextView.tf_mas_left).with.offset(-padding);
                make.height.mas_equalTo(height);
                make.width.equalTo(previousView);
            }];
            
            if (i + 1 == views.count)
            {
                [nextView tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                    make.centerY.mas_equalTo(nextView.superview.tf_mas_centerY);
                    make.left.equalTo(currentView.tf_mas_right).with.offset(padding);
                    make.right.equalTo(nextView.superview.tf_mas_right);
                    make.height.mas_equalTo(width);
                    make.width.equalTo(previousView);
                }];
                
                return;
            }
        }
    }
}

@end
