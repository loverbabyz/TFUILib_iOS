//
//  DDDetailViewModel.h
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDBaseFormViewModel.h"
#import "define_enum.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDDetailViewModel : DDBaseFormViewModel

- (void)add:(AddType)type form:(NSDictionary *)form completion:(VoidBlock)completion;

@end

NS_ASSUME_NONNULL_END
