//
//  DDLoginViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2020/7/19.
//  Copyright © 2020 SunXiaofei. All rights reserved.
//

#import "DDLoginViewController.h"
#import "DDNavigationController.h"
#import "DDHomeViewController.h"
#import "AppDelegate.h"
#import "DDLoginViewModel.h"

@interface DDLoginViewController ()

@property (nonatomic, strong) DDLoginViewModel *viewModel;

@end
@implementation DDLoginViewController
@dynamic viewModel;

- (void)bindData {
    [super bindData];
    
    NSString *userId = self.viewModel.userId;
    if ([userId isEmpty]) {
        [self assignFirstResponderOnShow];
    }
    XLFormRowDescriptor *row;
    row = [self.form formRowWithTag:kRowTag_userId];
    row.value = userId;
    [self reloadFormRow:row];
    
    NSString *mobile = self.viewModel.mobile;
    if (![mobile isEmpty]) {
        row = [self.form formRowWithTag:kRowTag_mobile];
        row.value = mobile;
        [self reloadFormRow:row];
    }
    
    NSString *appId = self.viewModel.appId;
    if (![appId isEmpty]) {
        row = [self.form formRowWithTag:kRowTag_appId];
        [self updateSelectorOption:row formValue:appId];
        [self reloadFormRow:row];
    }
    
    NSString *envriment = self.viewModel.envriment;
    if (![envriment isEmpty]) {
        row = [self.form formRowWithTag:kRowTag_envriment];
        [self updateSelectorOption:row formValue:envriment];
        [self reloadFormRow:row];
    }
    
    row = [self.form formRowWithTag:kRowTag_ibeaconEnable];
    row.value = @(self.viewModel.ibeaconEnable);
    [self reloadFormRow:row];
}

- (void)updateSelectorOption:(XLFormRowDescriptor *)row formValue:(id)formValue {
    [row.selectorOptions enumerateObjectsUsingBlock:^(XLFormOptionsObject *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if([model.formValue isEqual:formValue]) {
            row.value = [XLFormOptionsObject formOptionsObjectWithValue:model.formValue displayText:model.formDisplaytext];
        }
    }];
}

- (void)login {
    // do bussiness
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
    [self.viewModel login:self.formValues completion:^(NSInteger resultNumber, NSString *errorMsg) {
       
        if(!resultNumber) {
            [TF_APP_DELEGATE.window setRootViewController:[[DDNavigationController alloc] initWithRootViewController:[DDHomeViewController new]]];
            [TF_APP_DELEGATE.window makeKeyAndVisible];
        }
    }];
}
@end
