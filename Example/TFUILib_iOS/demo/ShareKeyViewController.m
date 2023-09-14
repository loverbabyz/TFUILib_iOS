//
//  ShareKeyViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "ShareKeyViewController.h"
#import "ShareKeyViewModel.h"

@interface ShareKeyViewController ()

@property (nonatomic, strong) ShareKeyViewModel *viewModel;

@end

@implementation ShareKeyViewController
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
}

@end
