//
//  DDFobKeysViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDFobKeysViewController.h"
#import "DDFobKeysViewModel.h"
#import "DDFobKeysViewCell.h"

@interface DDFobKeysViewController ()

@property (nonatomic, strong) DDFobKeysViewModel *viewModel;

@end

@implementation DDFobKeysViewController
@dynamic viewModel;

- (void)registerCell {
    [super registerCell];
    
    self.defaultCell = [DDFobKeysViewCell class];
}

- (void)handleData:(TFTableRowModel *)data {
    
}

@end
