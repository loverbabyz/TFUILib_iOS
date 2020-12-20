//
//  FSActionSheetItem.m
//  FSActionSheet
//
//  Created by Steven on 16/5/11.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "TFActionSheetItem.h"

@implementation TFActionSheetItem

+ (instancetype)itemWithType:(TFActionSheetType)type image:(UIImage *)image title:(NSString *)title tintColor:(UIColor *)tintColor
{
    TFActionSheetItem *item = [[TFActionSheetItem alloc] init];
    item.type  = type;
    item.image = image;
    item.title = title;
    item.tintColor = tintColor;
    
    return item;
}

@end
