//
//  UIView+dragable.m
//  SSXQ
//
//  Created by Daniel on 2020/12/9.
//  Copyright © 2020 sancell.cn. All rights reserved.
//

#import "UIView+dragable.h"
#import <objc/runtime.h>
#import "TFUILibMacro+View.h"

#define ScreenWidth                         SCREEN_WIDTH
#define ScreenHeight                        SCREEN_HEIGHT

static const char *ActionHandlerPanGestureKey;

@implementation UIView (dragable)

- (void)addDragableActionWithEnd:(void (^)(CGRect endFrame))endBlock {
    // 添加拖拽手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
    [self addGestureRecognizer:panGestureRecognizer];
    
    // 记录block
    objc_setAssociatedObject(self, ActionHandlerPanGestureKey, endBlock, OBJC_ASSOCIATION_COPY);
}

- (void)handlePanAction:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:[sender.view superview]];
    
    CGFloat senderHalfViewWidth = sender.view.frame.size.width / 2;
    CGFloat senderHalfViewHeight = sender.view.frame.size.height / 2;
    
    __block CGPoint viewCenter = CGPointMake(sender.view.center.x + point.x, sender.view.center.y + point.y);
    // 拖拽状态结束
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.4 animations:^{
            if ((sender.view.center.x + point.x - senderHalfViewWidth) <= 12) {
                viewCenter.x = senderHalfViewWidth + 12;
            }
            if ((sender.view.center.x + point.x + senderHalfViewWidth) >= (TF_SCREEN_WIDTH - 12)) {
                viewCenter.x = TF_SCREEN_WIDTH - senderHalfViewWidth - 12;
            }
            if ((sender.view.center.y + point.y - senderHalfViewHeight) <= 12) {
                viewCenter.y = senderHalfViewHeight + 12;
            }
            if ((sender.view.center.y + point.y + senderHalfViewHeight) >= (TF_SCREEN_HEIGHT - 12)) {
                viewCenter.y = TF_SCREEN_HEIGHT - senderHalfViewHeight - 12;
            }
            sender.view.center = viewCenter;
        } completion:^(BOOL finished) {
            void (^endBlock)(CGRect endFrame) = objc_getAssociatedObject(self, ActionHandlerPanGestureKey);
            if (endBlock) {
                endBlock(sender.view.frame);
            }
        }];
        [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
    } else {
        // UIGestureRecognizerStateBegan || UIGestureRecognizerStateChanged
        viewCenter.x = sender.view.center.x + point.x;
        viewCenter.y = sender.view.center.y + point.y;
        sender.view.center = viewCenter;
        [sender setTranslation:CGPointMake(0, 0) inView:[sender.view superview]];
    }
}

@end
