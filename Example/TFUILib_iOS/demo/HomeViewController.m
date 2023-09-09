//
//  HomeViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)bindData {
    [super bindData];
    
    self.form.assignFirstResponderOnShow = YES;
}

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

- (void)levelChanged:(id)newValue {
    XLFormOptionsObject *obj = newValue;
    tf_showToast([NSString stringWithFormat:@"levelChanged:%@", obj.formValue]);
}
@end
