//
//  UITableView+ReloadAnimation.m
//  UITableViewReloadAnimation
//
//  Created by xiayiyong on 15/7/1.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "UITableView+ReloadAnimation.h"

@implementation UITableView (ReloadAnimation)


- (void)reloadDataWithDirectionType:(TFReloadAnimationDirectionType)direction animationTime:(NSTimeInterval)animationTime interval:(NSTimeInterval)interval{
    [self reloadData];
    [self setContentOffset:self.contentOffset animated:NO];
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = YES;
        [self reloadData];
    } completion:^(BOOL finished) {
        self.hidden = NO;
        [self visibleRowsBeginDirectionType:direction animation:animationTime interval:interval];
    }];
}

- (void)visibleRowsBeginDirectionType:(TFReloadAnimationDirectionType)direction animation:(NSTimeInterval)animationTime interval:(NSTimeInterval)interval{
    NSArray *visibleArray = [self indexPathsForVisibleRows];
    NSInteger count = visibleArray.count;
    switch (direction) {
        case TFReloadAnimationDirectionTop:
        {

            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleArray[count - 1 - i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(originPoint.x, originPoint.y - 1000);
                [UIView animateWithDuration:(animationTime + (double)i *interval) delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    cell.center = CGPointMake(originPoint.x ,  originPoint.y + 2.0);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x ,  originPoint.y - 2.0);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case TFReloadAnimationDirectionBottom:
        {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleArray[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(originPoint.x, originPoint.y + 1000);
                [UIView animateWithDuration:(animationTime + (double)i *interval) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x ,  originPoint.y - 2.0);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x ,  originPoint.y + 2.0);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case TFReloadAnimationDirectionLeft:
        {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleArray[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(-cell.frame.size.width,  originPoint.y);
                [UIView animateWithDuration:(animationTime + (double)i *interval) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x - 2.0 ,  originPoint.y);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x + 2.0,  originPoint.y);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
        case TFReloadAnimationDirectionRight:
        {
            for (int i = 0; i < count; i++) {
                NSIndexPath *path = visibleArray[i];
                UITableViewCell *cell = [self cellForRowAtIndexPath:path];
                cell.hidden = YES;
                CGPoint originPoint = cell.center;
                cell.center = CGPointMake(cell.frame.size.width * 3.0,  originPoint.y);
                [UIView animateWithDuration:(animationTime + (double)i *interval) delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    cell.center = CGPointMake(originPoint.x + 2.0,  originPoint.y);
                    cell.hidden = NO;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                        cell.center = CGPointMake(originPoint.x - 2.0,  originPoint.y);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                            cell.center = originPoint;
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
            }
        }
            break;
            
        default:
            break;
    }

}
@end
