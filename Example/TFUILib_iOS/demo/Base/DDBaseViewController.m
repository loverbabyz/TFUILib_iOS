//
//  DDBaseViewController.m
//  TFUILib_iOS_Example
//
//  Created by Ingeek-091 on 2023/9/16.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDBaseViewController.h"

@interface DDBaseViewController ()

@end

@implementation DDBaseViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateRowOption:(XLFormRowDescriptor *)row formValue:(id)formValue {
    row.value = formValue;
    
    [self reloadFormRow:row];
}

- (void)updateSelectorOption:(XLFormRowDescriptor *)row formValue:(id)formValue {
    [row.selectorOptions enumerateObjectsUsingBlock:^(XLFormOptionsObject *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if([model.formValue isEqual:formValue]) {
            row.value = [XLFormOptionsObject formOptionsObjectWithValue:model.formValue displayText:model.formDisplaytext];
        }
    }];
    
    [self reloadFormRow:row];
}

-(void)showFormValidationError:(NSError *)error {
    [self showToast:error.localizedDescription];
}

@end
