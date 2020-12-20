//
//  UITableView+Extension.h
//  UITableViewReloadAnimation
//
//  Created by xiayiyong on 15/7/1.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TFReloadAnimationDirectionType)
{
    TFReloadAnimationDirectionLeft,
    TFReloadAnimationDirectionRight,
    TFReloadAnimationDirectionTop,
    TFReloadAnimationDirectionBottom,
};

@interface UITableView (ReloadAnimation)

/**
 *  UITableView重新加载动画
 *
 *  @param   direction     cell运动方向
 *  @param   animationTime 动画持续时间，设置成1.0
 *  @param   interval      每个cell间隔，设置成0.1
 *  @eg      [self.tableView reloadDataWithDirectionType:direction animationTime:0.5 interval:0.05];
 *
 */
- (void)reloadDataWithDirectionType:(TFReloadAnimationDirectionType)direction animationTime:(NSTimeInterval)animationTime interval:(NSTimeInterval)interval;

@end
