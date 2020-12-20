//
//  TFCollectionReusableView.m
//  TFUILib
//
//  Created by Daniel on 2020/7/15.
//  Copyright © 2020 com.treasure.TFUILib. All rights reserved.
//

#import "TFCollectionReusableView.h"

@implementation TFCollectionReusableView


+ (id)loadViewFromXib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
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
