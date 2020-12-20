//
//  UITableViewCell+ShowHide.h
//  Treasure
//
//  Created by sunxiaofei on 15/11/24.
//  Copyright © daniel.xiaofei@gmail All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ShowHide)

/**
 *  显示内容
 *
 *  @param duration 指定时间
 */
- (void)showWithDuration:(NSTimeInterval)duration;

/**
 *  隐藏内容
 *
 *  @param duration 指定时间
 */
- (void)hideWithDuration:(NSTimeInterval)duration;

@end
