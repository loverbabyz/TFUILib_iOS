//
//  NSBundle+TFUILib_iOS.m
//  LightBundle_iOS
//
//  Created by SunXiaofei on 09/16/2020.
//  Copyright (c) 2020 daniel.xiaofei@gmail.com All rights reserved.
//

#import "NSBundle+TFUILib_iOS.h"
#import "TFView.h"

@implementation NSBundle (TFUILib_iOS)

+ (instancetype)tflib_refreshBundle {
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        refreshBundle = [NSBundle bundleWithPath:[self tflib_bundlePath]];
    }
    return refreshBundle;
}

+ (NSString *)tflib_bundlePath {
    NSBundle *bundle = [NSBundle bundleForClass:[TFView class]];
    NSString *path = [bundle pathForResource:@"TFUILib_iOS" ofType:@"bundle"];
    
    return path;
}

+ (UIImage *)tflib_imageWithName:(NSString *)name {
    return [[UIImage imageWithContentsOfFile:[[self tflib_refreshBundle] pathForResource:name ofType:@"png"]]  imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
