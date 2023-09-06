//
//  TFViewController.m
//  TFUILib_iOS
//
//  Created by SunXiaofei on 07/19/2020.
//  Copyright (c) 2020 SunXiaofei. All rights reserved.
//

#import "TFAViewController.h"
#import "TFTestViewController.h"
#import "TFTestViewController.h"
#import <TFUILib_iOS/TFUILib_iOS.h>
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
#import "TFAViewModel.h"

NSString * const kTextFieldAndTextView = @"TextFieldAndTextView";
NSString * const kSelectors = @"Selectors";
NSString * const kOthes = @"Others";
NSString * const kDates = @"Dates";
NSString * const kPredicates = @"BasicPredicates";
NSString * const kBlogExample = @"BlogPredicates";
NSString * const kMultivalued = @"Multivalued";
NSString * const kMultivaluedOnlyReorder = @"MultivaluedOnlyReorder";
NSString * const kMultivaluedOnlyInsert = @"MultivaluedOnlyInsert";
NSString * const kMultivaluedOnlyDelete = @"MultivaluedOnlyDelete";
NSString * const kValidations= @"Validations";
NSString * const kFormatters = @"Formatters";

@interface TFAViewController ()

@property(nonatomic, strong) TFWebViewController *webVC;

@property (nonatomic, strong) TFAViewModel *viewModel;
@end

@implementation TFAViewController
@dynamic viewModel;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)initViews {
    [TFActionSheet showWithTitle:@"是否要删除" cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil block:nil];
    return;
    
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

@end
