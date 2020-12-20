//
//  TFYearPicker.h
//  TFUILib
//
//  Created by xiayiyong on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFPicker.h"

typedef void (^TFYearPickerBlock)(NSString *year);

@interface TFYearPicker : TFPicker

/**
 *  年份选择
 *
 *  @param block  block
 */
+ (void)showWithBlock:(TFYearPickerBlock)block;

@end

