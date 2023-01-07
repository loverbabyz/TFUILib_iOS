//
//  TFViewDelegate.h
//  TFUILib
//
//  Created by Daniel on 16/3/11.
//  Copyright © 2016年 上海赛可电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TFViewDelegate <NSObject>

@required
- (void)initViews;

- (void)autolayoutViews;

- (void)bindData;

@end
