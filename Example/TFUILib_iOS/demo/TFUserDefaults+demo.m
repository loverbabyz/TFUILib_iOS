//
//  TFUserDefaults+demo.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/13.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "TFUserDefaults+demo.h"

@implementation DemoModel

@end

@implementation TFUserDefaults (demo)
@dynamic model;
@dynamic logLevel;
@dynamic vin;
@dynamic dispatch;

- (NSString *)transformKey:(NSString *)key {
    return [NSString stringWithFormat:@"userdefault_demo_app_%@", key];
}

- (void)logout {
    self.model = [DemoModel new];
    self.logLevel = 0;
    self.vin  = @"";
    self.dispatch = NO;
}

@end
