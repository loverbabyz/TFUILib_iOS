//
//  DDLoginInfoViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDLoginInfoViewModel.h"
#import "TFUserDefaults+demo.h"
#import "DDDemoModel.h"

@implementation DDLoginInfoViewModel

- (NSString *)title {
    return TF_LSTR(@"switchUser");
}

- (void)fetchData:(IntegerBlock)completion {
    NSMutableArray<TFTableSectionModel *> *sections = [NSMutableArray new];
    
    if (kUserDefaults.modelCached && kUserDefaults.modelCached.count > 0) {
        TFTableSectionModel *section = [TFTableSectionModel new];
        __block NSMutableArray<TFTableRowModel *> *rows = [NSMutableArray new];
        [kUserDefaults.modelCached enumerateObjectsUsingBlock:^(DDDemoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TFTableRowModel *row = [TFTableRowModel new];
            row.title = obj.userId;
            row.content = obj.mobile;
            [rows addObject:row];
        }];
        
        section.dataArray = rows;
        
        self.dataArray = [sections copy];
    }
    
    if (completion) {
        completion(0);
    }
}

- (NSArray<__kindof TFTableSectionModel *> *)dataArray {
    if (!kUserDefaults.modelCached || kUserDefaults.modelCached.count == 0) {
        return @[];
    }
    
    TFTableSectionModel *section = [TFTableSectionModel new];
    __block NSMutableArray<TFTableRowModel *> *rows = [NSMutableArray new];
    [kUserDefaults.modelCached enumerateObjectsUsingBlock:^(DDDemoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TFTableRowModel *row = [TFTableRowModel new];
        row.title = obj.userId;
        row.content = obj.mobile;
        [rows addObject:row];
    }];
    
    section.dataArray = rows;
    
    return @[section];
}

@end
