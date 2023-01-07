//
//  Created by Daniel on 16/3/29.
//  含label textview 的cell
//
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TFTableViewCell.h"

@interface TFLabelTextViewCell : TFTableViewCell

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UITextView *textView;

@end
