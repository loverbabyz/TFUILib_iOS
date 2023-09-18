//
//  DDOwnerKeysViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDOwnerKeysViewModel.h"
#import <IngeekDK/IngeekDK.h>

@implementation DDOwnerKeysViewModel

- (NSString *)title {
    return TF_LSTR(@"OWNER KEYS(97)");
}

- (void)fetchData:(IntegerBlock)completion {
    TF_WEAK_SELF
    
    NSString *vin = @"";
    NSArray<NSNumber *> *statuses = @[@(IngeekBleKeyStatusCreated), @(IngeekBleKeyStatusInUse), @(IngeekBleKeyStatusFrozen)];
    [[IngeekBle sharedInstance] getKeys:vin statuses:statuses completion:^(NSArray<IngeekBleLimitedKey *> * _Nullable keys, NSInteger errorCode) {
        if (errorCode) {
            if (completion) {
                completion(errorCode);
            }
            
            return;
        }
        
        __block NSMutableArray<TFTableRowModel *> *rows = [NSMutableArray new];
        [keys enumerateObjectsUsingBlock:^(IngeekBleLimitedKey * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = TF_STRINGIFY(yyyy-MM-dd HH:mm:ss);
            NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:key.startTime/1000];
            NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:key.endTime/1000];
            NSString *detailText = [NSString stringWithFormat:TF_STRINGIFY(KEY:%@\nMOBILE:%@\nStart:%@ end:%@\nstatus:%lu),
                                         key.keyId, key.mobile,
                                         [formatter stringFromDate:startDate],
                                         [formatter stringFromDate:endDate],
                                         (unsigned long)key.status
            ];
            TFTableRowModel *row = [TFTableRowModel new];
            row.title = key.pid;
            row.content = detailText;
            
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
