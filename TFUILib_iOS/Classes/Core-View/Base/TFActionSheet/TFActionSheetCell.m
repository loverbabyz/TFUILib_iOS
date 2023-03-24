//
//  FSActionSheetCell.m
//  FSActionSheet
//
//  Created by Steven on 6/7/16.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "TFActionSheetCell.h"
#import "TFActionSheetItem.h"
#import <TFBaseLib_iOS/TFBaseMacro+System.h>

@interface TFActionSheetCell ()

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, weak) UIView *topLine; ///< 顶部线条

@end

@implementation TFActionSheetCell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        self.contentView.backgroundColor = TFColorWithString(TFActionSheetRowHighlightedColor);
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.backgroundColor = self.backgroundColor;
        }];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    self.backgroundColor = TFColorWithString(TFActionSheetRowNormalColor);
    self.contentView.backgroundColor = self.backgroundColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _contentAlignment = TFContentAlignmentCenter;
    
    [self setupSubviews];
    
    return self;
}

- (void)setupSubviews {
    _titleButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _titleButton.tintColor = TFColorWithString(TFActionSheetItemNormalColor);
    _titleButton.titleLabel.font = [UIFont systemFontOfSize:TFActionSheetItemTitleFontSize];
    _titleButton.userInteractionEnabled = NO;
    _titleButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleButton];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleButton)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleButton)]];
    
    // 顶部线条
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = TFColorWithString(TFActionSheetRowTopLineColor);
    topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:topLine];
    self.topLine = topLine;
    CGFloat lineHeight = 1 / TF_MAIN_SCREEN.scale; ///< 线条高度
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topLine]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topLine)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLine(lineHeight)]" options:0 metrics:@{@"lineHeight":@(lineHeight)} views:NSDictionaryOfVariableBindings(topLine)]];
}

- (void)setItem:(TFActionSheetItem *)item {
    _item = item;
    
    // 前景色设置, 如果有自定义前景色则使用自定义的前景色, 否则使用预配置的颜色值.
    UIColor *tintColor;
    if (item.tintColor) {
        tintColor = item.tintColor;
    } else {
        if (_item.type == TFActionSheetTypeNormal) {
            tintColor = TFColorWithString(TFActionSheetItemNormalColor);
        } else {
            tintColor = TFColorWithString(TFActionSheetItemHighlightedColor);
        }
    }
    _titleButton.tintColor = tintColor;
    
    // 调整图片与标题的间距
    _titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, _item.image?-TFActionSheetItemContentSpacing/2:0,
                                                    _item.image?1:0, _item.image?TFActionSheetItemContentSpacing/2:0);
    _titleButton.titleEdgeInsets = UIEdgeInsetsMake(_item.image?1:0, _item.image?TFActionSheetItemContentSpacing/2:0,
                                                    0, _item.image?-TFActionSheetItemContentSpacing/2:0);
    // 设置图片与标题
    [_titleButton setTitle:item.title forState:UIControlStateNormal];
    [_titleButton setImage:item.image forState:UIControlStateNormal];
}

- (void)setContentAlignment:(TFContentAlignment)contentAlignment {
    if (_contentAlignment == contentAlignment) return;
    
    _contentAlignment = contentAlignment;
    // 更新button的图片和标题Edge
    [self updateButtonContentEdge];
    // 设置内容偏移
    switch (_contentAlignment) {
            // 局左
        case TFContentAlignmentLeft: {
            _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            _titleButton.contentEdgeInsets = UIEdgeInsetsMake(0, TFActionSheetDefaultMargin, 0, -TFActionSheetDefaultMargin);
            break;
        }
            // 居中
        case TFContentAlignmentCenter: {
            _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            _titleButton.contentEdgeInsets = UIEdgeInsetsZero;
            break;
        }
            // 居右
        case TFContentAlignmentRight: {
            _titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            _titleButton.contentEdgeInsets = UIEdgeInsetsMake(0, -TFActionSheetDefaultMargin, 0, TFActionSheetDefaultMargin);
            break;
        }
    }
}

// 更新button图片与标题的edge
- (void)updateButtonContentEdge {
    if (!_item.image) return;
    if (_contentAlignment == TFContentAlignmentRight) {
        CGFloat titleWidth = [[_titleButton titleForState:UIControlStateNormal] sizeWithAttributes:@{NSFontAttributeName:_titleButton.titleLabel.font}].width;
        _titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth, 1, -titleWidth);
        _titleButton.titleEdgeInsets = UIEdgeInsetsMake(1, -_item.image.size.width-TFActionSheetItemContentSpacing,
                                                        0, _item.image.size.width+TFActionSheetItemContentSpacing);
    } else {
        _titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, -TFActionSheetItemContentSpacing/2, 1, TFActionSheetItemContentSpacing/2);
        _titleButton.titleEdgeInsets = UIEdgeInsetsMake(1, TFActionSheetItemContentSpacing/2, 0, -TFActionSheetItemContentSpacing/2);
    }
}

- (void)setHideTopLine:(BOOL)hideTopLine {
    _topLine.hidden = hideTopLine;
}

@end

