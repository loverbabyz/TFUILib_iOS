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

/// <#Description#>
@property (nonatomic, assign, readonly) BOOL ibeaconEnable;

/// <#Description#>
/// - Parameters:
///   - vin: <#vin description#>
///   - completion: <#completion description#>
- (void)updateVIN:(NSString *)vin completion:(BoolBlock)completion;

/// <#Description#>
/// - Parameter log: <#log description#>
- (void)addLog:(NSString *)log;

@end

NS_ASSUME_NONNULL_END
