//
//  TFViewController.m
//  TFUILib_iOS
//
//  Created by SunXiaofei on 07/19/2020.
//  Copyright (c) 2020 SunXiaofei. All rights reserved.
//

#import "TFAViewController.h"
#import "TFTestViewController.h"

#import <TFUILib_iOS/TFUILib_iOS.h>

@interface TFAViewController ()

@property(nonatomic, strong) TFWebViewController *webVC;

@end

@implementation TFAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [TFActionSheet showWithTitle:@"是否要删除" cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil block:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIView *test = [UIView new];
    test.backgroundColor = UIColor.redColor;
    [self.view addSubview:test];
    
    [test tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    return;
    _webVC = [[TFWebViewController alloc] initWithResultBlock:nil];
    [_webVC loadURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self presentViewController:_webVC];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
