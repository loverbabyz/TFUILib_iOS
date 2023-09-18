//
//  DDVehicleViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDVehicleViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDVehicleViewModel

- (NSString *)title {
    return TF_LSTR(@"车辆列表");
}

- (NSArray<__kindof TFTableSectionModel *> *)dataArray {
    if (!kUserDefaults.vehicleCached || kUserDefaults.vehicleCached.count == 0) {
        return @[];
    }
    
    TFTableSectionModel *section = [TFTableSectionModel new];
    section.dataArray = [kUserDefaults.vehicleCached copy];
    
    return @[section];
}

@end
