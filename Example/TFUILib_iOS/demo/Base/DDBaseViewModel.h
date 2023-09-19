//
//  DDBaseViewModel.h
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import <TFUILib_iOS/TFUILib_iOS.h>
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
#import "TFUserDefaults+demo.h"
#import "define_tag.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDBaseViewModel : TFViewModel

@property (nonatomic, copy, readonly) NSString *vin;
@property (nonatomic, copy, readonly) NSString *appId;

- (void)fetchData:(IntegerBlock)completion;

@end

NS_ASSUME_NONNULL_END
