//
//  TFTreeTableViewCell.h
//  SSXQ
//
//  Created by Daniel on 2020/7/27.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//

#import "TFTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class TFTreeSectionModel;
@class TFView;
@class RACSubject;
@interface TFTreeTableViewCell : TFTableViewCell

/// subTableView边距
@property (nonatomic, assign) CGFloat padding;

/// 初始化cell数据
/// @param data 数据
/// @param cellView cellView
/// @param subTableHeaderView subTableHeaderView
/// @param subTableCellClass  继承自TFTableViewCell的类
/// @param subTablFooterView subTablFooterView descriptionsubTablFooterView
- (void)initData:(TFTreeSectionModel *)data cellView:(TFView *)cellView subTreeTableHeaderView:(TFView *)subTableHeaderView subTreeTableCellClass:(Class)subTableCellClass subTreeTablFooterView:(TFView *)subTablFooterView;

@end

NS_ASSUME_NONNULL_END
