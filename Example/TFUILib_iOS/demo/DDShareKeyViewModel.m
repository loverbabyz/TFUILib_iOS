//
//  DDShareKeyViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDShareKeyViewModel.h"
#import "TFUserDefaults+demo.h"

@implementation DDShareKeyViewModel

- (NSString *)vin {
    return kUserDefaults.vin;
}

@end
