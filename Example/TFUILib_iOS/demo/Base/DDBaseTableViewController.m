//
//  DDBaseTableViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDBaseTableViewController.h"
#import "DDDefaultViewCell.h"

@interface DDBaseTableViewController ()

@end

@implementation DDBaseTableViewController
@synthesize rowDescriptor = _rowDescriptor;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initViews {
    [super initViews];
    
    [self initRightTitle:TF_LSTR(@"Add")];
    [self showRefreshHeader];
}

- (void)registerCell {
    self.defaultCell = [DDDefaultViewCell class];
}

- (void)handleData:(TFTableRowModel *)data {
    self.rowDescriptor.value = data;
    [self back];
}

- (void)showEmpty {
    [self showToast:TF_LSTR(@"Empty data")];
}

@end
