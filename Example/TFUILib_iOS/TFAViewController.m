//
//  TFViewController.m
//  TFUILib_iOS
//
//  Created by SunXiaofei on 07/19/2020.
//  Copyright (c) 2020 SunXiaofei. All rights reserved.
//

#import "TFAViewController.h"
#import "LoginViewController.h"
#import <TFUILib_iOS/TFUILib_iOS.h>
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
#import "TFAViewModel.h"

@interface TFAViewController ()

@property(nonatomic, strong) TFWebViewController *webVC;

@property (nonatomic, strong) TFAViewModel *viewModel;
@end

@implementation TFAViewController
@dynamic viewModel;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    UIButton *button;
//    button.contentHorizontalAlignment = 1;
}

- (void)initViews {
    return;
    [TFActionSheet showWithTitle:@"是否要删除" cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil block:nil];
    
    UIView *test = [UIView new];
    test.backgroundColor = UIColor.redColor;
    [self.view addSubview:test];
    
    [test tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    _webVC = [[TFWebViewController alloc] initWithResultBlock:nil];
    [_webVC loadURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self presentViewController:_webVC];
}

- (void)autolayoutViews {
    
}

- (void)bindData {
    [super bindData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStoryboard *)storyboardForRow:(XLFormRowDescriptor *)formRow
{
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

@end
