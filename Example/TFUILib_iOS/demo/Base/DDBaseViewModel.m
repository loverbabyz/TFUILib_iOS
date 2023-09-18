//
//  DDBaseViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDBaseViewModel.h"

@implementation DDBaseViewModel

- (void)fetchData:(IntegerBlock)completion {
    // 父类不做具体实现
    // 由子类实现具体业务
    NSCAssert(NO, TF_STRINGIFY(由子类实现具体业务));
}

- (NSString *)vin {
    return kUserDefaults.vin;
}

- (NSString *)appId {
    return kUserDefaults.model.appId;
}

@end
