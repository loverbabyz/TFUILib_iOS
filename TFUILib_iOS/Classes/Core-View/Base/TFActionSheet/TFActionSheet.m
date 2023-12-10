//
//  FSActionSheet.m
//  FSActionSheet
//
//  Created by Steven on 6/7/16.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "TFActionSheet.h"
#import "TFActionSheetCell.h"
#import <TFBaseLib_iOS/TFBaseMacro+System.h>

/**
 *  分区间距
 */
CGFloat const kTFActionSheetSectionHeight = 10;

@interface TFActionSheet () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, strong) NSArray<TFActionSheetItem *> *items;
@property (nonatomic, strong) ActionSheetBlock selectedHandler;

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, weak)   UIView *controllerView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak)   UILabel *titleLabel;

@property (nonatomic, assign) CGFloat size;

/**
 *  内容高度约束
 */
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end

static NSString * const kFSActionSheetCellIdentifier = @"kTFActionSheetCellIdentifier";

@implementation TFActionSheet

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //NSLog(@"-- TFActionSheet did dealloc -- [%p] -- [%p] -- [%p]", _window, _backView, _tableView);
}

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                        block:(ActionSheetBlock)block
{
    NSMutableArray *titleItems = [@[] mutableCopy];
    
    for (NSString *title in otherButtonTitles)
    {
        [titleItems addObject:TFActionSheetTitleItemMake(TFActionSheetTypeNormal, title)];
    }
    
    return [self initWithTitle:title
             cancelButtonTitle:cancelButtonTitle
        destructiveButtonTitle:destructiveButtonTitle
                  otherButtons:titleItems
                         block:block];
}
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                 otherButtons:(NSArray<TFActionSheetItem *> *)otherButtons
                        block:(ActionSheetBlock)block
{
    if (!(self = [super init])) return nil;
    
    self.selectedHandler = block;
    self.title = title ? : @"";
    self.cancelTitle = (cancelButtonTitle && cancelButtonTitle.length != 0) ? cancelButtonTitle : NSLocalizedString(@"cancel", @"cancel");
    
    [self baseSetting];
    
    NSMutableArray *titleItems = [@[] mutableCopy];
    
    [titleItems addObjectsFromArray:otherButtons];
    
    // 高亮按钮, 高亮按钮放在最下面.
    if (destructiveButtonTitle && destructiveButtonTitle.length > 0)
    {
        [titleItems addObject:TFActionSheetTitleItemMake(TFActionSheetTypeHighlighted, destructiveButtonTitle)];
    }
    
    
    self.items = titleItems;
    self.cornerRadius = TFActionSheetCornerRadius;
    
    [self addSubview:self.tableView];
    
    return self;
}

+ (void) showWithTitle:(NSString *)title
     cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
     otherButtonTitles:(NSArray *)otherButtonTitles
                 block:(ActionSheetBlock)block
{
   TFActionSheet *actionSheet = [[TFActionSheet alloc] initWithTitle:title
                                                   cancelButtonTitle:cancelButtonTitle
                                              destructiveButtonTitle:destructiveButtonTitle
                                                   otherButtonTitles:otherButtonTitles
                                                               block:block];
    [actionSheet show];
}

