//
//  TFSearchBar.m
//
//  Created by developer on 2017/9/27.
//  Copyright © 2017年 仁伯安. All rights reserved.
//

#import "TFSearchBarView.h"
#import <TFBaseLib_iOS/TFBaseMacro+System.h>

@interface TFSearchBarView()<UITextFieldDelegate>
{
    TFSearchBarIconAlign _iconAlignTemp;
    UITextField *_textField;
}

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *iconCenterImageView;

@end

@implementation TFSearchBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
    [self sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self sizeToFit];
    //NSLog(@"_textField.width.frame=%@", NSStringFromCGRect(self.frame));
}

/**
 * 撑开view的布局
 @return CGSize
 */
- (CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
}

- (void)initView
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 44);
    if (!_isHiddenCancelButton)
    {
        [self addSubview:self.cancelButton];
        self.cancelButton.hidden = YES;
    }

    [self addSubview:self.textField];

    //    self.backgroundColor = [UIColor colorWithRed:0.733 green:0.732 blue:0.756 alpha:1.000];

    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

/**
 * 右边取消按钮
 @return UIButton
 */
- (UIButton *)cancelButton
{
    if (!_cancelButton)
    {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(self.frame.size.width - 60, 7, 60, 30);
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_cancelButton addTarget:self action:@selector(cancelButtonTouched) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setTitle:NSLocalizedString(@"cancel", @"cancel") forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
    
    return _cancelButton;
}

/**
 * 搜索框
 @return UITextField
 */
- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(7, 7, self.frame.size.width - 7 * 2, 30)];
        _textField.delegate = self;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.enablesReturnKeyAutomatically = YES;
        _textField.font = [UIFont systemFontOfSize:14.0f];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.layer.cornerRadius = 3.0f;
        _textField.layer.masksToBounds = YES;
        _textField.backgroundColor = [UIColor colorWithRed:240.0 / 255.0 green:245.0 / 255.0 blue:245.0 / 255.0 alpha:1.0];
    }
    
    return _textField;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TFSearchBarView.bundle/icon_search_normal"]];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    
    return _iconImageView;
}

- (void)setIconAlign:(TFSearchBarIconAlign)iconAlign
{
    if(!_iconAlignTemp)
    {
        _iconAlignTemp = iconAlign;
    }
    
    _iconAlign = iconAlign;
    [self ajustIconWith:_iconAlign];
}

- (void)ajustIconWith:(TFSearchBarIconAlign)iconAlign
{
    if (_iconAlign == TFSearchBarIconAlignCenter && ([self.text isKindOfClass:[NSNull class]] || !self.text || [self.text isEqualToString:@""] || self.text.length == 0) && ![_textField isFirstResponder])
    {
        self.iconCenterImageView.hidden = NO;
        _textField.frame = CGRectMake(7, 7, self.frame.size.width - 7 * 2, 30);
        _textField.textAlignment = NSTextAlignmentCenter;

        CGSize titleSize; // 输入的内容或者placeholder数据

        titleSize =  [self.placeholder?:@"" sizeWithAttributes: @{NSFontAttributeName:_textField.font}];

        //NSLog(@"----%f", _textField.frame.size.width);
        CGFloat x = _textField.frame.size.width / 2.f - titleSize.width / 2.f - 30;
        if (!self.iconCenterImageView)
        {
            self.iconCenterImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TFSearchBarView.bundle/icon_search_normal"]];
            self.iconCenterImageView.contentMode = UIViewContentModeCenter;
            [_textField addSubview:self.iconCenterImageView];
        }

        //        [UIView animateWithDuration:1 animations:^{
        self.iconCenterImageView.frame = CGRectMake(x > 0 ? x : 0, 0, self.iconCenterImageView.frame.size.width, self.iconCenterImageView.frame.size.height);
        //self.iconCenterImageView.hidden = x > 0 ? NO : YES;
        _textField.leftView = x > 0 ? nil : _iconImageView;
        _textField.leftViewMode =  x > 0 ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
        //        }];
    }
    else
    {
        self.iconCenterImageView.hidden = YES;
        [UIView animateWithDuration:1 animations:^{
            self->_textField.textAlignment = NSTextAlignmentLeft;
            self->_textField.leftView = self->_iconImageView;
            self->_textField.leftViewMode =  UITextFieldViewModeAlways;
        }];
    }
}


- (NSString *)text
{
    return _textField.text;
}

