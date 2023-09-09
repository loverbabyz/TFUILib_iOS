//
//  TFFormSectionModel.h
//  TFUILib
//
//  Created by Daniel on 7/9/23.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFTableSectionModel.h"
#import "TFFormRowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFFormSectionModel : TFTableSectionModel

/// footTitle
@property (nonatomic, copy) NSString *footTitle;

/// 子表格数据
@property (nonatomic, strong) NSArray<__kindof TFFormRowModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END
