//
//  TFView.m
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFView.h"
#import <TFBaseLib_iOS/TFBaseMacro+Path.h>

@implementation TFView

#pragma mark- init autolayout bind

+ (id)loadViewFromXib
{
    NSArray* nibView = [TF_MAIN_BUNDLE loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initViews];
    [self autolayoutViews];
    [self bindData];
}

- (instancetype)init {
    if (self = [super init]) {
        [self initViews];
        [self autolayoutViews];
        [self bindData];
    }
    
    return self;
}

- (void)initViews
{
    
}

- (void)autolayoutViews
{
    
}

- (void)bindData
{
    
}

- (void)setSafeAreaInset:(UIEdgeInsets)safeAreaInsets {
}

- (void)setData:(id)data {
    _data = data;
}

+ (CGFloat)viewHeight {
    return 0.0f;
}

@end
