//
//  DDHomeViewModel.h
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDBaseFormViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHomeViewModel : DDBaseFormViewModel

@property (nonatomic, assign, readonly) BOOL ibeaconEnable;

//- (void)feach:(VoidBlock)completion;
- (void)updateVIN:(NSString *)vin completion:(VoidBlock)completion;
- (void)addLog:(NSString *)log;

@end

NS_ASSUME_NONNULL_END
