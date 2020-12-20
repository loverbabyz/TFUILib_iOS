//
//  TFCollectionViewController.h
//  Treasure
//
//  Created by xiayiyong on 15/9/8.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFViewController.h"

#import "TFCollectionView.h"
#import "TFCollectionViewCell.h"

@interface TFCollectionViewController : TFViewController<
                                                        UICollectionViewDataSource,
                                                        UICollectionViewDelegate
                                                        >

/**
 *  collectionView
 */
@property (nonatomic,strong) TFCollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

/**
 *  collectionView默认的cell
 */
@property (nonatomic, strong) Class defaultCell;

/**
 *  collectionView的HeaderView
 */
@property (nonatomic, strong) UIView *headerView;

/**
 *  collectionView的FooterView
 */
@property (nonatomic, strong) UIView *footerView;

/**
 *  collectionView的Header高度
 */
@property (nonatomic, assign) CGFloat headerViewHeight;

/**
 *  collectionView的Footer高度
 */
@property (nonatomic, assign) CGFloat footerViewHeight;

/**
 *  是否需要使用JSON文件模板
 */
@property (nonatomic, assign) BOOL useTemplate;

/**
 *  注册cell
 */
- (void)registerCell;

/**
 *  注册tableView的class文件，指定cell的ReuseIdentifier
 *
 *  @param className 类名称
 *
 *  @param identifier cell的identifier名称
 */
- (void)registerClass:(Class)className forCellReuseIdentifier:(NSString *)identifier;

/**
 *  注册tableView的class文件，默认ReuseIdentifier为指定class的名称
 *
 *  @param className 类名称
 */
- (void)registerClass:(Class)className;

/**
 *  注册headview
 *
 *  @param viewClass 类名称
 */
-(void)registerHeaderClass:(Class)viewClass;

/**
 *  注册footview
 *
 *  @param cellClass 类名称
 */
-(void)registerFooterClass:(Class)cellClass;

/**
 *  注册cell Nib文件，指定cell的ReuseIdentifier
 *
 *  @param className Nib文件类名称
 *
 *  @param identifier cell的identifier名称
 */
- (void)registerNib:(Class)className forCellReuseIdentifier:(NSString *)identifier;

/**
 *  注册cell Nib文件，默认ReuseIdentifier为指定class的名称
 *
 *  @param className Nib文件类名称
 */
- (void)registerNib:(Class)className;

/**
 *  显示Header
 */
- (void)showRefreshHeader;

/**
 *  隐藏Header
 */
- (void)hideRefreshHeader;

/**
 *  显示Footer
 */
- (void)showRefreshFooter;

/**
 *  隐藏Footer
 */
- (void)hideRefreshFooter;

/**
 *  下拉刷新
 */
- (void)refreshNewData;

/**
 *  加载第一页  无下拉效果
 */
- (void)loadNewData;

/**
 *  加载下一页
 */
- (void)loadMoreData;

/**
 *  结束加载
 */
- (void)endLoadData;

/// 结束加载，无更多数据
- (void)endLoadDataWithNoMoreData;

@end
