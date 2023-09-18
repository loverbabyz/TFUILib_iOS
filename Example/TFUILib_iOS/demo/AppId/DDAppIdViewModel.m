//
//  DDAppIdViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import "DDAppIdViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDAppIdViewModel

- (NSString *)title {
    return TF_LSTR(@"App ID");
}

- (NSArray<__kindof TFTableSectionModel *> *)dataArray {
    if (!kUserDefaults.appIdCached || kUserDefaults.appIdCached.count == 0) {
        return @[];
    }
    
    TFTableSectionModel *section = [TFTableSectionModel new];
    section.dataArray = [kUserDefaults.appIdCached copy];
    
    return @[section];
}

@end
