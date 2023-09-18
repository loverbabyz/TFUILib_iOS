//
//  DDEnvrimentViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import "DDEnvrimentViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDEnvrimentViewModel

- (NSString *)title {
    return TF_LSTR(@"Envriment");
}

- (NSArray<__kindof TFTableSectionModel *> *)dataArray {
    if (!kUserDefaults.envrimentCached || kUserDefaults.envrimentCached.count == 0) {
        return @[];
    }
    
    TFTableSectionModel *section = [TFTableSectionModel new];
    section.dataArray = [kUserDefaults.envrimentCached copy];
    
    return @[section];
}

@end
