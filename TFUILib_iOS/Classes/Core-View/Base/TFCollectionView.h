//
//  TFCollectionView.h
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCollectionView : UICollectionView

/**
 *  注册cell
 *
 *  @param cellClass cellClass
 */
-(void)registerCell:(Class)cellClass;

/**
 *  注册headview
 *
 *  @param viewClass viewClass
 */
-(void)registerHeaderClass:(Class)viewClass;

/**
 *  注册footview
 *
 *  @param cellClass viewClass
 */
-(void)registerFooterClass:(Class)cellClass;

/**
 *  注册cell Nib文件，默认ReuseIdentifier为指定class的名称
 *
 *  @param className Nib文件类名称
 */
- (void)registerNib:(Class)className;

/// 注册header Nib文件，默认ReuseIdentifier为指定class的名称
/// @param className Nib文件类名称
- (void)registerHeaderNib:(Class)className;

/// 注册footer Nib文件，默认ReuseIdentifier为指定class的名称
/// @param className Nib文件类名称
- (void)registerFooterNib:(Class)className;

@end
