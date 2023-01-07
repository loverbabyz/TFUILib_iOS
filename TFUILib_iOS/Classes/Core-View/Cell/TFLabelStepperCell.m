//
//  Created by Daniel on 16/3/29.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFLabelStepperCell.h"

@interface TFLabelStepperCell ()

@end

@implementation TFLabelStepperCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(!(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [UIColor blackColor];
    _label.highlightedTextColor = [UIColor whiteColor];
    _label.font = [UIFont boldSystemFontOfSize:12.0];
    _label.adjustsFontSizeToFitWidth = YES;
    _label.baselineAdjustment = UIBaselineAdjustmentNone;
    _label.numberOfLines = 20;
    [self.contentView addSubview:_label];
    
    self.stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
    self.accessoryView = self.stepper;
    
    return self;
}

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect r = CGRectInset(self.contentView.bounds, 8, 0);
    r.size = CGSizeMake(72,r.size.height);
    _label.frame = r;
}

@end;
