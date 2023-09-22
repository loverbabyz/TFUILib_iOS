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

-(instancetype)init {
    if (@available(iOS 13.0, *)) {
        return [self initWithForm:nil style:UITableViewStyleInsetGrouped];
    } else {
        return [self initWithForm:nil style:UITableViewStyleGrouped];
    }
}

- (void)initViews {
    [super initViews];
}

- (void)updateRowOption:(XLFormRowDescriptor *)row formValue:(id)formValue {
    row.value = formValue;
    
    TF_WEAK_SELF
    TF_MAIN_THREAD(^(){
        [weakSelf reloadFormRow:row];
    });
}

- (void)updateSelectorOption:(XLFormRowDescriptor *)row formValue:(id)formValue {
    TF_WEAK_SELF
    TF_BACK_THREAD(^(){
        [row.selectorOptions enumerateObjectsUsingBlock:^(XLFormOptionsObject *model, NSUInteger idx, BOOL * _Nonnull stop) {
            if([model.formValue isEqual:formValue]) {
                row.value = [XLFormOptionsObject formOptionsObjectWithValue:model.formValue displayText:model.formDisplaytext];
            }
        }];
        
        TF_MAIN_THREAD(^(){
            [weakSelf reloadFormRow:row];
        });
    });
}

-(void)showFormValidationError:(NSError *)error {
    [self showToast:error.localizedDescription];
}

@end
