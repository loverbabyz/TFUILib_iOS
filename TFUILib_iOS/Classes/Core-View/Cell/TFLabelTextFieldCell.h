//
//  Created by xiayiyong on 16/3/29.
//  含label textfield 的cell
//
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TFTableViewCell.h"

@interface TFLabelTextFieldCell : TFTableViewCell<UITextFieldDelegate>

/**
 *  标签
 */
@property (nonatomic,strong) UILabel *label;

/**
 *  输入框
 */
@property (nonatomic,strong) UITextField *textField;

@end
