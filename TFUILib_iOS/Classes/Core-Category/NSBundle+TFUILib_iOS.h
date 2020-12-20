//
//  NSBundle+TFUILib_iOS.h
//  LightBundle_iOS
//
//  Created by SunXiaofei on 09/16/2020.
//  Copyright (c) 2020 daniel.xiaofei@gmail.com All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (TFUILib_iOS)

/// 当前bundle文件
+ (instancetype)tflib_refreshBundle;

/// /// 当前bundle文件路径
+ (NSString *)tflib_bundlePath;

/// 当前bundle文件中的图片资源
/// @param name 名称
+ (UIImage *)tflib_imageWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
