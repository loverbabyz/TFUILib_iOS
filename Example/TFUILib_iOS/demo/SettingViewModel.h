//
//  SettingViewModel.h
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import <TFUILib_iOS/TFUILib_iOS.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingViewModel : TFFormViewModel

@property (nonatomic, readonly, copy) NSString *appId;
@property (nonatomic, readonly, copy) NSString *envriment;
@property (nonatomic, readonly, copy) NSString *userId;
@property (nonatomic, readonly, copy) NSString *mobile;
@property (nonatomic, readonly, assign) BOOL dispatch;
@property (nonatomic, readonly, assign) NSInteger logLevel;

- (void)save:(NSDictionary *)form completion:(IntegerMsgBlock)completion;
- (void)logout:(IntegerMsgBlock)completion;

@end

NS_ASSUME_NONNULL_END