- (void)setText:(NSString *)text
{
    _textField.text = text?:@"";
    [self setIconAlign:_iconAlign];
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    [_textField setFont:_textFont];
}

- (void)setTextBorderStyle:(UITextBorderStyle)textBorderStyle
{
    _textBorderStyle = textBorderStyle;
    _textField.borderStyle = textBorderStyle;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [_textField setTextColor:_textColor];
}

- (void)setIconImage:(UIImage *)iconImage
{
    if (!iconImage) {
        return;
    }
    
    _iconImage = iconImage;
    
    self.iconCenterImageView.image = _iconImage;
    self.iconImageView.image = _iconImage;

    _textField.leftViewMode =  UITextFieldViewModeAlways;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
    _textField.contentMode = UIViewContentModeScaleAspectFit;
    if (self.placeholderColor)
    {
        [self setPlaceholderColor:_placeholderColor];
    }
    [self setIconAlign:_iconAlign];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    _textField.backgroundColor = [UIColor clearColor];
    _textField.background = _backgroundImage;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType
{
    _keyboardType = keyboardType;
    _textField.keyboardType = _keyboardType;
}

- (void)setInputView:(UIView *)inputView
{
    _inputView = inputView;
    _textField.inputView = _inputView;
}

- (BOOL)isUserInteractionEnabled
{
    return YES;
}

- (void)setInputAccessoryView:(UIView *)inputAccessoryView
{
    _inputAccessoryView = inputAccessoryView;
    _textField.inputAccessoryView = _inputAccessoryView;
}

- (void)setTextFieldColor:(UIColor *)textFieldColor
{
    _textField.backgroundColor = textFieldColor;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    NSAssert(_placeholderColor, @"Please set placeholder before setting placeholdercolor");

    if ([SYSTEM_VERSION integerValue] < 6)
    {
        [_textField setValue:_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    else
    {//TODO: ///asdfasdf
        //        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
        if ([self.placeholder isKindOfClass:[NSNull class]] || !self.placeholder || [self.placeholder isEqualToString:@""])
        {
            //
        }
        else
        {
            _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:
                                                @{NSForegroundColorAttributeName:placeholderColor,
                                                  NSFontAttributeName:_textField.font
                                                  }];
        }
    }
}

- (BOOL)isFirstResponder
{
    return [_textField isFirstResponder];
}

- (BOOL)resignFirstResponder
{
    return [_textField resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [_textField becomeFirstResponder];
}

- (void)cancelButtonTouched
{
    //_textField.text = @"";
    [_textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)])
    {
        [self.delegate searchBarCancelButtonClicked:self];
    }
}

- (void)setAutoCapitalizationMode:(UITextAutocapitalizationType)type
{
    _textField.autocapitalizationType = type;
}

#pragma mark - textfield delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)])
    {
        return [self.delegate searchBarShouldBeginEditing:self];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(_iconAlignTemp == TFSearchBarIconAlignCenter)
    {
        self.iconAlign = TFSearchBarIconAlignLeft;
    }
    
    if (!_isHiddenCancelButton)
    {
        [UIView animateWithDuration:0.1 animations:^{
            self->_cancelButton.hidden = NO;
            self->_textField.frame = CGRectMake(7, 7, self->_cancelButton.frame.origin.x - 7, 30);
            // _textField.transform = CGAffineTransformMakeTranslation(-_cancelButton.frame.size.width,0);
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)])
    {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)])
    {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(_iconAlignTemp == TFSearchBarIconAlignCenter)
    {
        self.iconAlign = TFSearchBarIconAlignCenter;
    }
    
    if (!_isHiddenCancelButton)
    {
        [UIView animateWithDuration:0.1 animations:^{
            self->_cancelButton.hidden = YES;
            self->_textField.frame = CGRectMake(7, 7, self.frame.size.width - 7*2, 30);
            // _textField.transform = CGAffineTransformMakeTranslation(-_cancelButton.frame.size.width,0);
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)])
    {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:textField.text];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)])
    {
        return [self.delegate searchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)])
    {
        [self.delegate searchBar:self textDidChange:@""];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)])
    {
        [self.delegate searchBarSearchButtonClicked:self];
    }
    
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([object isEqual:self] && [keyPath isEqualToString:@"frame"])
    {
        // _textField.frame = CGRectMake(7, 7, self.frame.size.width - 7*2, 30);
        //NSLog(@"----%f", self.frame.size.width);
        [self ajustIconWith:_iconAlign];
    }
}

- (void)dealloc
{
    //NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
