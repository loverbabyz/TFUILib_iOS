//
//  TFGridLayout.h
//  TFUILib
//
//  Created by xiayiyong on 16/3/4.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFGridLayout : UICollectionViewFlowLayout

/**
 *  行数
 */
@property (nonatomic, assign) NSUInteger numberOfColumns;
/**
 *  列数
 */
@property (nonatomic, assign) NSUInteger numberOfRows;

@end
