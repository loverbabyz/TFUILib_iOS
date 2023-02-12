//
//  TFTableViewControllerDelegate.h
//  TFUILib
//
//  Created by Daniel on 16/3/14.
//  Copyright © 2016年. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TFTableViewControllerDelegate <NSObject>

@required

- (void)registerCell;

@optional

- (void)loadNewData;

- (void)loadMoreData;

@end
