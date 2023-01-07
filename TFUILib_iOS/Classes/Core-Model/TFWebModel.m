//
//  TFWebViewModel.m
//  TFUILib
//
//  Created by Daniel on 15/10/29.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFWebModel.h"

@implementation TFWebModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _showProgressView = YES;
        _canMulilayerBack = YES;
    }

    return self;
}

@end
