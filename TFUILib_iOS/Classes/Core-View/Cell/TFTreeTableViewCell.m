//
//  TFTreeTableViewCell.m
//  SSXQ
//
//  Created by Daniel on 2020/7/27.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//

#import "TFTreeTableViewCell.h"

#import <Masonry/Masonry.h>

#import "TFView.h"
#import "TFTableView.h"

#import "TFTreeSectionModel.h"

@interface TFTreeTableViewCell()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) TFTreeSectionModel *data;

@property (nonatomic, strong) Class subTableCellClass;

@property (nonatomic, strong) TFView *cellView;

/// sub table
@property (nonatomic, strong) TFTableView *subTableView;
@property (nonatomic, strong) TFView *headerViewContainer;
@property (nonatomic, strong) TFView *footerViewContainer;
@property (nonatomic, strong) TFView *headerView;
@property (nonatomic, strong) TFView *footerView;

@property (nonatomic, assign) CGFloat heightForCell;

@end
@implementation TFTreeTableViewCell
@dynamic data;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.subTableView.width;
    
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
    }];
    
    [self.footerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
    }];
}

- (void)initData:(TFTreeSectionModel *)data
                     cellView:(TFView *)cellView
  subTreeTableHeaderView:(TFView *)subTableHeaderView
        subTreeTableCellClass:(Class)subTableCellClass
   subTreeTablFooterView:(TFView *)subTablFooterView {
    self.data = data;
    _subTableCellClass = subTableCellClass;
    _cellView = cellView;
    _headerView = subTableHeaderView;
    _footerView = subTablFooterView;
    
    [self.contentView addSubview:self.cellView];
    [self.contentView addSubview:self.subTableView];
    
    if (self.headerViewContainer.subviews.count == 0) {
        [self.headerViewContainer addSubview:self.headerView];
    }
    
    if (self.footerViewContainer.subviews.count == 0) {
        [self.footerViewContainer addSubview:self.footerView];
    }
    
    // 注册cell、header、footer
    [self.subTableView registerNib:self.subTableCellClass];
    
    self.heightForCell = [self heightForCellClass:self.subTableCellClass];

    // 有子数据已展开时：header高度、table高度和footer高度均不为0
    CGFloat width = self.contentView.width;
    CGFloat cellViewHeight = [[self.cellView class] viewHeight];
    CGFloat headerHeight = [[self.headerView class] viewHeight];
    CGFloat footerHeight = [[self.footerView class] viewHeight];
    
    CGFloat tableHeight = [self tableViewHeight:headerHeight footerViewHeight:footerHeight heightForCell:self.heightForCell];
//    CGFloat footerTop = headerHeight + [self heightForCellClass:self.subTableCellClass] * self.data.subTableDataArray.count;
    
    /// ！！！必须要给UITableView的tableHeaderView和tableFooterView创建一个承载容器
    /// 其它内容放在该容器中
    /// 需要设置承载容器的高度以正常显示
    self.headerViewContainer.height = headerHeight;
    self.footerViewContainer.height = footerHeight;
    
    [self.headerView masViewEqualToSuperViewWithInsets:UIEdgeInsetsZero];
    [self.footerView masViewEqualToSuperViewWithInsets:UIEdgeInsetsZero];
    
    [self.cellView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.equalTo(@(cellViewHeight));
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.subTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        make.left.right.offset(0);
        make.top.equalTo(strongSelf.cellView.mas_bottom);
        make.height.equalTo(@(tableHeight));
    }];
    
    [self.subTableView reloadData];
}

- (CGFloat)tableViewHeight:(CGFloat)headerViewHeight footerViewHeight:(CGFloat)footerViewHeight heightForCell:(CGFloat)heightForCell {
    CGFloat tableViewHeight = CGFLOAT_MIN;
    
    if (self.data.subTableDataArray) {
        // 表格高度 = cell数量 * cell高度 + header高度 + footer高度
        tableViewHeight = self.data.subTableDataArray.count * heightForCell + headerViewHeight + footerViewHeight;
    }
    
    return tableViewHeight;
}

/// 获取cell的高度
/// @param cellClass cell class
- (CGFloat)heightForCellClass:(Class)cellClass {
    CGFloat height = CGFLOAT_MIN;
    
    if (cellClass && [cellClass isSubclassOfClass:[TFTableViewCell class]]) {
        CGFloat (*cellHeight)(id ,SEL)=(CGFloat (*)(id,SEL))[cellClass methodForSelector:NSSelectorFromString(@"cellHeight")];
        height = cellHeight(cellClass, @selector(cellHeight));
    }
    
    return height;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.subTableDataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.heightForCell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.subTableCellClass) forIndexPath:indexPath];
    if (cell) {
        cell.data = self.data.subTableDataArray[indexPath.row];
    }

    return cell;
}

#pragma mark - getter && setter

- (TFView *)headerViewContainer {
    if (!_headerViewContainer) {
        _headerViewContainer = [TFView new];
    }
    
    return _headerViewContainer;
}

- (TFView *)footerViewContainer {
    if (!_footerViewContainer) {
        _footerViewContainer = [TFView new];
    }
    
    return _footerViewContainer;
}

- (TFTableView *)subTableView {
    if (!_subTableView) {
        _subTableView = [[TFTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _subTableView.delegate = self;
        _subTableView.dataSource = self;
        //_subTableView.rowHeight = UITableViewAutomaticDimension;
        _subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _subTableView.bounces = NO;
        _subTableView.scrollEnabled = NO;
        _subTableView.clipsToBounds = YES;
        _subTableView.tableHeaderView = self.headerViewContainer;
        _subTableView.tableFooterView = self.footerViewContainer;
        [_subTableView masViewEqualToSuperViewWithInsets:UIEdgeInsetsMake(0, self.padding, 0, self.padding)];
        _subTableView.layoutMargins = UIEdgeInsetsMake(0, self.padding, 0, self.padding);
    }
    
    return _subTableView;
}

@end
