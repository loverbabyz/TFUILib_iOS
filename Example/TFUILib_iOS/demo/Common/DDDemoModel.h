//
//  DDDemoModel.h
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import <TFUILib_iOS/TFUILib_iOS.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDDemoModel : TFModel

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *envriment;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) BOOL ibeaconEnable;

@end

NS_ASSUME_NONNULL_END
