//
//  DDBaseViewController.h
//  TFUILib_iOS_Example
//
//  Created by Ingeek-091 on 2023/9/16.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
#import <TFUILib_iOS/TFUILib_iOS.h>
#import "UIViewController+goto.h"
#import "define_tag.h"

NS_ASSUME_NONNULL_BEGIN

/// <#Description#>
@interface DDBaseViewController : TFFormViewController

/// <#Description#>
/// - Parameters:
///   - row: <#row description#>
///   - formValue: <#formValue description#>
- (void)updateRowOption:(XLFormRowDescriptor *)row formValue:(id)formValue;

/// <#Description#>
/// - Parameters:
///   - row: <#row description#>
///   - formValue: <#formValue description#>
- (void)updateSelectorOption:(XLFormRowDescriptor *)row formValue:(id)formValue;

@end

NS_ASSUME_NONNULL_END
