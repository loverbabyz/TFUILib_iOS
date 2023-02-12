//
//  TFPopupView.m
//  TFUILib
//
//  Created by Daniel on 2020/7/13.
//  Copyright © 2020 com.treasure.TFUILib. All rights reserved.
//

#import "TFPopupView.h"
#import "TFUILibMacro+Color.h"
#import "TFLabel.h"
#import "TFView.h"
#import "TFButton.h"

#import <Masonry/Masonry.h>

CGFloat const kTFPopupViewSectionHeight         = 10.0f;        /// 分区间距
CGFloat const TFPopupViewContentMaxScale        = 0.65f;        /// 弹窗内容高度与屏幕高度的默认比例
CGFloat const TFPopupViewDefaultMargin          = 14.0f;        /// 默认边距 (标题四边边距, 选项靠左或靠右时距离边缘的距离)
CGFloat const TFPopupViewTitleLineSpacing       = 2.5f;         /// 标题行距
CGFloat const TFPopupViewTitleKernSpacing       = 0.5f;         /// 标题字距
CGFloat const TFPopupViewRowHeight              = 49.0f;        /// 行高

unsigned int const TFPopupViewBackColor                 = 0XFFFFFF;     /// 背景颜色
unsigned int const TFPopupViewTitleColor                = 0X888888;     /// 标题颜色
unsigned int const TFPopupViewRowNormalColor            = 0XFBFBFE;     /// 单元格背景颜色
unsigned int const TFPopupViewRowHighlightedColor       = 0XF1F1F5;     /// 选中高亮颜色
unsigned int const TFPopupViewRowDisabledColor          = 0XE8E8ED;     /// 禁用颜色
unsigned int const TFPopupViewRowTopLineColor           = 0XFFFFFF;     /// 单元格顶部线条颜色
unsigned int const TFPopupViewItemNormalColor           = 0X000000;     /// 选项默 认颜色
unsigned int const TFPopupViewItemHighlightedColor      = 0XE64340;     /// 选项高亮颜色


@interface TFPopupView()

@property (nonatomic, strong) NSString *cancelTitle;
@property (nonatomic, strong) void(^selectedHandler)(void);

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, weak)   UIView *controllerView;
@property (nonatomic, strong) TFView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TFButton *cancelButton;
@property (nonatomic, strong) TFButton *closeButton;
@property (nonatomic, strong) TFView *contentView;

@property (nonatomic, assign) CGFloat size;

/**
 *  内容高度约束
 */
@property (nonatomic, strong) NSLayoutConstraint *heightConstraint;

@end
@implementation TFPopupView


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //NSLog(@"-- TFActionSheet did dealloc -- [%p] -- [%p] -- [%p]", _window, _backView, _tableView);
}

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
                      content:(UIView *)content
                        block:(void(^)(void))block {
    if (!(self = [super init])) return nil;
    
    self.selectedHandler = block;
    self.title = title ? : @"";
    self.cancelTitle = cancelButtonTitle;
//    self.cancelTitle = (cancelButtonTitle && cancelButtonTitle.length != 0) ? cancelButtonTitle : NSLocalizedString(@"cancel", @"cancel");
    self.contentView = content;
    
    [self baseSetting];
    
    [self addHeader];
    [self addSubview:self.contentView];
    [self addFooter];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(0, [self headerView].height, self.contentView.width, self.contentView.height);
}

- (void)addHeader {
    if (!self.title || self.title.length == 0) {
        return;
    }
    
    TFView *headerView = [self headerView];
    [self addSubview:headerView];
}

- (void)addFooter {
    if (!self.cancelTitle || self.cancelTitle.length == 0) {
        return;
    }
    
    TFView *footerView = [self footerView];
    [self addSubview:footerView];
}

// 默认设置
- (void)baseSetting {
    self.backgroundColor = HEXCOLOR(TFPopupViewBackColor, 1);
    self.translatesAutoresizingMaskIntoConstraints = NO; // 允许约束
    
    _hideOnTouchOutside = YES; // 默认点击半透明层隐藏弹窗
    _hideCloseBtn = YES;
    // 监听屏幕旋转
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationDidChange:) name:UIDeviceOrientationDidChangeNotification  object:nil];
}

// 屏幕旋转通知回调
- (void)orientationDidChange:(NSNotification *)notification {
    if (_title.length > 0) {
        // 更新头部标题的高度
//        CGFloat newHeaderHeight = [self heightForHeaderView];
//        CGRect newHeaderRect = _tableView.tableHeaderView.frame;
//        newHeaderRect.size.height = newHeaderHeight;
//        _tableView.tableHeaderView.frame = newHeaderRect;
//        self.tableView.tableHeaderView = self.tableView.tableHeaderView;
        
        // 适配当前内容高度
        [self fixContentHeight];
    }
}

#pragma mark - public

+ (void)showWithTitle:(NSString *)title
    cancelButtonTitle:(NSString *)cancelButtonTitle
              contentView:(UIView *)contentView
                block:(void (^)(void))block {
    TFPopupView *popupView = [[TFPopupView alloc] initWithTitle:title cancelButtonTitle:cancelButtonTitle content:contentView block:block];
    [popupView show];
}

