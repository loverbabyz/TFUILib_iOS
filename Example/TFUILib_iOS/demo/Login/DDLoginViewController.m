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
#import "DDDemoModel.h"
#import "Messages.h"

@interface DDLoginViewController ()

@property (nonatomic, strong) DDLoginViewModel *viewModel;

@end
@implementation DDLoginViewController
@dynamic viewModel;

- (void)initViews {
    [super initViews];
    
    [self initRightTitle:TF_LSTR(@"switchUser")];
}

- (void)bindData {
    [super bindData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginInfoSelected:)
                                                 name:DDLoginInfoSelectedNotification
                                               object:nil];
    
    NSString *userId = self.viewModel.userId;
    if ([userId isEmpty]) {
        [self assignFirstResponderOnShow];
    }
}

- (void)rightButtonEvent {
    [UIViewController gotoLoginInfoViewController];
}

- (void)loginInfoSelected:(NSNotification *)notification {
    DDDemoModel *model = (DDDemoModel *)notification.object;
    
    if (!model || ! [model isKindOfClass:[DDDemoModel class]]) {
        return;
    }
    
    [self updateRowOption:[self.form formRowWithTag:kRowTag_userId] formValue:model.userId];
    [self updateRowOption:[self.form formRowWithTag:kRowTag_mobile] formValue:model.mobile];
}

- (void)login {
    // do bussiness
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
    TF_WEAK_SELF
    [self.viewModel login:self.formValues completion:^(NSInteger resultNumber) {
        if(resultNumber) {
            [weakSelf showToast:EMSG(resultNumber)];
            
            return;
        }
        
        [UIViewController gotoRootViewController];
    }];
}
@end
