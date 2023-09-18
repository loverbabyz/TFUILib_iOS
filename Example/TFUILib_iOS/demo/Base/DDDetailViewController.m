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
    
    /// TODO:
    switch (self.type) {
        case AddTypeVehicel:
            {
                
            }
            break;
            
        case AddTypeAppId:
            {
                
            }
            break;
            
        case AddTypeEnv:
            {
                
            }
            break;
            
        default:
            break;
    }
}

@end
