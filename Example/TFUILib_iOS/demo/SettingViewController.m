//
//  SettingViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

-(void)cancelPressed:(UIBarButtonItem * __unused)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logLevelChanged:(id)newValue {
    XLFormOptionsObject *obj = newValue;
    tf_showToast([NSString stringWithFormat:@"logLevelChanged:%@", obj.formValue]);
}

- (void)dispatchedChanged:(id)newValue {
    tf_showToast([NSString stringWithFormat:@"dispatchedChanged:%@", newValue]);
}

- (void)logout {
    tf_showToast(@"logout");
}

@end
