//
//  ShareKeyViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "ShareKeyViewController.h"

@interface ShareKeyViewController ()

@end

@implementation ShareKeyViewController

- (void)bindData {
    [super bindData];
    
    self.form.assignFirstResponderOnShow = YES;
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
