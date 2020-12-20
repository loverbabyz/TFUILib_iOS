//
//  TFSectionModel.h
//  TFUILib
//
//  Created by xiayiyong on 16/3/11.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFModel.h"
#import "TFTableRowModel.h"

@interface TFTableSectionModel : TFModel

/// detail文字
@property (nonatomic, copy) NSString *detail;

/**
 * 列表的数据源
 */
@property (nonatomic, strong) NSArray<__kindof TFTableRowModel *> *dataArray;

- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray<__kindof TFTableRowModel *> *)dataArray;

@end
