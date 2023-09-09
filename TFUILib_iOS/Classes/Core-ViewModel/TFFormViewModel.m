//
//  TFFormViewModel.m
//  TFUILib
//
//  Created by Daniel on 7/9/23.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFFormViewModel.h"
#import <TFBaseLib_iOS/TFMJExtension.h>
#import "TFFormSectionModel.h"

@interface TFFormViewModel()

@end
@implementation TFFormViewModel
@dynamic dataArray;

- (TFFormRowModel *)dataAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count == 0) {
        return nil;
    }
    
    return (TFFormRowModel *)self.dataArray[indexPath.row];
}

- (NSArray<__kindof TFTableSectionModel *> *)formDataArray {
    static NSArray<__kindof TFFormSectionModel *> *array;
    if(!_formDataArray)
    {
        NSString *className=NSStringFromClass([self class]);
        NSString *fileName=[NSString stringWithFormat:@"%@.json",className];
        NSDictionary *data = [self jsonDataFromFileName:fileName];
        _formDataArray = [TFFormSectionModel tf_mj_objectArrayWithKeyValuesArray:data];
    }
    
    return _formDataArray;
}

- (NSArray<__kindof TFTableSectionModel *> *)dataArray {
    return self.formDataArray;
}

@end
