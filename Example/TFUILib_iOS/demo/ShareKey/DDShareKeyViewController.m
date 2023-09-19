//
//  DDShareKeyViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDShareKeyViewController.h"
#import "DDShareKeyViewModel.h"
#import "DDMessages.h"

@interface DDShareKeyViewController ()

@property (nonatomic, strong) DDShareKeyViewModel *viewModel;

@end

@implementation DDShareKeyViewController
@dynamic viewModel;

- (void)bindData {
    [super bindData];
    
    NSString *vin = self.viewModel.vin;
    XLFormRowDescriptor *row = [self.form formRowWithTag:kRowTag_VIN];
    row.value = vin;
    [self reloadFormRow:row];
    
    [self assignFirstResponderOnShow];
}

- (void)shareKey {
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
    TF_WEAK_SELF
    [self.viewModel shareKey:self.formValues completion:^(NSInteger errorCode) {
        if (!errorCode) {
            [self showToast:TF_LSTR(@"Share success.")];
            [weakSelf back];
        } else {
            NSString *msg = [NSString stringWithFormat:TF_LSTR(@"Share failed, error: %@"), EMSG(errorCode)];
            [self showToast:msg];
        }
    }];
}

@end
