//
//  UIImageView+Placeholder.m
//  Treasure
//
//  Created by Daniel on 15/11/24.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "UIImageView+Placeholder.h"
//#import "UIImageView+WebCache.h"

@implementation UIImageView (Placeholder)

- (void)setImageWithName:(NSString *)name placeholderImage:(NSString *)placeholder
{
    if (name == nil && placeholder == nil) {
        return;
    }
    
    if (name==nil)
    {
        [self setImage:[UIImage imageNamed:placeholder]];
    }
    else if ([name hasPrefix:@"http"])
    {
        NSAssert(YES, @"TODO...");
        // 如果占位图片为空，不设置占位图，避免出现<CUICatalog: Invalid asset name supplied: ''>调试警告
        /*
        if (placeholder && placeholder.length > 0) {
            [self sd_setImageWithURL:[NSURL URLWithString:name] placeholderImage:[UIImage imageNamed:placeholder]];
        } else {
            [self sd_setImageWithURL:[NSURL URLWithString:name]];
        }
        */
    }
    else
    {
        if (name.length) {
            [self setImage:[UIImage imageNamed:name]];
        } else {
            [self setImage:[UIImage imageNamed:placeholder]];
        }
    }
}


@end
