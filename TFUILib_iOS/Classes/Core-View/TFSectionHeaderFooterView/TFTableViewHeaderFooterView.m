//
//  TFTableViewHeaderFooterView.m
//  TFUILib
//
//  Created by Daniel.Sun on 2017/12/19.
//  Copyright © 2017年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFTableViewHeaderFooterView.h"

@implementation TFTableViewHeaderFooterView

+ (id)loadViewFromXib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initViews];
        [self autolayoutViews];
        [self bindData];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initViews];
        [self autolayoutViews];
        [self bindData];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initViews];
    [self autolayoutViews];
    [self bindData];
}

- (void)initViews
{
    self.textLabel.font      = TF_AppFont(14);
    self.textLabel.textColor = TF_HRGBA(0X333333, 1);
}

- (void)autolayoutViews
{
    
}

- (void)bindData
{
    
}

-(void)setData:(id)data
{
    _data = data;
    
    if ([data isKindOfClass:[TFTableSectionModel class]])
    {
        TFTableSectionModel *model = (TFTableSectionModel *)data;
        self.textLabel.text = model.title;
    }
}

- (CGFloat)viewHeight
{
    return 38;
}

+ (CGFloat)viewHeight
{
    return 38;
}

+ (NSString*)reusableIdentifier
{
    return NSStringFromClass([self class]);
}

@end
