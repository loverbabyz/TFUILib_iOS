//
//  DDOwnerKeysViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDOwnerKeysViewController.h"
#import "DDOwnerKeysViewModel.h"
#import "DDKeyTableViewCell.h"
#import "Messages.h"

@interface DDOwnerKeysViewController ()

@property (nonatomic, strong) DDOwnerKeysViewModel *viewModel;

@end

@implementation DDOwnerKeysViewController
@dynamic viewModel;

- (void)initViews {
    [super initViews];
    
    [self hideRightButton];
}

- (void)bindData {
    [super bindData];
    
    [self loadNewData];
}

- (void)registerCell {
    [super registerCell];
    
    self.defaultCell = [DDKeyTableViewCell class];
}

- (void)loadNewData {
    [super loadNewData];
    
    TF_WEAK_SELF
    [self.viewModel fetchData:^(NSInteger errorCode) {
        [weakSelf endLoadData];
        
        if (errorCode) {
            NSString *msg = [NSString stringWithFormat:
                             TF_LSTR(@"Get keys failed : error: %@"), EMSG(errorCode)];
            [weakSelf showToast:msg];
            
            return;
        }
        
        if ([weakSelf.viewModel isEmpty]) {
            [weakSelf showEmpty];
            
            return;
        }
        
        [weakSelf.tableView reloadData];
    }];
}

- (void)handleData:(TFTableRowModel *)data {
#ifdef kFeature_JXA
    IngeekBleLimitedKey *limitedKey = (IngeekBleLimitedKey *)data.webModel;
    UIAlertController *alertVC = [[UIAlertController alloc] init];
    UIAlertAction *revokeAction = [UIAlertAction
                                   actionWithTitle:TF_LSTR(@"Redeem this Key")
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction * _Nonnull action) {
        __weak typeof(self) weakSelf = self;
        
        [[IngeekBle sharedInstance] redeemKey:limitedKey.pid keyId:limitedKey.keyId completion:^(NSInteger errorCode) {
            if (!errorCode) {
                [weakSelf showMessageView:TF_LSTR(@"RedeemKey success.")
                             duration:2
                                color:kSuccessColor];
            } else {
                NSString *msg = [NSString stringWithFormat:
                                 TF_LSTR(@"RedeemKey failed : %@"), EMSG(errorCode)];
                [weakSelf showMessageView:msg duration:2 color:kErrorColor];
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
    alertVC.title = TF_LSTR(@"Redeem this Key");
    [alertVC addAction:revokeAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
#endif
}

@end
