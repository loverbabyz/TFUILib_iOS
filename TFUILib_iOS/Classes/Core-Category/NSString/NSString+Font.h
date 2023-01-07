//
//  NSString+Font.h
//  TFBaseLib
//
//  Created by Daniel on 16/3/14.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Font)

- (CGSize)widthWithFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthWithFont:(UIFont *)font;

- (CGFloat)widthWithFont:(UIFont *)font width:(CGFloat)width;

- (CGFloat)heightWithFont:(UIFont *)font;

- (CGFloat)heightWithFont:(UIFont *)font width:(CGFloat)width;

@end
