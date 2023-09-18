//
//  DDNFCKeysViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDNFCKeysViewController.h"
#import "DDNFCKeysViewModel.h"
#import "DDNFCKeysViewCell.h"

@interface DDNFCKeysViewController ()

@property (nonatomic, strong) DDNFCKeysViewModel *viewModel;

@end

@implementation DDNFCKeysViewController
@dynamic viewModel;

- (void)registerCell {
    [super registerCell];
    
    self.defaultCell = [DDNFCKeysViewCell class];
}

- (void)handleData:(TFTableRowModel *)data {
    
}

@end
