//
//  DDPreferencesViewModel.h
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import "DDBaseFormViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDPreferencesViewModel : DDBaseFormViewModel

- (void)save:(NSDictionary *)form completion:(IntegerBlock)completion;

@end

NS_ASSUME_NONNULL_END
