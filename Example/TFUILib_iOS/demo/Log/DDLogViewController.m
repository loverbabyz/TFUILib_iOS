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
    
    [self initRightTitle:TF_LSTR(@"Reset")];
}

- (void)registerCell {
    [super registerCell];
    
    self.defaultCell = [DDDefaultViewCell class];
}

- (void)rightButtonEvent {
    [self.tableView endEditing:YES];
    
    TF_WEAK_SELF
    [self.viewModel cleanLog:^{
        [TFGCDQueue executeInMainQueue:^{
            [weakSelf loadNewData];
        } afterDelaySecs:1];
    }];
}

- (void)bindData {
    [super bindData];
    
}

- (void)handleData:(TFTableRowModel *)data {
    
}

#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TFTableRowModel *row = [self.viewModel dataAtIndexPath:indexPath];
    
    CGFloat contentHight = [row.content boundingRectWithSize: CGSizeMake ((TF_SCREEN_WIDTH - 51.33), MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                                  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.height;
    return MAX(contentHight + 4.0, 61.281);
}

@end
