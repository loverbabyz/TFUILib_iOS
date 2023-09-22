//
//  DDBaseTableViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDBaseTableViewController.h"
#import "DDDefaultViewCell.h"
#import "DDBaseViewModel.h"

@interface DDBaseTableViewController ()

@property (nonatomic, strong) DDBaseViewModel *viewModel;

@end

@implementation DDBaseTableViewController
@dynamic viewModel;
@synthesize rowDescriptor = _rowDescriptor;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) init {
    if (@available(iOS 13.0, *)) {
        return [self initWithStyle:UITableViewStyleInsetGrouped];
    } else {
        return [super init];
    }
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadNewData];
}

- (void)loadNewData {
    [super loadNewData];
    
    TF_WEAK_SELF
    [self.viewModel fetchData:^(NSInteger errorCode) {
        [weakSelf endLoadData];
        
        if ([weakSelf.viewModel isEmpty]) {
            return;
        }
        TF_MAIN_THREAD(^(){
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void)showHud {
    
}

- (void)showEmpty {
    [self showToast:TF_LSTR(@"Empty data")];
}

#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    static CGFloat height = 10.0;
    
    return height;
}

@end
