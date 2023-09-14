//
//  LoginViewModel.h
//  TFUILib_iOS_Example
//
//  Created by Ingeek-091 on 2023/9/6.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import <TFUILib_iOS/TFUILib_iOS.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : TFFormViewModel

@property (nonatomic, readonly, copy) NSString *appId;
@property (nonatomic, readonly, copy) NSString *envriment;
@property (nonatomic, readonly, copy) NSString *userId;
@property (nonatomic, readonly, copy) NSString *mobile;
@property (nonatomic, readonly, assign) BOOL ibeaconEnable;

- (void)login:(NSDictionary *)form completion:(IntegerMsgBlock)completion;

@end

NS_ASSUME_NONNULL_END
