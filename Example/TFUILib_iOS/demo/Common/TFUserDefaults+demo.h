//
//  TFUserDefaults+demo.h
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/13.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import <TFUILib_iOS/TFUILib_iOS.h>
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
#import "DDDemoModel.h"

#define kUserDefaults ([TFUserDefaults standardUserDefaults])
@interface TFUserDefaults (demo)

@property (nonatomic, strong) DDDemoModel *model;

@property (nonatomic, copy) NSString *vin;
@property (nonatomic, assign) NSInteger logLevel;
@property (nonatomic, assign) BOOL dispatchedOnMainQueue;

@property (nonatomic, copy) NSString *sdkVersion;
@property (nonatomic, copy) NSString *commitId;
@property (nonatomic, copy) NSString *releaseDate;

@property (nonatomic, strong) NSArray<DDDemoModel *> *modelCached;
@property (nonatomic, strong) NSArray<TFTableRowModel *> *appIdCached;
@property (nonatomic, strong) NSArray<TFTableRowModel *> *envrimentCached;
@property (nonatomic, strong) NSArray<TFTableRowModel *> *vehicleCached;

- (void)login:(DDDemoModel *)model;
- (void)logout;

- (void)addAppId:(TFTableRowModel *)model;
- (void)addEnvriment:(TFTableRowModel *)model;
- (void)addVehicle:(TFTableRowModel *)model;

@end
