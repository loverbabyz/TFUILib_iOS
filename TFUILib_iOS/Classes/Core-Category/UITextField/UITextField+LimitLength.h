//
//  UITextField+LimitLength.h
//  TextLengthLimitDemo
//
//  Created by Daniel on 15/7/1.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LimitLength)

/**
 *  限制输入框可输入的字符串长度
 *
 *  @param length  length
 */
- (void)limitTextLength:(int)length;

@end
