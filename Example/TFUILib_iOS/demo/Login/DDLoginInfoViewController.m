//
//  DDLoginInfoViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDLoginInfoViewController.h"
#import "DDLoginInfoViewModel.h"
#import "DDDemoModel.h"
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>

@interface DDLoginInfoViewController ()

@property (nonatomic, strong) DDLoginInfoViewModel *viewModel;

@end

@implementation DDLoginInfoViewController
@dynamic viewModel;

- (void)handleData:(TFTableRowModel *)data {
    [super handleData:data];
    
    DDDemoModel *model = [DDDemoModel new];
    model.userId = data.title;
    model.mobile = data.content;
    
    TF_POST_NOTIFICATION(DDLoginInfoSelectedNotification, model, nil);
}

@end
