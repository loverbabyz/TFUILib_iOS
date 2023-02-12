//
//  TFViewControllerDelegate.h
//  TFUILib
//
//  Created by Daniel on 16/3/11.
//  Copyright © 2016年. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TFViewControllerDelegate <NSObject>

@optional

- (void)initViews;

- (void)autolayoutViews;

- (void)bindData;

@end
