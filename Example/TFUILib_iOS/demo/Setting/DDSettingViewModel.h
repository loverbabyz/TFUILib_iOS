//
//  DDSettingViewModel.h
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDBaseFormViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDSettingViewModel : DDBaseFormViewModel

- (void)save:(NSDictionary *)form completion:(VoidBlock)completion;
- (void)logout:(VoidBlock)completion;

@end

NS_ASSUME_NONNULL_END
