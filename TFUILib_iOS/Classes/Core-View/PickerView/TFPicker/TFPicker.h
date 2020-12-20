//
//  TFPicker.h
//  TFUILib
//
//  Created by Daniel.Sun on 2018/1/27.
//

#import "TFView.h"

@class TFTreeNode;

typedef void (^TFPickerBlock)(NSDictionary<NSNumber *, TFTreeNode *> *selectedData);

@interface TFPicker : TFView

/**
 *  初始化选择器选择
 */
+ (id)initWithBlock:(TFPickerBlock)block dataArray:(NSArray<TFTreeNode *> *)dataArray components:(NSInteger)components;


/**
 初始化默认选择项

 @param row 行索引
 @param component 列索引
 @param animated 是否动画显示
 */
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (void)show:(void (^)(BOOL finished))completion;

@end
