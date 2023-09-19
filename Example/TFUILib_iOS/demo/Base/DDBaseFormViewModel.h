//
//  DDBaseFormViewModel.h
//  TFUILib_iOS_Example
//
//  Created by Ingeek-091 on 2023/9/16.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import <TFUILib_iOS/TFUILib_iOS.h>
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
#import "TFUserDefaults+demo.h"
#import "define_tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDBaseFormViewModel : TFFormViewModel

@property (nonatomic, copy, readonly) NSString *vin;
@property (nonatomic, copy, readonly) NSString *appId;

- (void)fetchData:(IntegerBlock)completion;

@end

NS_ASSUME_NONNULL_END
