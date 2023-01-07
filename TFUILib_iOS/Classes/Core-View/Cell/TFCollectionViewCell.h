//
//  TFCollectionViewCell.h
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFCollectionViewCell : UICollectionViewCell

/**
 *  cell数据
 */
@property (nonatomic, strong) id data;

+ (id)loadCellFromXib;

/**
 *  获取reusableIdentifier
 *
 *  @return reusableIdentifier
 */
+ (NSString*)reusableIdentifier;

/**
 *  初始化视图
 */
- (void)initViews;

/**
 *  自动布局视图
 */
- (void)autolayoutViews;

/**
 *  绑定数据
 */
- (void)bindData;

/**
 *  获取cell高度
 *
 *  @return cell高度
 */
+(CGFloat)cellHeight;

@end
