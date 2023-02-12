//
//  TFCollectionViewController.m
//  Treasure
//
//  Created by Daniel on 15/9/8.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFCollectionViewController.h"

#import <MJRefresh/MJRefresh.h>
#import <TFBaseLib_iOS/TFBaseMacro+System.h>

@implementation TFCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self registerCell];
}

#pragma mark- init autolayout bind

- (void)initViews {
    [super initViews];
    
    [self.view addSubview:self.collectionView];
}

- (void)autolayoutViews {
    [super autolayoutViews];
    
    [self.collectionView masViewEqualToSuperViewWithInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (void)bindData {
    [super bindData];
}

- (void)registerCell
{
    [self registerClass:[UICollectionViewCell class]];
    [self registerClass:[TFCollectionViewCell class]];
    
    NSString *cellClassName   = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"CollectionViewController" withString:@"CollectionViewCell"];
    
    Class cellClass = NSClassFromString(cellClassName);
    if (cellClass)
    {
        [self registerClass:cellClass];
    }
}

- (void)registerClass:(nullable Class)className forCellReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:className forCellWithReuseIdentifier:identifier];
}

- (void)registerClass:(nullable Class)className {
    [self registerClass:className forCellReuseIdentifier:NSStringFromClass(className)];
}

-(void)registerHeaderClass:(Class)cellClass {
    [self.collectionView registerClass:cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(cellClass)];
}

-(void)registerFooterClass:(Class)cellClass {
    [self.collectionView registerClass:cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNib:(nullable Class)className forCellReuseIdentifier:(NSString *)identifier {
    //[self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.collectionView registerNib:className];
}

- (void)registerNib:(nullable Class)className {
    [self registerNib:className forCellReuseIdentifier:NSStringFromClass(className)];
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowsInSection:section];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.defaultCell)
    {
        if ([self.defaultCell isSubclassOfClass:[TFCollectionViewCell class]])
        {
            TFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.defaultCell) forIndexPath:indexPath];
            cell.data = [self.viewModel dataAtIndexPath:indexPath];
            
            return cell;
        }
    }
    
    static NSString * CellIdentifier = @"ViewController";
    static BOOL exist= NO;
    static dispatch_once_t p;
    dispatch_once(&p, ^{
        Class cellClass = NSClassFromString([NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:CellIdentifier withString:@"ViewCell"]);
        if (cellClass)
        {
            if ([cellClass isSubclassOfClass:[UICollectionViewCell class]])
            {
                exist = YES;
            }
        }
    });
    
    if (exist)
    {
        TFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:CellIdentifier withString:@"ViewCell"] forIndexPath:indexPath];
        cell.data = [self.viewModel dataAtIndexPath:indexPath];
        
        return cell;
    }
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self handleData:[self.viewModel dataAtIndexPath:indexPath]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self handleData:[self.viewModel dataAtIndexPath:indexPath]];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = SCREEN_WIDTH/3;
    
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -  对上拉和下拉控件操作

- (void)showRefreshHeader
{
    self.collectionView.mj_header.hidden=NO;
}

- (void)hideRefreshHeader
{
    self.collectionView.mj_header.hidden=YES;
}

- (void)showRefreshFooter
{
    self.collectionView.mj_footer.hidden=NO;
}

- (void)hideRefreshFooter
{
    self.collectionView.mj_footer.hidden=YES;
}

#pragma mark -  加载数据方法

- (void)refreshNewData
{
    [self.collectionView.mj_header beginRefreshing];
}

- (void)loadNewData
{
}

- (void)loadMoreData
{
    [self.collectionView.mj_footer beginRefreshing];
}

- (void)endLoadData
{
    [super endLoadData];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)endLoadDataWithNoMoreData {
    [super endLoadData];
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}

#pragma mark -  get set

-(UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout == nil)
    {
        _flowLayout                                     = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize                            = CGSizeMake(100, 100);
        _flowLayout.minimumInteritemSpacing             = 5;
        _flowLayout.minimumLineSpacing                  = 5;
        if (@available(iOS 9.0, *)) {
            _flowLayout.sectionHeadersPinToVisibleBounds    = YES;
        } else {
            // Fallback on earlier versions
        }
        // 固定在顶端
        //_flowLayout.scrollDirection                     = UICollectionViewScrollDirectionVertical;
        //_flowLayout.headerReferenceSize                 = CGSizeMake(SCREEN_WIDTH, 30);
    }
    
    return _flowLayout;
}

- (TFCollectionView *)collectionView
{
    if(_collectionView == nil)
    {
        _collectionView                                 = [[TFCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _collectionView.dataSource                      = self;
        _collectionView.delegate                        = self;
        
        _collectionView.mj_header                       = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
        _collectionView.mj_footer                       = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
//        _collectionView.mj_footer.automaticallyHidden   = NO;
        _collectionView.mj_header.hidden                = YES;
        _collectionView.mj_footer.hidden                = YES;
    }
    
    return _collectionView;
}

-(void)setDefaultCell:(Class)defaultCell
{
    _defaultCell = defaultCell;
    if (defaultCell)
    {
        [self.collectionView registerClass:defaultCell forCellWithReuseIdentifier:NSStringFromClass(defaultCell)];
    }
}

@end
