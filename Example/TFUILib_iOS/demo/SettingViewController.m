//
//  SettingViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "SettingViewController.h"
#import "NavigationController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SettingViewModel.h"

@interface SettingViewController ()

@property (nonatomic, strong) SettingViewModel *viewModel;

@end

@implementation SettingViewController
@dynamic viewModel;

- (void)bindData {
    [super bindData];
    
    NSString *appId = self.viewModel.appId;
    XLFormRowDescriptor *row = [self.form formRowWithTag:kRowTag_appId];
    row.value = appId;
    [self reloadFormRow:row];
    
    NSString *envriment = self.viewModel.envriment;
    row = [self.form formRowWithTag:kRowTag_envriment];
    row.value = envriment;
    [self reloadFormRow:row];
    
    row = [self.form formRowWithTag:kRowTag_userId];
    row.value = self.viewModel.userId;
    [self reloadFormRow:row];
    
    row = [self.form formRowWithTag:kRowTag_mobile];
    row.value = self.viewModel.mobile;
    [self reloadFormRow:row];
    
    row = [self.form formRowWithTag:kRowTag_dispatch];
    row.value = @(self.viewModel.dispatch);
    [self reloadFormRow:row];
    
    row = [self.form formRowWithTag:kRowTag_logLevel];
    [self updateSelectorOption:row formValue:[NSString stringWithFormat:@"%@",  @(self.viewModel.logLevel)]];
    [self reloadFormRow:row];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
}

- (void)updateSelectorOption:(XLFormRowDescriptor *)row formValue:(id)formValue {
    [row.selectorOptions enumerateObjectsUsingBlock:^(XLFormOptionsObject *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if([model.formValue isEqual:formValue]) {
            row.value = [XLFormOptionsObject formOptionsObjectWithValue:model.formValue displayText:model.formDisplaytext];
        }
    }];
}

-(void)savePressed:(UIBarButtonItem * __unused)button {
    [self.tableView endEditing:YES];
    
    __weak __typeof(&*self)weakSelf = self;
    [self.viewModel save:self.form.formValues completion:^(NSInteger resultNumber, NSString *errorMsg) {
        tf_showToast(@"Done");
        [weakSelf back];
    }];
}

-(void)cancelPressed:(UIBarButtonItem * __unused)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logout {
    [self.viewModel logout:^(NSInteger resultNumber, NSString *errorMsg) {
        tf_showToast(@"logout");
        [TF_APP_DELEGATE.window setRootViewController:[[NavigationController alloc] initWithRootViewController:[LoginViewController new]]];
        [TF_APP_DELEGATE.window makeKeyAndVisible];
    }];
}

@end
