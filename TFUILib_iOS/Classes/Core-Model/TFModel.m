//
//  TFModel.m
//  TFUILib
//
//  Created by xiayiyong on 16/1/14.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFModel.h"

@implementation TFModel

- (NSString *)title {
    if (!_title || _title.length == 0) {
        _title = @"";
    }
    
    return _title;
}

@end
