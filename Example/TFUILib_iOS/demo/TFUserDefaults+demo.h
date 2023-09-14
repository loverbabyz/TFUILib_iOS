//
//  TFUserDefaults+demo.h
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/13.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import <TFBaseLib_iOS/TFBaseLib_iOS.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoModel : TFModel

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *envriment;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) BOOL ibeaconEnable;

@end

#define kUserDefaults ([TFUserDefaults standardUserDefaults])
@interface TFUserDefaults (demo)

@property (nonatomic, strong) DemoModel *model;

@property (nonatomic, copy) NSString *vin;
@property (nonatomic, assign) NSInteger logLevel;
@property (nonatomic, assign) BOOL dispatch;

- (void)logout;

@end

NS_ASSUME_NONNULL_END