+ (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                 otherButtons:(NSArray<TFActionSheetItem *> *)otherButtons
                        block:(ActionSheetBlock)block
{
    TFActionSheet *actionSheet = [[TFActionSheet alloc] initWithTitle:title
                                                    cancelButtonTitle:cancelButtonTitle
                                               destructiveButtonTitle:destructiveButtonTitle
                                                         otherButtons:otherButtons
                                                                block:block];
    return actionSheet;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

// 默认设置
- (void)baseSetting
{
    self.backgroundColor = TFColorWithString(TFActionSheetBackColor);
    self.translatesAutoresizingMaskIntoConstraints = NO; // 允许约束
    
    _contentAlignment = TFContentAlignmentCenter; // 默认样式为居中
    _hideOnTouchOutside = YES; // 默认点击半透明层隐藏弹窗
    
    // 监听屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification  object:nil];
}

// 屏幕旋转通知回调
- (void)orientationDidChange:(NSNotification *)notification
{
    if (_title.length > 0) {
        // 更新头部标题的高度
        CGFloat newHeaderHeight = [self heightForHeaderView];
        CGRect newHeaderRect = _tableView.tableHeaderView.frame;
        newHeaderRect.size.height = newHeaderHeight;
        _tableView.tableHeaderView.frame = newHeaderRect;
        self.tableView.tableHeaderView = self.tableView.tableHeaderView;
        // 适配当前内容高度
        [self fixContentHeight];
    }
}

#pragma mark - private
// 计算title在设定宽度下的富文本高度
- (CGFloat)heightForHeaderView
{
    CGFloat labelHeight = [_titleLabel.attributedText boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.window.frame)-TFActionSheetDefaultMargin*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.height;
    CGFloat headerHeight = ceil(labelHeight) > TFActionSheetRowHeight ? ceil(labelHeight)+TFActionSheetDefaultMargin*2 : TFActionSheetRowHeight;
    
    return headerHeight;
}

// 整个弹窗内容的高度
- (CGFloat)contentHeight
{
    CGFloat titleHeight = (_title.length > 0)?[self heightForHeaderView]:0;
    CGFloat rowHeightSum = (_items.count+1)*TFActionSheetRowHeight+kTFActionSheetSectionHeight;
    CGFloat contentHeight = titleHeight+rowHeightSum;
    
    return contentHeight;
}

// 适配屏幕高度, 弹出窗高度不应该高于屏幕的设定比例
- (void)fixContentHeight
{
    CGFloat contentMaxHeight = CGRectGetHeight(self.window.frame)*TFActionSheetContentMaxScale;
    CGFloat contentHeight = [self contentHeight];
    if (contentHeight > contentMaxHeight) {
        contentHeight = contentMaxHeight;
        self.tableView.scrollEnabled = YES;
    } else {
        self.tableView.scrollEnabled = NO;
    }
    
    _heightConstraint.constant = contentHeight;
}

// 适配标题偏移方向
- (void)updateTitleAttributeText
{
    if (_title.length == 0 || !_titleLabel) return;
    
    // 富文本相关配置
    NSRange  attributeRange = NSMakeRange(0, _title.length);
    UIFont  *titleFont      = [UIFont systemFontOfSize:14];
    UIColor *titleTextColor = TFColorWithString(TFActionSheetTitleColor);
    CGFloat  lineSpacing = TFActionSheetTitleLineSpacing;
    CGFloat  kernSpacing = TFActionSheetTitleKernSpacing;
    
    NSMutableAttributedString *titleAttributeString = [[NSMutableAttributedString alloc] initWithString:_title];
    NSMutableParagraphStyle *titleStyle = [[NSMutableParagraphStyle alloc] init];
    // 行距
    titleStyle.lineSpacing = lineSpacing;
    // 内容偏移样式
    switch (_contentAlignment) {
        case TFContentAlignmentLeft: {
            titleStyle.alignment = NSTextAlignmentLeft;
            break;
        }
        case TFContentAlignmentCenter: {
            titleStyle.alignment = NSTextAlignmentCenter;
            break;
        }
        case TFContentAlignmentRight: {
            titleStyle.alignment = NSTextAlignmentRight;
            break;
        }
    }
    [titleAttributeString addAttribute:NSParagraphStyleAttributeName value:titleStyle range:attributeRange];
    // 字距
    [titleAttributeString addAttribute:NSKernAttributeName value:@(kernSpacing) range:attributeRange];
    // 字体
    [titleAttributeString addAttribute:NSFontAttributeName value:titleFont range:attributeRange];
    // 颜色
    [titleAttributeString addAttribute:NSForegroundColorAttributeName value:titleTextColor range:attributeRange];
    _titleLabel.attributedText = titleAttributeString;
}

// 点击背景半透明遮罩层隐藏
- (void)backViewGesture
{
    [self hideWithCompletion:nil];
}

// 隐藏
- (void)hideWithCompletion:(void(^)(void))completion
{
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.backView.alpha   = 0;
        CGRect newFrame   = weakSelf.frame;
        newFrame.origin.y = CGRectGetMaxY(weakSelf.controllerView.frame);
        weakSelf.frame        = newFrame;
    } completion:^(BOOL finished) {
        [[TF_APP_APPLICATION.delegate window] makeKeyWindow];
        if (completion) completion();
        [weakSelf.backView removeFromSuperview];
        weakSelf.backView = nil;
        [weakSelf.tableView removeFromSuperview];
        weakSelf.tableView = nil;
        [weakSelf removeFromSuperview];
        weakSelf.window = nil;
        weakSelf.selectedHandler = nil;
    }];
}

#pragma mark - public
/*! @brief 单展示, 不绑定block回调 */
- (void)show
{
    _backView = [[UIView alloc] init];
    _backView.alpha = 0;
    _backView.backgroundColor = [UIColor blackColor];
    _backView.userInteractionEnabled = _hideOnTouchOutside;
    _backView.translatesAutoresizingMaskIntoConstraints = NO;
    [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewGesture)]];
    [_controllerView addSubview:_backView];
    [_controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_backView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backView)]];
    [_controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_backView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backView)]];
    
    [self.tableView reloadData];
    // 内容高度
    CGFloat contentHeight = self.tableView.contentSize.height;
    // 适配屏幕高度
    CGFloat contentMaxHeight = CGRectGetHeight(self.window.frame)*TFActionSheetContentMaxScale;
    if (contentHeight > contentMaxHeight) {
        self.tableView.scrollEnabled = YES;
        contentHeight = contentMaxHeight;
    }
    [_controllerView addSubview:self];
    
    CGFloat selfW = CGRectGetWidth(_controllerView.frame);
    CGFloat selfH = contentHeight;
    CGFloat selfX = 0;
    CGFloat selfY = CGRectGetMaxY(_controllerView.frame);
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    
    [self.window makeKeyAndVisible];
    
     __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        weakSelf.backView.alpha   = 0.38;
        CGRect newFrame   = self.frame;
        newFrame.origin.y = CGRectGetMaxY(self->_controllerView.frame)-selfH;
        self.frame        = newFrame;
    } completion:^(BOOL finished) {
        // constraint
        [weakSelf.controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        [weakSelf.controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        weakSelf.heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:contentHeight];
        [weakSelf.controllerView addConstraint:self->_heightConstraint];
    }];
}

