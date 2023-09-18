//
//  DDDetailViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDDetailViewController.h"
#import "DDDetailViewModel.h"

@interface DDDetailViewController ()

@property (nonatomic, strong) DDDetailViewModel *viewModel;

@end

@implementation DDDetailViewController
@dynamic viewModel;

- (void)bindData {
    [super bindData];
    
    [self assignFirstResponderOnShow];
}

- (void)save {
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
    TF_WEAK_SELF
    [self.viewModel add:self.type form:self.formValues completion:^{
        [weakSelf back];
    }] ;
}

@end
