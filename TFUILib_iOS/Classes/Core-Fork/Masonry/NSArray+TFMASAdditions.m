//
//  NSArray+TFMASAdditions.m
//  
//
//  Created by Daniel Hammond on 11/26/13.
//
//

#import "NSArray+TFMASAdditions.h"
#import "View+TFMASAdditions.h"

@implementation NSArray (TFMASAdditions)

- (NSArray *)tf_mas_makeConstraints:(void(^)(TFMASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (TF_MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[TF_MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view tf_mas_makeConstraints:block]];
    }
    return constraints;
}

- (NSArray *)tf_mas_updateConstraints:(void(^)(TFMASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (TF_MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[TF_MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view tf_mas_updateConstraints:block]];
    }
    return constraints;
}

- (NSArray *)tf_mas_remakeConstraints:(void(^)(TFMASConstraintMaker *make))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (TF_MAS_VIEW *view in self) {
        NSAssert([view isKindOfClass:[TF_MAS_VIEW class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view tf_mas_remakeConstraints:block]];
    }
    return constraints;
}

- (void)tf_mas_distributeViewsAlongAxis:(TFMASAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    TF_MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == TFMASAxisTypeHorizontal) {
        TF_MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            TF_MAS_VIEW *v = self[i];
            [v tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                if (prev) {
                    make.width.equalTo(prev);
                    make.left.equalTo(prev.tf_mas_right).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
    else {
        TF_MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            TF_MAS_VIEW *v = self[i];
            [v tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                if (prev) {
                    make.height.equalTo(prev);
                    make.top.equalTo(prev.tf_mas_bottom).offset(fixedSpacing);
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }                    
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
                
            }];
            prev = v;
        }
    }
}

- (void)tf_mas_distributeViewsAlongAxis:(TFMASAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    TF_MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    if (axisType == TFMASAxisTypeHorizontal) {
        TF_MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            TF_MAS_VIEW *v = self[i];
            [v tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                make.width.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {//last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.right.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.left.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
    else {
        TF_MAS_VIEW *prev;
        for (int i = 0; i < self.count; i++) {
            TF_MAS_VIEW *v = self[i];
            [v tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                make.height.equalTo(@(fixedItemLength));
                if (prev) {
                    if (i == self.count - 1) {//last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing);
                    }
                    else {
                        CGFloat offset = (1-(i/((CGFloat)self.count-1)))*(fixedItemLength+leadSpacing)-i*tailSpacing/(((CGFloat)self.count-1));
                        make.bottom.equalTo(tempSuperView).multipliedBy(i/((CGFloat)self.count-1)).with.offset(offset);
                    }
                }
                else {//first one
                    make.top.equalTo(tempSuperView).offset(leadSpacing);
                }
            }];
            prev = v;
        }
    }
}

- (TF_MAS_VIEW *)mas_commonSuperviewOfViews
{
    TF_MAS_VIEW *commonSuperview = nil;
    TF_MAS_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[TF_MAS_VIEW class]]) {
            TF_MAS_VIEW *view = (TF_MAS_VIEW *)object;
            if (previousView) {
                commonSuperview = [view tf_mas_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end
