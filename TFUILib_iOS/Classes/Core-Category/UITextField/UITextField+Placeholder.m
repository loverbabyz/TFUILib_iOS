//
//  UITextField+Placeholder.m
//  Treasure
//
//  Created by Daniel on 15/7/1.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

- (UIColor *)placeholderColor
{
    return [self valueForKey:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
  [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (UIFont *)placeholderFont
{
    return [self valueForKey:@"_placeholderLabel.font"];
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
  [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}

@end
