//
//  TFTableViewCell.m
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFTableViewCell.h"
#import "TFTableRowModel.h"
#import "TFUILibMacro.h"

@implementation TFTableViewCell

+ (id)loadCellFromXib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    
    if ([data isMemberOfClass:[TFTableRowModel class]])
    {
        TFTableRowModel *model = (TFTableRowModel *)data;
        self.textLabel.text      = model.title;
        
        if (model.thumbnail) {
            self.imageView.image = TF_IMAGE(model.thumbnail);
        }
        
        if (model.content) {
            self.detailTextLabel.text = model.content;
        }
    }
}

-(CGFloat)cellHeight
{
    return 44;
}

+(CGFloat)cellHeightWithData:(id)model width:(CGFloat)width
{
    return 0;
}

+(CGFloat)cellHeight
{
    return 44;
}

+(NSString*)reusableIdentifier
{
    return NSStringFromClass([self class]);
}

@end
