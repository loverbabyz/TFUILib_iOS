//
//  TFScrollViewController.m
//  Treasure
//
//  Created by Daniel on 15/9/8.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFScrollViewController.h"

#import "MJRefresh.h"
#import "TFMasonry.h"
#import <TFBaseLib_iOS/TFMJExtension.h>

@implementation TFScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        
        make.edges.equalTo(super.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark -  对上拉和下拉控件操作

- (void)showRefreshHeader
{
    self.scrollView.tf_mj_header.hidden = NO;
}

- (void)hideRefreshHeader
{
    self.scrollView.tf_mj_header.hidden = YES;
}

- (void)refreshNewData
{
    [self.scrollView.tf_mj_header beginRefreshing];
}

#pragma mark -  加载数据方法

- (void)loadNewData
{
    
}

- (void)loadMoreData
{
    
}

- (void)endLoadData
{
    [super endLoadData];
    [self.scrollView.tf_mj_header endRefreshing];
}

#pragma mark -  get set

- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        //_scrollView.frame =CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        //_scrollView.frame=self.view.bounds;
        _scrollView.delegate = self;
        
        _scrollView.backgroundColor                = [UIColor whiteColor];
        [_scrollView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        _scrollView.tf_mj_header = [TFMJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

        _scrollView.tf_mj_footer = [TFMJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
//        _scrollView.tf_mj_footer.automaticallyHidden = NO;
        _scrollView.tf_mj_header.hidden              = YES;
        _scrollView.tf_mj_footer.hidden              = YES;
    }
    
    return _scrollView;
}

@end
