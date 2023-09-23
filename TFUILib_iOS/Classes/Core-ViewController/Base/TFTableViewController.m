//
//  TFTableViewController.m
//  Treasure
//
//  Created by Daniel on 15/7/2.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFTableViewController.h"
#import "TFLabel.h"

#import "MJRefresh.h"
#import "TFMasonry.h"

@interface TFTableViewController ()

@end

@implementation TFTableViewController

- (instancetype) init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype) initWithStyle:(UITableViewStyle)style
{
    if(self  = [super init])
    {
        _style            = style;
        _headerViewHeight = 0.1;
        _footerViewHeight = 0.1;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerCell];
}

#pragma mark- init autolayout bind

- (void)registerCell
{
    [self registerClass:[UITableViewCell class] forCell:YES];
    [self registerClass:[TFTableViewCell class] forCell:YES];
    
    NSString *cellClassName = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewController" withString:@"ViewCell"];
    Class cellClass = NSClassFromString(cellClassName);
    if (cellClass)
    {
        [self registerClass:cellClass forCellReuseIdentifier:cellClassName  forCell:YES];
    }
}

- (void)registerClass:(Class)className forCellReuseIdentifier:(NSString *)identifier forCell:(BOOL)forCell {
    if (forCell) {
        [self.tableView registerClass:className forCellReuseIdentifier:identifier];
    } else {
        [self.tableView registerClass:className forHeaderFooterViewReuseIdentifier:identifier];
    }
}

- (void)registerClass:(Class)className forCell:(BOOL)forCell {
    [self registerClass:className forCellReuseIdentifier:NSStringFromClass(className) forCell:forCell];
}

- (void)registerNib:(Class)className forCellReuseIdentifier:(NSString *)identifier forCell:(BOOL)forCell {
    [self registerNib:className cellReuseIdentifier:identifier forCell:forCell bundle:nil];
}

- (void)registerNib:(Class)className cellReuseIdentifier:(NSString *)identifier forCell:(BOOL)forCell bundle:(NSBundle *)bundle {
    if (forCell) {
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:bundle] forCellReuseIdentifier:identifier];
    } else {
        [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:bundle] forHeaderFooterViewReuseIdentifier:identifier];
    }
}

- (void)registerNib:(Class)className forCell:(BOOL)forCell {
    [self registerNib:className forCellReuseIdentifier:NSStringFromClass(className) forCell:forCell];
}

- (void)initViews
{
    [super initViews];
    
    [self.view addSubview:self.tableView];
}

