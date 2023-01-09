//
//  TFTableViewController.h
//  Treasure
//
//  Created by Daniel on 15/7/2.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFViewController.h"

#import "TFTableViewCell.h"
#import "TFTableViewHeaderFooterView.h"

@interface TFTableViewController : TFViewController<
                                                    UITableViewDelegate,
                                                    UITableViewDataSource
                                                    >
/**
 *  是否在加载状态
 */
@property (nonatomic, readonly) BOOL loading;

/**
 *  TableView风格
 */
@property (nonatomic, assign) UITableViewStyle style;

/**
 *  tableView
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 *  tableView的HeaderView
 */
@property (nonatomic, strong) UIView *headerView;

/**
 *  tableView的FooterView
 */
@property (nonatomic, strong) UIView *footerView;

/**
 *  tableView的Header高度
 */
@property (nonatomic, assign) CGFloat headerViewHeight;

/**
 *  tableView的Footer高度
 */
@property (nonatomic, assign) CGFloat footerViewHeight;

/**
 *  tableView默认的cell
 */
@property (nonatomic, strong) Class defaultCell;

/**
 *  是否需要使用JSON文件模板
 */
@property (nonatomic, assign) BOOL useTemplate;

/**
 *  初始化TableView
 *
 *  @param style TableView风格
 *
 *  @return TableView
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

/**
 *  注册cell
 */
- (void)registerCell;

/**
 *  注册tableView的class文件，指定cell的ReuseIdentifier
 *
 *  @param className Nib文件类名称
 *
 *  @param identifier cell的identifier名称
 *
 *  @param forCell YES:为Cell注册 / NO:为Header和Footer注册
 */
- (void)registerClass:(Class)className forCellReuseIdentifier:(NSString *)identifier forCell:(BOOL)forCell;

/**
 *  注册tableView的class文件，默认ReuseIdentifier为指定class的名称
 *
 *  @param className Nib文件类名称
 *
 *  @param forCell YES:为Cell注册 / NO:为Header和Footer注册
 */
- (void)registerClass:(Class)className forCell:(BOOL)forCell;

/**
 *  注册cell Nib文件，指定cell的ReuseIdentifier
 *
 *  @param className Nib文件类名称
 *
 *  @param identifier cell的identifier名称
 *
 *  @param forCell YES:为Cell注册 / NO:为Header和Footer注册
 */
- (void)registerNib:(Class)className forCellReuseIdentifier:(NSString *)identifier  forCell:(BOOL)forCell;;

/**
 *  注册cell Nib文件，默认ReuseIdentifier为指定class的名称
 *
 *  @param className Nib文件类名称
 *
 *  @param forCell YES:为Cell注册 / NO:为Header和Footer注册
 */
- (void)registerNib:(Class)className forCell:(BOOL)forCell;

/// 注册cell Nib文件
/// @param className Nib文件类名称
/// @param identifier ReuseIdentifier
/// @param forCell YES:为Cell注册 / NO:为Header和Footer注册
/// @param bundle bundle
- (void)registerNib:(Class)className cellReuseIdentifier:(NSString *)identifier forCell:(BOOL)forCell bundle:(NSBundle *)bundle;

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

/**
 *  结束加载
 */
- (void)endLoadDataWithNoMoreData;

@end
