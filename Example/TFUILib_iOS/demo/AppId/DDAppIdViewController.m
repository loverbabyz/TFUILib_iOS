//
//  DDAppIdViewController.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import "DDAppIdViewController.h"
#import "DDAppIdViewModel.h"

@interface DDAppIdViewController ()

@property (nonatomic, strong) DDAppIdViewModel *viewModel;

@end

@implementation DDAppIdViewController
@dynamic viewModel;

- (void)rightButtonEvent {
    [UIViewController gotoAddViewController:AddTypeAppId];
}

@end
