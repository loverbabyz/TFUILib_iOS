//
//  DDBaseViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Ingeek-091 on 2023/9/16.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDBaseFormViewModel.h"

@implementation DDBaseFormViewModel

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