- (void)autolayoutViews
{
    [super autolayoutViews];
    
    [self.tableView tf_mas_remakeConstraints:^(TFMASConstraintMaker *make) {
        make.edges.equalTo(super.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(void)bindData
{
    [self registerCell];
    
    [super bindData];
}

#pragma mark -  UITableViewDataSource

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.viewModel titleAtSection:section];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.viewModel titleAtSection:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static CGFloat height = 44.0;
    __block Class cellClass = nil;
    
    if (self.defaultCell) {
        cellClass = self.defaultCell;
    } else {
        cellClass = NSClassFromString([NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewController" withString:@"ViewCell"]);
    }
    
    if (cellClass && [cellClass isSubclassOfClass:[TFTableViewCell class]]) {
        id cell = [[cellClass alloc] init];
        CGFloat (*cellHeight)(id ,SEL)=(CGFloat (*)(id,SEL))[cell methodForSelector:NSSelectorFromString(@"cellHeight")];
        height = cellHeight(cell, @selector(cellHeight));
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static BOOL exist= NO;
    //static dispatch_once_t p;
    __block Class cellClass = nil;
    if (self.defaultCell) {
        cellClass = self.defaultCell;
    } else {
        cellClass = NSClassFromString([NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewController" withString:@"ViewCell"]);
    }
    
    if (cellClass && [cellClass isSubclassOfClass:[TFTableViewCell class]]) {
        static NSString *identifier;
        identifier = self.defaultCell ? NSStringFromClass(cellClass) : [NSStringFromClass(cellClass) stringByReplacingOccurrencesOfString:@"ViewController" withString:@"ViewCell"];
        TFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.data = [self.viewModel dataAtIndexPath:indexPath];
        
        return cell;
    }
    
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self handleData:[self.viewModel dataAtIndexPath:indexPath]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *titleAtSection = [self.viewModel titleAtSection:section];
    CGFloat height = !(!titleAtSection || [titleAtSection isEqual:[NSNull null]]) ? 44.0 : 0.05;
    Class cellClass = cellClass = NSClassFromString([NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewController" withString:@"TableHeaderView"]);
    
    if (cellClass && [cellClass isSubclassOfClass:[TFTableViewHeaderFooterView class]]) {
        id cell = [[cellClass alloc] init];
        CGFloat (*cellHeight)(id ,SEL)=(CGFloat (*)(id,SEL))[cell methodForSelector:NSSelectorFromString(@"viewHeight")];
        height = cellHeight(cell, @selector(cellHeight));
    }
    
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Class headerClass = NSClassFromString([NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewController" withString:@"TableHeaderView"]);
    
    if (headerClass && [headerClass isSubclassOfClass:[TFTableViewHeaderFooterView class]]) {
        static NSString *identifier;
        identifier = NSStringFromClass(headerClass);
        TFTableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        headerView.data = [self.viewModel dataAtSection:section];
        
        return headerView;
    }
    else
    {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.0;
    Class cellClass = NSClassFromString([NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewController" withString:@"TableFooterView"]);
    
    if (cellClass && [cellClass isSubclassOfClass:[TFTableViewHeaderFooterView class]]) {
        id cell = [[cellClass alloc] init];
        CGFloat (*cellHeight)(id ,SEL)=(CGFloat (*)(id,SEL))[cell methodForSelector:NSSelectorFromString(@"viewHeight")];
        height = cellHeight(cell, @selector(cellHeight));
    }
    
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    Class footerClass = NSClassFromString([NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"ViewController" withString:@"TableFooterView"]);
    
    if (footerClass && [footerClass isSubclassOfClass:[TFTableViewHeaderFooterView class]]) {
        static NSString *identifier;
        identifier = NSStringFromClass(footerClass);
        TFTableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        footerView.data = [self.viewModel dataAtSection:section];
        
        return footerView;
    }
    else
    {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
}

#pragma mark -  对上拉和下拉控件操作

- (void)showRefreshHeader
{
    self.tableView.tf_mj_header.hidden = NO;
}

- (void)hideRefreshHeader
{
    self.tableView.tf_mj_header.hidden = YES;
}

- (void)showRefreshFooter
{
    self.tableView.tf_mj_footer.hidden = NO;
}

- (void)hideRefreshFooter
{
    self.tableView.tf_mj_footer.hidden = YES;
}

#pragma mark -  加载数据方法

- (void)refreshNewData
{
    [self.tableView.tf_mj_header beginRefreshing];
}

- (void)startLoadData {
    if (_loading) {
        return;
    }
    
    _loading = YES;
    
    [super startLoadData];
}

- (void)loadNewData
{
    if (_loading) {
        return;
    }
    
    _loading = YES;
    
    [self showHud];
}

- (void)loadMoreData
{
    if (_loading) {
        return;
    }
    
    _loading = YES;
    
    [self showHud];
}

- (void)endLoadData
{
    if (!_loading) {
        return;
    }
    
    _loading = NO;
    
    [super endLoadData];
    [self.tableView.tf_mj_header endRefreshing];
    [self.tableView.tf_mj_footer endRefreshing];
}

- (void)endLoadDataWithNoMoreData {
//    _loading = NO;
    
    [super endLoadData];
    [self.tableView.tf_mj_header endRefreshing];
    [self.tableView.tf_mj_footer endRefreshingWithNoMoreData];
}

#pragma mark -  get set

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView                                = [[UITableView alloc]initWithFrame:self.view.bounds style:_style];
        _tableView.delegate                       = self;
        _tableView.dataSource                     = self;

        _tableView.backgroundView                 = UIView.new;
        _tableView.separatorStyle                 = UITableViewCellSeparatorStyleSingleLine;
        [_tableView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        
        // 解决在push和pop时，tableview会向上移动的问题
        //if (@available(iOS 11.0, *)) {
            //_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //}
        
        /**
         // 自定义下拉刷新
         MJRefreshNormalHeader *customRef = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
         
         // 自定义刷新状态文字
         [customRef setTitle:@"普通闲置状态" forState:TFMJRefreshStateIdle];
         [customRef setTitle:@"松开就可以进行刷新的状态" forState:TFMJRefreshStatePulling];
         [customRef setTitle:@"正在刷新中的状态" forState:TFMJRefreshStateRefreshing];
         [customRef setTitle:@"即将刷新的状态" forState:TFMJRefreshStateWillRefresh];
         [customRef setTitle:@"所有数据加载完毕，没有更多的数据了" forState:TFMJRefreshStateNoMoreData];
         
         // 设置字体
         customRef.stateLabel.font = [UIFont systemFontOfSize:15];
         customRef.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
         
         // 设置颜色
         customRef.stateLabel.textColor = [UIColor redColor];
         customRef.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
         
         
         // 隐藏状态
         customRef.stateLabel.hidden = YES;
         
         // 隐藏时间
         customRef.lastUpdatedTimeLabel.hidden = YES;
         */
        
        _tableView.tf_mj_header                      = [TFMJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.tf_mj_footer                      = [TFMJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

        //_tableView.tf_mj_footer.automaticallyHidden  = NO;
        _tableView.tf_mj_header.hidden               = YES;
        _tableView.tf_mj_footer.hidden               = YES;
        
    }
    
    return _tableView;
}

- (UIView *)headerView
{
    if (_headerView==nil)
    {
        _headerView                    = UIView.new;
        _headerView.height             = self.headerViewHeight;
        self.tableView.tableHeaderView = _headerView;
    }
    
    return _headerView;
}

- (UIView *)footerView
{
    if (_footerView==nil)
    {
        _footerView                    = UIView.new;
        _footerView.height             = self.footerViewHeight;
        self.tableView.tableFooterView = _footerView;
    }
    
    return _footerView;
}

-(void)setHeaderViewHeight:(CGFloat)headerViewHeight
{
    _headerViewHeight              = headerViewHeight;
    self.headerView.height         = headerViewHeight;
    self.tableView.tableHeaderView = self.headerView;
}

-(void)setFooterViewHeight:(CGFloat)footerViewHeight
{
    _footerViewHeight              = footerViewHeight;
    self.footerView.height         = footerViewHeight;
    self.tableView.tableFooterView = self.footerView;
}

-(void)setDefaultCell:(Class)defaultCell
{
    _defaultCell = defaultCell;
    if (defaultCell)
    {
        [self registerClass:defaultCell forCell:YES];
    }
}

@end
