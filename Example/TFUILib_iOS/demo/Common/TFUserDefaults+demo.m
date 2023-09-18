//
//  TFUserDefaults+demo.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/13.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "TFUserDefaults+demo.h"

@implementation TFUserDefaults (demo)
@dynamic model;
@dynamic logLevel;
@dynamic vin;
@dynamic dispatchedOnMainQueue;
@dynamic sdkVersion;
@dynamic commitId;
@dynamic releaseDate;
@dynamic modelCached;
@dynamic appIdCached;
@dynamic envrimentCached;
@dynamic vehicleCached;

- (NSDictionary *)setupDefaults {
    return @{
        @"dispatchedOnMainQueue": @YES,
        @"logLevel": @1,
    };
}

- (NSString *)transformKey:(NSString *)key {
    return [NSString stringWithFormat:@"userdefault_demo_app_%@", key];
}

- (void)login:(DDDemoModel *)model {
    if (!model) {
        return;
    }
    
    self.model = model;
    
    __block BOOL exist = NO;
    [self.modelCached enumerateObjectsUsingBlock:^(DDDemoModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.userId isEqualToString:model.userId] && [obj.mobile isEqualToString:model.mobile]) {
            exist = YES;
            *stop = exist;
        }
    }];
    
    if (exist) {
        return;
    }
    
    NSMutableArray *models = [NSMutableArray arrayWithArray:self.modelCached];
    [models addObject:model];
    self.modelCached = models.copy;
}

- (void)logout {
    self.model = nil;
    self.logLevel = 1;
    self.vin  = @"";
}

- (void)addAppId:(TFTableRowModel *)model {
    if (!model) {
        return;
    }

    __block BOOL exist = NO;
    
    [self.appIdCached enumerateObjectsUsingBlock:^(TFTableRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identity isEqualToString:model.identity] && [obj.title isEqualToString:model.title]) {
            exist = YES;
            *stop = exist;
        }
    }];
    
    if (exist) {
        return;
    }
    
    NSMutableArray *models = [NSMutableArray arrayWithArray:self.appIdCached];
    [models addObject:model];
    self.appIdCached = models.copy;
}
- (void)addEnvriment:(TFTableRowModel *)model {
    if (!model) {
        return;
    }

    __block BOOL exist = NO;
    
    [self.envrimentCached enumerateObjectsUsingBlock:^(TFTableRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identity isEqualToString:model.identity] && [obj.title isEqualToString:model.title]) {
            exist = YES;
            *stop = exist;
        }
    }];
    
    if (exist) {
        return;
    }
    
    NSMutableArray *models = [NSMutableArray arrayWithArray:self.envrimentCached];
    [models addObject:model];
    self.envrimentCached = models.copy;
}

- (void)addVehicle:(TFTableRowModel *)model {
    if (!model) {
        return;
    }

    __block BOOL exist = NO;
    
    [self.vehicleCached enumerateObjectsUsingBlock:^(TFTableRowModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identity isEqualToString:model.identity] && [obj.title isEqualToString:model.title]) {
            exist = YES;
            *stop = exist;
        }
    }];
    
    if (exist) {
        return;
    }
    
    NSMutableArray *models = [NSMutableArray arrayWithArray:self.vehicleCached];
    [models addObject:model];
    self.vehicleCached = models.copy;
}

@end
