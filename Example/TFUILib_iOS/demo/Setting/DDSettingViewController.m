//
//  DDSettingViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDSettingViewController.h"
#import "DDNavigationController.h"
#import "DDLoginViewController.h"
#import "AppDelegate.h"
#import "DDSettingViewModel.h"

@interface DDSettingViewController ()

@property (nonatomic, strong) DDSettingViewModel *viewModel;

@end

@implementation DDSettingViewController
@dynamic viewModel;

- (void)initViews {
    [self initRightTitle:TF_LSTR(@"Save")];
}

- (void)bindData {
    [self.viewModel fetchData:^(NSInteger resultNumber) {
        [super bindData];
    }];
}

- (void)rightButtonEvent {
    [self.tableView endEditing:YES];
    
    TF_WEAK_SELF
    [self.viewModel save:self.form.formValues completion:^() {
        
        [weakSelf showToast:TF_LSTR(@"Done")];
        [weakSelf back];
    }];
}

-(void)cancelPressed:(UIBarButtonItem * __unused)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logout {
    [self.viewModel logout:^() {
        [UIViewController gotoLoginViewController];
    }];
}

@end
