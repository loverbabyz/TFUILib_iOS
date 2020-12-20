//
//  TFCollectionViewCell.m
//  TFUILib
//
//  Created by xiayiyong on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFCollectionViewCell.h"

@implementation TFCollectionViewCell

+ (id)loadCellFromXib {
    return [UINib nibWithNibName:[self reusableIdentifier] bundle:[NSBundle mainBundle]];
}

+ (NSString*)reusableIdentifier {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initViews];
    [self autolayoutViews];
    [self bindData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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

+ (CGFloat)cellHeight {
    return 44;
}

@end
