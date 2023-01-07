//
//  TFTableView.h
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+Category.h"

/**
 * tableview基类
 */
@interface TFTableView : UITableView

/**
 *  注册cell
 *
 *  @param cellClass cellClass
 */
-(void)registerCell:(Class)cellClass;

/**
 *  注册cell Nib文件，默认ReuseIdentifier为指定class的名称
 *
 *  @param className Nib文件类名称
 */
- (void)registerNib:(Class)className;

/// 注册header/footer Nib文件，默认ReuseIdentifier为指定class的名称
/// @param className Nib文件类名称
- (void)registerNibForHeaderFooterView:(Class)className;

@end
