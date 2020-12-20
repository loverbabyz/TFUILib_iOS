//
//  TFTextViewCell.h
//  TFUILib
//  含textview的cell
//
//  Created by xiayiyong on 16/3/7.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTableViewCell.h"
#import "TFTextView.h"

@interface TFTextViewCell : TFTableViewCell

// 输入框
@property (nonatomic,strong) TFTextView *textView;

@end
