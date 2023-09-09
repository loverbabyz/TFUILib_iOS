//
//  TFFormSectionModel.m
//  TFUILib
//
//  Created by Daniel on 7/9/23.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFFormSectionModel.h"

@implementation TFFormSectionModel
@dynamic dataArray;

+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"dataArray" : [TFFormRowModel class],
    };
}

@end