/// 单展示, 不绑定block回调
- (void)show {
    
    _backView = [[TFView alloc] init];
    _backView.alpha = 0.0f;
    _backView.backgroundColor = [UIColor blackColor];
    _backView.userInteractionEnabled = _hideOnTouchOutside;
    self.closeButton.hidden = self.hideCloseBtn;
    //_backView.translatesAutoresizingMaskIntoConstraints = NO;
    [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewGesture)]];
    
    [_controllerView addSubview:_backView];
    
    [_backView masViewEqualToSuperViewWithInsets:UIEdgeInsetsZero];
    
    // 内容高度
    CGFloat contentHeight = self.contentView.height;
    
    // 适配屏幕高度
    CGFloat contentMaxHeight = CGRectGetHeight(self.window.frame) * TFPopupViewContentMaxScale;
    if (contentHeight > contentMaxHeight) {
        contentHeight = contentMaxHeight;
    }
    
    [_controllerView addSubview:self];
    
    CGFloat selfW = CGRectGetWidth(_controllerView.frame);
    
    CGFloat footerViewHeigth = [self footerView].height;
    CGFloat selfSize = self.size;
    CGFloat selfH = [self headerView].height + contentHeight + footerViewHeigth + selfSize;
    CGFloat selfX = 0;
    //CGFloat selfY = CGRectGetMaxY(_controllerView.frame);
    //self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(selfH);
        make.left.offset(selfX);
        make.width.equalTo(@(selfW));
        make.height.equalTo(@(selfH));
    }];
    
    [self.contentView setHeight:contentHeight];
    
    //self.backgroundColor = UIColor.whiteColor;
    
    [self.window makeKeyAndVisible];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self->_backView.alpha   = 0.38;
//        CGRect newFrame   = self.frame;
//        newFrame.origin.y = CGRectGetMaxY(_controllerView.frame) - selfH;
//        self.frame        = newFrame;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(0);
            make.top.offset((CGRectGetMaxY(self->_controllerView.frame) - selfH));
        }];
    } completion:^(BOOL finished) {
        // constraint
        
//        [_controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
//        [_controllerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
//        self.heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:contentHeight];
//        [_controllerView addConstraint:_heightConstraint];
    }];
}

#pragma mark - private

// 计算title在设定宽度下的富文本高度
- (CGFloat)heightForHeaderView {
    CGFloat labelHeight = [_titleLabel.attributedText boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.window.frame) - TFPopupViewDefaultMargin * 2, MAXFLOAT)
                                                                   options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                                   context:nil].size.height;
    CGFloat headerHeight = ceil(labelHeight) + TFPopupViewDefaultMargin * 2;
    
    return headerHeight;
}

// 整个弹窗内容的高度
- (CGFloat)contentHeight {
    CGFloat titleHeight = (_title.length > 0) ? [self heightForHeaderView] : 0;
    CGFloat rowHeightSum = _contentView.height;
    CGFloat contentHeight = titleHeight + rowHeightSum + self.size;
    
    return contentHeight;
}

// 适配屏幕高度, 弹出窗高度不应该高于屏幕的设定比例
- (void)fixContentHeight {
    //CGFloat contentMaxHeight = CGRectGetHeight(self.window.frame) * TFPopupViewContentMaxScale;
    CGFloat contentHeight = [self contentHeight];
    
    _heightConstraint.constant = contentHeight;
}

// 适配标题偏移方向
- (void)updateTitleAttributeText {
    if (_title.length == 0 || !_titleLabel) {
        return;
    }
    
    // 富文本相关配置
    NSRange  attributeRange = NSMakeRange(0, _title.length);
    UIFont  *titleFont      = [UIFont boldSystemFontOfSize:16];
    UIColor *titleTextColor = HEXCOLOR(0x333333, 1);
    CGFloat  lineSpacing = TFPopupViewTitleLineSpacing;
    CGFloat  kernSpacing = TFPopupViewTitleKernSpacing;
    
    NSMutableAttributedString *titleAttributeString = [[NSMutableAttributedString alloc] initWithString:_title];
    NSMutableParagraphStyle *titleStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 行距
    titleStyle.lineSpacing = lineSpacing;
    
    // 内容偏移样式
    titleStyle.alignment = NSTextAlignmentCenter;
    
    [titleAttributeString addAttribute:NSParagraphStyleAttributeName value:titleStyle range:attributeRange];
    
    // 字距
    [titleAttributeString addAttribute:NSKernAttributeName value:@(kernSpacing) range:attributeRange];
    
    // 字体
    [titleAttributeString addAttribute:NSFontAttributeName value:titleFont range:attributeRange];
    
    // 颜色
    [titleAttributeString addAttribute:NSForegroundColorAttributeName value:titleTextColor range:attributeRange];
    
    _titleLabel.attributedText = titleAttributeString;
}


