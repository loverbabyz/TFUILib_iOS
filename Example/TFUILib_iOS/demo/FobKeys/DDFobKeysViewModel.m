//
//  DDFobKeysViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDFobKeysViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDFobKeysViewModel

- (NSString *)title {
    return TF_LSTR(@"FOB KEYS");
}

- (void)fetchData:(IntegerBlock)completion {
#ifdef kFeature_JXA
    [[IngeekBle sharedInstance] getFobKeys:self.vin completion:^(NSArray<IngeekFobKey *> * _Nullable keys, NSInteger errorCode) {
        
        if (errorCode) {
            if (completion) {
                completion(errorCode);
            }
            
            return;
        }
        
        __block NSMutableArray<TFTableRowModel *> *rows = [NSMutableArray new];
        [keys enumerateObjectsUsingBlock:^(IngeekFobKey * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = kStringify(yyyy-MM-dd HH:mm:ss);
            NSDate *createTime = [NSDate dateWithTimeIntervalSince1970:key.createTime / 1000];
            NSDate *updateTime = [NSDate dateWithTimeIntervalSince1970:key.updateTime / 1000];
            NSString *detailText = [NSString stringWithFormat:kStringify(createTime:%@\nupdateTime:%@\nvin:%@\nSN:%@\nmacAddress:%@\nuserId:%@\nnfcCardId:%@\nStatus:%lu),
                                         [formatter stringFromDate:createTime],
                                         [formatter stringFromDate:updateTime],
                                         key.pid,
                                         key.sn,
                                         key.macAddress,
                                         key.userId,
                                         key.nfcCardId,
                                         (unsigned long)key.status];
            
            TFTableRowModel *row = [TFTableRowModel new];
            row.title = key.pid;
            row.content = detailText;
            
            [rows addObject:row];
        }];
        
        TFTableSectionModel *section = [TFTableSectionModel new];
        section.dataArray = rows.copy;
        self.dataArray = @[section];
        
        if (completion) {
            completion(errorCode);
        }
    }];
#endif
}

@end
