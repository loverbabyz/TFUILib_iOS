//
//  DDHomeViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDHomeViewController.h"
#import "DDHomeViewModel.h"

@interface DDHomeViewController ()

@property (nonatomic, strong) DDHomeViewModel *viewModel;

@end

@implementation DDHomeViewController
@dynamic viewModel;

- (void)bindData {
    [super bindData];
    
    NSString *vin = self.viewModel.vin;
    if ([vin isEmpty]) {
        [self assignFirstResponderOnShow];
    }
    
    XLFormRowDescriptor *row = [self.form formRowWithTag:kRowTag_VIN];
    row.value = vin;
    [self reloadFormRow:row];
}

#pragma mark - method

- (void)exportLog {
    tf_showToast(@"exportLog");
}

- (void)enableKey {
    tf_showToast(@"enableKey");
}

- (void)keyStatus {
    tf_showToast(@"keyStatus");
}

- (void)revokeKey {
    tf_showToast(@"revokeKey");
}

- (void)connect {
    tf_showToast(@"connect");
}

- (void)connectStatus {
    tf_showToast(@"connectStatus");
}

- (void)disconnect {
    tf_showToast(@"disconnect");
}

- (void)lock {
    tf_showToast(@"lock");
}

- (void)unlock {
    tf_showToast(@"unlock");
}

#pragma mark - onChangeBlock

- (void)vinChanged:(id)newValue {
    if (newValue) {
        [self.viewModel updateVIN:newValue completion:^{
            
        }];
    }
}

- (void)levelChanged:(id)newValue {
    XLFormOptionsObject *obj = newValue;
    tf_showToast([NSString stringWithFormat:@"levelChanged:%@", obj.formValue]);
}

#pragma mark - Predicate

- (id)vinPredicate {
    NSString *vinRegex = @"(\\w{6})";
    return [NSString stringWithFormat:@"NOT ($%@.value contains[c] 'P')", @"VIN"];
}

- (id)mc01Predicate {
    return @(![self.viewModel.appId isEqualToString:kRowTag_MC01]);
}

@end