#pragma mark - getter
- (UIWindow *)window
{
    if (_window) return _window;
    
    _window = [[UIWindow alloc] initWithFrame:TF_MAIN_SCREEN.bounds];
    _window.windowLevel = UIWindowLevelStatusBar+1;
    _window.rootViewController = [[UIViewController alloc] init];
    self.controllerView = _window.rootViewController.view;
    
    return _window;
}
- (UITableView *)tableView
{
    if (_tableView) return _tableView;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = self.backgroundColor;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    if (@available(iOS 7.0, *)) {
        _tableView.estimatedRowHeight = 0.0;
        _tableView.estimatedSectionHeaderHeight = 0.0;
        _tableView.estimatedSectionFooterHeight = 0.0;
    }
    
    [_tableView registerClass:[TFActionSheetCell class] forCellReuseIdentifier:kFSActionSheetCellIdentifier];
    
    if (_title.length > 0) {
        _tableView.tableHeaderView = [self headerView];
    } else {
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.window.frame), CGFLOAT_MIN)];
    }
    
    return _tableView;
}

// tableHeaderView作为title部分
- (UIView *)headerView
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = TFColorWithString(TFActionSheetRowNormalColor);
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.backgroundColor = headerView.backgroundColor;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    // 设置富文本标题内容
    [self updateTitleAttributeText];
    
    // 标题内容边距 (ps: 要修改这个边距不要在这里修改这个labelMargin, 要到配置类中修改 TFActionSheetDefaultMargin, 不然可能出现界面适配错乱).
    CGFloat labelMargin = TFActionSheetDefaultMargin;
    // 计算内容高度
    CGFloat headerHeight = [self heightForHeaderView];
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.window.frame), headerHeight);
    
    // titleLabel constraint
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-labelMargin-[titleLabel]-labelMargin-|" options:0 metrics:@{@"labelMargin":@(labelMargin)} views:NSDictionaryOfVariableBindings(titleLabel)]];
    [headerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)]];
    
    return headerView;
}

- (CGFloat)size {
    if (@available(iOS 11.0, *)) {
        _size = self.window.safeAreaInsets.bottom;
    }
    
    return _size;
}

#pragma mark - setter
- (void)setContentAlignment:(TFContentAlignment)contentAlignment
{
    if (_contentAlignment != contentAlignment)
    {
        _contentAlignment = contentAlignment;
        [self updateTitleAttributeText];
    }
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 1)?1:_items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return TFActionSheetRowHeight + self.size;
    }
    return TFActionSheetRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return CGFLOAT_MIN;
    }
    return kTFActionSheetSectionHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:kFSActionSheetCellIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFActionSheetCell *sheetCell = (TFActionSheetCell *)cell;
    if (indexPath.section == 0)
    {
        sheetCell.item = self.items[indexPath.row];
        sheetCell.hideTopLine = NO;
        
        // 当有标题时隐藏第一单元格的顶部线条
        if (indexPath.row == 0 && (!self.title || self.title.length == 0))
        {
            sheetCell.hideTopLine = YES;
        }
    }
    else
    {
        // 默认取消的单元格没有附带icon
        TFActionSheetItem *cancelItem = TFActionSheetTitleItemMake(TFActionSheetTypeNormal, _cancelTitle);
        
        // 如果其它单元格中附带icon的话则添加上默认的取消icon.
        for (TFActionSheetItem *item in _items)
        {
            if (item.image)
            {
                cancelItem = FSActionSheetTitleWithImageItemMake(TFActionSheetTypeNormal, [UIImage imageNamed:@"TFActionSheet_cancel"], _cancelTitle);
                break;
            }
        }
        
        sheetCell.item = cancelItem;
        sheetCell.hideTopLine = YES;
    }
    
    sheetCell.contentAlignment = _contentAlignment;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 延迟0.1秒隐藏让用户既看到点击效果又不影响体验
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak __typeof(self) weakSelf = self;
        [self hideWithCompletion:^{
            if (indexPath.section == 0)
            {
                if (weakSelf.selectedHandler)
                {
                    weakSelf.selectedHandler(indexPath.row);
                }
            }
        }];
    });
}

@end
