//
//  DDLogViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/15.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDLogViewModel.h"
#import "DDDemoManager.h"
#import "DDDemoManager.h"

@implementation DDLogViewModel

- (NSString *)title {
    return TF_LSTR(@"操作日志");
}

- (void)fetchData:(IntegerBlock)completion {
    __block NSMutableArray<TFTableRowModel *> *rows = [NSMutableArray new];
    [[DDDemoManager sharedInstance].logs enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {

        TFTableRowModel *row = [TFTableRowModel new];
        row.identity = key;
        row.content = TF_STR(TF_STRINGIFY(\n%@), obj);
        
        [rows addObject:row];
    }];
    
    // 使用 sortedArrayUsingComparator 方法对数组进行排序
    NSArray<TFTableRowModel *> *sortedRows = [rows sortedArrayUsingComparator:^NSComparisonResult(TFTableRowModel *obj1, TFTableRowModel *obj2) {
        // 降序排列，如果需要升序，可以交换下面的比较符号
        if (obj1.identity.integerValue < obj2.identity.integerValue) {
            return NSOrderedDescending;
        } else if (obj1.identity.integerValue > obj2.identity.integerValue) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];

    // 将排序后的数组重新放回原来的 NSMutableArray
    [rows removeAllObjects];
    [rows addObjectsFromArray:sortedRows];
    
    NSMutableArray<TFTableSectionModel *> *sections = [NSMutableArray new];
    [rows enumerateObjectsUsingBlock:^(TFTableRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TFTableSectionModel *section = [TFTableSectionModel new];
        section.dataArray = @[obj];
        
        [sections addObject:section];
    }];
    
    self.dataArray = [sections copy];
    
    if (completion) {
        completion(0);
    }
}

- (void)cleanLog:(VoidBlock)completion {
    [[DDDemoManager sharedInstance] cleanLog:completion];
}

@end
