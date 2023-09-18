//
//  TFMacro+Color.h
//  Treasure
//
//  Created by Daniel on 15/9/14.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#if __has_include("TFUILibMacro+View.h")
#import "TFUILibMacro+View.h"
#endif
/**
 *  读取本地图片
 *
 *  @param file 地址
 *  @param ext  类型
 *
 *  @return 获取到的图片
 */
#ifndef TF_LOADIMAGE
#define TF_LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[TF_MAIN_BUNDLEpathForResource:file ofType:ext]]
#endif

/**
 *  定义UIImage对象
 *
 *  @param name image的名字
 *
 *  @return UIImage对象
 */
#ifndef TF_IMAGE
#define TF_IMAGE(name) [UIImage imageNamed:name]
#endif

/**
 *  创建alter
 *
 *  @param title title
 *  @param msg   内容
 *
 *  @return alter
 */
#ifndef TF_ALERT
#define TF_ALERT(title, msg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
cancelButtonTitle:NSLocalizedString(@"ok", @"ok") \
otherButtonTitles:nil]; \
[alert show];
#endif

/**
 *  创建imageview并设置偏移量
 *
 *  @param name   name
 *  @param top    top
 *  @param left   left
 *  @param bottom bottom
 *  @param right  right
 *
 *  @return 设置好的image
 */
#ifndef TF_RESIZABLE_IMAGE
#define TF_RESIZABLE_IMAGE(name,top,left,bottom,right) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#endif

/**
 *  创建imageview并设置偏移量
 *
 *  @param name   name
 *  @param top    top
 *  @param left   left
 *  @param bottom bottom
 *  @param right  right
 *  @param mode   mode
 *
 *  @return 设置好的image
 */
#ifndef TF_RESIZABLE_IMAGE_MODEL
#define TF_RESIZABLE_IMAGE_MODEL(name,top,left,bottom,right,mode) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]
#endif

/**
 * 通过不同机型的设计稿像素值获取高度
 *
 *  @param p_x1  x1像素
 *  @param p_x2  x2像素
 *  @param p_x3  x3像素
 *
 */
#ifndef TF_STYLE_BY_PIXEL
#define TF_STYLE_BY_PIXEL(p_x1, p_x2, p_x3) (TF_TARGET_IPHONE_6PLUS ? p_x3 / 3.0 : (TF_TARGET_IPHONE_6 ? p_x2 / 2.0 : p_x1 / 2.0))
#endif

/**
* 通过设计稿像素值获取高度
*
*  @param pixel  设计稿像素
*
*/
#ifndef TF_STYLE_BY_PIX
#define TF_STYLE_BY_PIX(pixel) pixel * TF_MAIN_SCREEN.scale
#endif

/**
 *  通过设计稿中给的像素获取实际设备像素
 *
 *  @param designedPixel 设计稿中给的像素值
 */
#ifndef TF_REAL_PIXEL
#define TF_REAL_PIXEL(designedPixel) (TF_TARGET_IPHONE_6PLUS ? (designedPixel / 3.0) : (designedPixel / 2.0))
#endif

#ifndef TF_WIDTH_SCALE
#define TF_HEIGHT(px) (TF_TARGET_IPHONE_6PLUS ? px*1.5 : px)
#endif

#ifndef TF_WIDTH_SCALE
#define TF_WIDTH(px) (TF_TARGET_IPHONE_6PLUS ? px*1.5 : px)
#endif

/**
 *  宽的缩放比例
 */
#ifndef TF_WIDTH_SCALE
#define TF_WIDTH_SCALE (TF_MAIN_SCREEN.bounds.size.width / 320.0)
#endif

/**
 *  高的缩放比例
 *
 */
#ifndef TF_HEIGHT_SCALE
#define TF_HEIGHT_SCALE (TF_MAIN_SCREEN.bounds.size.height / 568.0)
#endif


// Localizable String
#ifndef TF_LSTR
#   define TF_LSTR(str) NSLocalizedString(str, nil)
#endif

#ifndef TF_STRINGIFY
#   define TF_STRINGIFY(...) @#__VA_ARGS__
#endif
