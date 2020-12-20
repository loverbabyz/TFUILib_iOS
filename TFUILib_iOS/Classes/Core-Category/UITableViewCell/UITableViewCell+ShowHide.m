//
//  UITableViewCell+ShowHide.m
//  Treasure
//
//  Created by sunxiaofei on 15/11/24.
//  Copyright © daniel.xiaofei@gmail All rights reserved.
//

#import "UITableViewCell+ShowHide.h"

@implementation UITableViewCell (ShowHide)

#pragma mark - public functions

- (void)showWithDuration:(NSTimeInterval)duration
{
     __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:duration
                     animations:^{
                         
                         weakSelf.contentView.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
- (void)hideWithDuration:(NSTimeInterval)duration
{
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:duration
                     animations:^{
                         
                         weakSelf.contentView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
@end
