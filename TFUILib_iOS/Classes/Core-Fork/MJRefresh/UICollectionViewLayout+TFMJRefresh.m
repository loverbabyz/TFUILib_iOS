//
//  UICollectionViewLayout+TF
//  MJRefresh.m
//
//  该类是用来解决 Footer 在底端加载完成后, 仍停留在原处的 bug.
//  此问题出现在 iOS 14 及以下系统上.
//  Reference: https://github.com/CoderMJLee/MJRefresh/issues/1552
//
//  Created by jiasong on 2021/11/15.
//  Copyright © 2021 小码哥. All rights reserved.
//

#import "UICollectionViewLayout+TFMJRefresh.h"
#import "TFMJRefreshConst.h"
#import "TFMJRefreshFooter.h"
#import "UIScrollView+TFMJRefresh.h"

@implementation UICollectionViewLayout (TFMJRefresh)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        TFMJRefreshExchangeImplementations(self.class, @selector(finalizeCollectionViewUpdates),
                                         self.class, @selector(mj_finalizeCollectionViewUpdates));
    });
}

- (void)mj_finalizeCollectionViewUpdates {
    [self mj_finalizeCollectionViewUpdates];
    
    __kindof TFMJRefreshFooter *footer = self.collectionView.tf_mj_footer;
    CGSize newSize = self.collectionViewContentSize;
    CGSize oldSize = self.collectionView.contentSize;
    if (footer != nil && !CGSizeEqualToSize(newSize, oldSize)) {
        NSDictionary *changed = @{
            NSKeyValueChangeNewKey: [NSValue valueWithCGSize:newSize],
            NSKeyValueChangeOldKey: [NSValue valueWithCGSize:oldSize],
        };
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [footer scrollViewContentSizeDidChange:changed];
        [CATransaction commit];
    }
}

@end
