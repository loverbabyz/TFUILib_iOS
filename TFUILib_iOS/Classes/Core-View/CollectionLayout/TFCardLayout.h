//
//  TFHeadFloatLayout.h
//  TFUILib
//
//  Created by Daniel on 16/3/4.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//
//  copy from https://github.com/BetterFatMan/CollectionView
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TFCardAnimType)
{
    TFCardAnimTypeLinear,
    TFCardAnimTypeRotary,
    TFCardAnimTypeCarousel,
    TFCardAnimTypeCarousel1,
    TFCardAnimTypeCoverFlow,
};

/// 卡片式布局
@interface TFCardLayout : UICollectionViewLayout

/**
 *  根据动画类型初始化
 *
 *  @param anim 动画类型
 */
- (instancetype)initWithAnim:(TFCardAnimType)anim;

/**
 *  动画类型
 */
@property (readonly)  TFCardAnimType carouselAnim;

/**
 *  卡片大小
 */
@property (nonatomic) CGSize itemSize;
/**
 *  可视卡片数
 */
@property (nonatomic) NSInteger visibleCount;
/**
 *  滚动方向
 */
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@end
