//
//  TFTableView.m
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFTableView.h"

@implementation TFTableView

-(void)registerCell:(Class)cellClass
{
    [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNib:(nullable Class)className {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:nil] forCellReuseIdentifier:NSStringFromClass(className)];
}

- (void)registerNibForHeaderFooterView:(nullable Class)className {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass(className)];
}

@end
