//
//  UIView+dragable.h
//  SSXQ
//
//  Created by Daniel on 2020/12/9.
//  Copyright © 2020 sancell.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (dragable)

- (void)addDragableActionWithEnd:(void (^)(CGRect endFrame))endBlock;

@end

NS_ASSUME_NONNULL_END
