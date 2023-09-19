//
//  DDPreferencesViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import "DDPreferencesViewController.h"
#import "DDPreferencesViewModel.h"
#import "DDMessages.h"

@interface DDPreferencesViewController ()

@property (nonatomic, strong) DDPreferencesViewModel *viewModel;

@end

@implementation DDPreferencesViewController
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
    [self.viewModel save:self.form.formValues completion:^(NSInteger errorCode) {
        if (!errorCode) {
            [weakSelf showToast:TF_LSTR(TF_STRINGIFY(Set preferences success.))];
        } else {
            [weakSelf showToast:[NSString stringWithFormat: TF_LSTR(TF_STRINGIFY(Set preferences failed, error: %@)), EMSG(errorCode)]];
        }
        [weakSelf back];
    }];
}

@end
