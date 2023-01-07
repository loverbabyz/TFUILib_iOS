//
//  TFCollectionViewDelegate.h
//  TFUILib
//
//  Created by Daniel on 16/3/14.
//  Copyright © 2016年 上海赛可电子商务有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TFCollectionViewDelegate <NSObject>

@required

- (void)initViews;

- (void)autolayoutViews;

- (void)bindData;

- (void)registerCell;

@optional
- (void)loadNewData;

- (void)loadMoreData;

@end
