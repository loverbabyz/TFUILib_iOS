//
//  TFCollectionViewCell.m
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFCollectionViewCell.h"
#import <TFBaseLib_iOS/TFBaseMacro+Path.h>

@implementation TFCollectionViewCell

+ (id)loadCellFromXib {
    return [UINib nibWithNibName:[self reusableIdentifier] bundle:TF_MAIN_BUNDLE];
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
