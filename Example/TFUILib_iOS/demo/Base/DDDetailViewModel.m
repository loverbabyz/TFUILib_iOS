//
//  DDDetailViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDDetailViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDDetailViewModel

- (void)add:(AddType)type form:(NSDictionary *)form completion:(VoidBlock)completion {
    TFTableRowModel *model = [TFTableRowModel tf_mj_objectWithKeyValues:form];
    model.content = model.identity;
    
    switch (type) {
        case AddTypeEnv:
            {
                [kUserDefaults addEnvriment:model];
            }
            break;
            
        case AddTypeAppId:
            {
                [kUserDefaults addAppId:model];
            }
            break;
            
        case AddTypeVehicel:
            {
                [kUserDefaults addVehicle:model];
            }
            break;
            
        default:
            break;
    }
    
    if (completion) {
        completion();
    }
}

@end
