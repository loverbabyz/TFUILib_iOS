//
//  DDLogViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/15.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDLogViewController.h"
#import "DDLogViewModel.h"
#import "DDDefaultViewCell.h"

@interface DDLogViewController ()

@property (nonatomic, strong) DDLogViewModel *viewModel;

@end

@implementation DDLogViewController
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
    
    self.defaultCell = [DDDefaultViewCell class];
}

- (void)loadNewData {
    [super loadNewData];
    
    TF_WEAK_SELF
    [self.viewModel fetchData:^(NSInteger errorCode) {
        [weakSelf endLoadData];
        
        if ([weakSelf.viewModel isEmpty]) {
            [weakSelf showEmpty];
            
            return;
        }
        [weakSelf.tableView reloadData];
    }];
}

- (void)handleData:(TFTableRowModel *)data {
    
}

#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TFTableRowModel *row = [self.viewModel dataAtIndexPath:indexPath];
    
    CGFloat contentHight = [row.content boundingRectWithSize: CGSizeMake ((TF_SCREEN_WIDTH - 55), MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
    return contentHight + 4.0;
}

@end
