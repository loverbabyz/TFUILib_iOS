//
//  TFSectionModel.m
//  TFUILib
//
//  Created by xiayiyong on 16/3/11.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFTableSectionModel.h"


@implementation TFTableSectionModel

- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray<__kindof TFTableRowModel *> *)dataArray {
    if (self = [super init]) {
        self.title = title;
        _dataArray = dataArray;
    }
    
    return self;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"dataArray" : [TFTableRowModel class]};
}

@end
