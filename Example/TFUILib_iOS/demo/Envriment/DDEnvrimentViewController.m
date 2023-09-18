//
//  DDEnvrimentViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import "DDEnvrimentViewController.h"
#import "DDEnvrimentViewModel.h"

@interface DDEnvrimentViewController ()

@property (nonatomic, strong) DDEnvrimentViewModel *viewModel;

@end

@implementation DDEnvrimentViewController
@dynamic viewModel;

- (void)rightButtonEvent {
    [UIViewController gotoAddViewController:AddTypeEnv];
}

@end
