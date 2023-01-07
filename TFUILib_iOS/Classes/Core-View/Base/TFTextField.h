//
//  TFTextField.h
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+Category.h"

@interface TFTextField : UITextField

/**
 *  文本离左边框的距离
 */
@property (nonatomic, strong) NSNumber *leftMargin;

/**
 *  底边颜色
 */
@property (nonatomic, strong) UIColor *bottomBorderColor;

/**
 *  初始化Textfield
 *
 *  @param frame       尺寸
 *  @param text        输入文字
 *  @param placeholder 占位符
 *
 *  @return Textfield
 */
- (instancetype)initWithFrame:(CGRect)frame
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder;

@end
