//
//  DDShareKeyViewModel.h
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDBaseFormViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDShareKeyViewModel : DDBaseFormViewModel

- (void)shareKey:(NSDictionary *)form completion:(IntegerBlock)completion;

@end

NS_ASSUME_NONNULL_END
