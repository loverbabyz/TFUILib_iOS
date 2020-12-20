//
//  TFTreeSectionModel.h
//  SSXQ
//
//  Created by Daniel on 2020/7/25.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//

#import "TFTableSectionModel.h"

/// 树形section数据模型
@interface TFTreeSectionModel : TFTableSectionModel

/// 当前行indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;

/// 当前行数据
//@property (nonatomic, strong) id rowModel;

/// 子表格数据
@property (nonatomic, strong) NSArray<__kindof TFTreeSectionModel *> *subTableDataArray;

/// 子表格展开状态
@property (nonatomic, assign) BOOL expanded;

@end
