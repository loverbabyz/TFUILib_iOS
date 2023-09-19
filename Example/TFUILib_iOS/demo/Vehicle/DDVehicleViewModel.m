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

- (void)fetchData:(IntegerBlock)completion {
    NSMutableArray<TFTableSectionModel *> *sections = [NSMutableArray new];
    
    if (kUserDefaults.vehicleCached && kUserDefaults.vehicleCached.count > 0) {
        TFTableSectionModel *section = [TFTableSectionModel new];
        section.dataArray = [kUserDefaults.vehicleCached copy];
        
        [sections addObject:section];
    }
    NSArray<TFTableSectionModel *> *mockData = [TFTableSectionModel tf_mj_objectArrayWithKeyValuesArray:self.mockData];
    if (mockData){
        [mockData enumerateObjectsUsingBlock:^(TFTableSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [sections addObject:obj];
        }];
    }
    self.dataArray = [sections copy];
    
    if (completion) {
        completion(0);
    }
}

@end
