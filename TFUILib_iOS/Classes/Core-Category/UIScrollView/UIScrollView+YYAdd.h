//
//  Category.h
//  Treasure
//
//  Created by xiayiyong on 15/7/1.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YYAdd)

/**
 *  滑动到顶部
 */
- (void)scrollToTop;

/**
 *  滑动到底部
 */
- (void)scrollToBottom;

/**
 *  滑动到左侧
 */
- (void)scrollToLeft;

/**
 *  滑动到右侧
 */
- (void)scrollToRight;

/**
 *  滑动到顶部
 *
 *  @param animated 是否加动画
 */
- (void)scrollToTopAnimated:(BOOL)animated;

/**
 *  滑动到底部
 *
 *  @param animated 是否加动画
 */
- (void)scrollToBottomAnimated:(BOOL)animated;

/**
 *  滑动到左侧
 *
 *  @param animated 是否加动画
 */
- (void)scrollToLeftAnimated:(BOOL)animated;

/**
 *  滑动到右侧
 *
 *  @param animated 是否加动画
 */
- (void)scrollToRightAnimated:(BOOL)animated;

@end

