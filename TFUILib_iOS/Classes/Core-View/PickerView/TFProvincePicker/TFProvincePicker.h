//
//  TFProvincePicker.h
//  Treasure
//
//  Created by Daniel on 16/1/25.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFView.h"

typedef void (^TFProvincePickerBlock)(NSString *province);

@interface TFProvincePicker : TFView

/**
 *  选择省份
 *
 *  @param block  block
 */
+ (void)showWithBlock:(TFProvincePickerBlock)block;

@end
