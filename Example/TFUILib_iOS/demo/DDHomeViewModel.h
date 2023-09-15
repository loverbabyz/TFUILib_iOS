//
//  DDHomeViewModel.h
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDHomeViewModel : DDBaseViewModel

@property (nonatomic, copy) NSString *vin;
@property (nonatomic, copy) NSString *appId;

//- (void)feach:(VoidBlock)completion;
- (void)updateVIN:(NSString *)vin completion:(VoidBlock)completion;

@end

NS_ASSUME_NONNULL_END
