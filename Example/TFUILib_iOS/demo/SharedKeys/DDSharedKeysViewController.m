//
//  DDSharedKeysViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDSharedKeysViewController.h"
#import "DDSharedKeysViewModel.h"
#import <IngeekDK/IngeekDK.h>
#import "DDMessages.h"

@interface DDSharedKeysViewController ()

@property (nonatomic, strong) DDSharedKeysViewModel *viewModel;

@end

@implementation DDSharedKeysViewController
@dynamic viewModel;

- (void)handleData:(TFTableRowModel *)data {
    IngeekBleLimitedKey *limitedKey = (IngeekBleLimitedKey *)data.webModel;
    UIAlertController *alertVC = [[UIAlertController alloc] init];
    UIAlertAction *revokeAction = [UIAlertAction
                                   actionWithTitle:TF_LSTR(@"Revoke this Key")
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * _Nonnull action) {
        __weak typeof(self) weakSelf = self;
        [[IngeekBle sharedInstance] revokeKey:limitedKey.pid
                                        keyId:limitedKey.keyId
                                   completion:^(NSInteger errorCode) {
            if (!errorCode) {
                [weakSelf showToast:TF_LSTR(@"Revoke success.")];
            } else {
                NSString *msg = [NSString stringWithFormat:
                                 TF_LSTR(@"Revoke failed : %@"), EMSG(errorCode)];
                [weakSelf showToast:msg];
            }
            
            // Reload keys
//            [weakSelf getKeys];
            // Dismiss
            [alertVC dismissViewControllerAnimated:YES completion:nil];
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:TF_LSTR(@"Cancel")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction * _Nonnull action) {
        [alertVC dismissViewControllerAnimated:YES completion:^{
            [self.tableView reloadData];
        }];
    }];
    alertVC.title = TF_LSTR(@"Revoke Key");
    [alertVC addAction:revokeAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