/// 点击背景半透明遮罩层隐藏
- (void)backViewGesture {
    [self hideWithCompletion:nil];
}

/// 隐藏
- (void)hideWithCompletion:(void(^)(void))completion {
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self->_backView.alpha   = 0;
        CGRect newFrame   = self.frame;
        newFrame.origin.y = CGRectGetMaxY(self->_controllerView.frame);
        self.frame        = newFrame;
    } completion:^(BOOL finished) {
        [[APP_APPLICATION.delegate window] makeKeyWindow];
        if (completion) {
            completion();
        }
        
        [self->_backView removeFromSuperview];
        self->_backView = nil;
        
        [self->_contentView removeFromSuperview];
        self->_contentView = nil;
        
        [self removeFromSuperview];
        
        self->_window = nil;
        self->_selectedHandler = nil;
    }];
}

#pragma mark - getter

- (UIWindow *)window {
    if (_window) {
        return _window;
    }
    
    _window = [[UIWindow alloc] initWithFrame:MAIN_SCREEN.bounds];
    _window.windowLevel = UIWindowLevelStatusBar+1;
    _window.rootViewController = [[UIViewController alloc] init];
    
    self.controllerView = _window.rootViewController.view;
    
    return _window;
}

- (TFView *)headerView {
    TFView *headerView = [[TFView alloc] init];
    headerView.backgroundColor = HEXCOLOR(TFPopupViewRowNormalColor, 1);
    
    // 标题
    TFLabel *titleLabel = [[TFLabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = HEXCOLOR(TFPopupViewTitleColor, 1);
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.titleLabel = titleLabel;
    
    // 设置富文本标题内容
    [self updateTitleAttributeText];
    
    TFButton *closeButton = [TFButton new];
    UIImage *btnImage = [UIImage imageNamed:@"button_close_normal"];
    [closeButton setNormalBackgroundImage:btnImage selectedBackgroundImage:btnImage disabledBackgroundImage:btnImage];
    [closeButton touchAction:^{
        [self hideWithCompletion:^{
            if (self.selectedHandler) {
                self.selectedHandler();
            }
        }];
    }];
    
    self.closeButton = closeButton;
    
    TFView *lineView = [TFView new];
    lineView.backgroundColor = HEXCOLOR(TFPopupViewRowTopLineColor, 1);
    
    // 计算内容高度
    CGFloat headerHeight = [self heightForHeaderView];
    headerView.frame = CGRectMake(0, 0, CGRectGetWidth(self.window.frame), headerHeight);
    
    [headerView addSubview:closeButton];
    [headerView addSubview:titleLabel];
    [headerView addSubview:lineView];
    
    // 标题内容边距 (ps: 要修改这个边距不要在这里修改这个labelMargin, 要到配置类中修改 TFPopupViewDefaultMargin, 不然可能出现界面适配错乱).
    CGFloat labelMargin = TFPopupViewDefaultMargin;
    
    // titleLabel constraint
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(labelMargin);
        make.right.offset(-labelMargin);
        make.height.equalTo(@(headerHeight));
    }];
    
    [self.closeButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(24));
        make.centerY.equalTo(self.titleLabel);
        make.right.offset(-16);
    }];
    
    [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.equalTo(@(1.0f));
    }];
    
    return headerView;
}

- (TFView *)footerView {
    if (!self.cancelTitle || self.cancelTitle.length == 0) {
        return [TFView new];
    }
    
    TFButton *cancelButton = [TFButton new];
    [cancelButton setNormalTitle:self.cancelTitle textFont:[UIFont systemFontOfSize:17] textColor:HEXCOLOR(TFPopupViewItemNormalColor, 1)];
    [cancelButton setNormalBackgroundImage:[UIImage imageWithColor:HEXCOLOR(TFPopupViewRowNormalColor, 1)]
               hightlightedBackgroundImage:[UIImage imageWithColor:HEXCOLOR(TFPopupViewRowHighlightedColor, 1)]
                   disabledBackgroundImage:[UIImage imageWithColor:HEXCOLOR(TFPopupViewRowDisabledColor, 1)]];
    [cancelButton touchAction:^{
        [self hideWithCompletion:^{
            if (self.selectedHandler) {
                self.selectedHandler();
            }
        }]; 
    }];

    self.cancelButton = cancelButton;
    
    CGFloat footY = [self headerView].height + self.contentView.height + kTFPopupViewSectionHeight;
    
    TFView *footerView = [[TFView alloc] init];
    footerView.backgroundColor = HEXCOLOR(0xFBFBFE, 1);
    footerView.frame = CGRectMake(0, footY, CGRectGetWidth(self.window.frame), TFPopupViewRowHeight);
    
    [footerView addSubview:self.cancelButton];
    
    [self.cancelButton masViewEqualToSuperViewWithInsets:UIEdgeInsetsZero];
    
    return footerView;
}

- (CGFloat)size {
    if (@available(iOS 11.0, *)) {
        _size = self.window.safeAreaInsets.bottom;
    }
    
    return _size;
}

@end
