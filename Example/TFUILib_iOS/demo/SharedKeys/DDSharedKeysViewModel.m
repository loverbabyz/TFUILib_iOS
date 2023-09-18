//
//  DDSharedKeysViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDSharedKeysViewModel.h"
#import <IngeekDK/IngeekDK.h>

@implementation DDSharedKeysViewModel

- (NSString *)title {
    return TF_LSTR(@"SHARED KEYS(98)");
}

- (void)fetchData:(IntegerBlock)completion {
    TF_WEAK_SELF
    
    NSString *vin = @"";
    NSArray<NSNumber *> *statuses = @[@(IngeekBleKeyStatusCreated), @(IngeekBleKeyStatusInUse), @(IngeekBleKeyStatusFrozen)];
    [[IngeekBle sharedInstance] getSharingKeys:vin
                                      statuses:statuses
                                    completion:^(NSArray<IngeekBleLimitedKey *> * _Nullable keys,
                                          NSInteger errorCode) {
        if (errorCode) {
            if (completion) {
                completion(errorCode);
            }
            
            return;
        }
        
        __block NSMutableArray<TFTableRowModel *> *rows = [NSMutableArray new];
        [keys enumerateObjectsUsingBlock:^(IngeekBleLimitedKey * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TFTableRowModel *row = [TFTableRowModel new];
            row.webModel = obj;
            
            [rows addObject:row];
        }];
        
        TFTableSectionModel *section = [TFTableSectionModel new];
        section.dataArray = rows.copy;
        
        weakSelf.dataArray = @[section];
        
        if (completion) {
            completion(errorCode);
        }
    }];
}


@end
