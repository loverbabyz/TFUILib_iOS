//
//  TFMacro+Color.h
//  Treasure
//
//  Created by xiayiyong on 15/9/14.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

/**
 *  读取本地图片
 *
 *  @param file 地址
 *  @param ext  类型
 *
 *  @return 获取到的图片
 */
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

/**
 *  定义UIImage对象
 *
 *  @param name image的名字
 *
 *  @return UIImage对象
 */
#define IMAGE(name) [UIImage imageNamed:name]

/**
 *  创建alter
 *
 *  @param title title
 *  @param msg   内容
 *
 *  @return alter
 */
#define ALERT(title, msg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
cancelButtonTitle:NSLocalizedString(@"ok", @"ok") \
otherButtonTitles:nil]; \
[alert show];

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
#define RESIZABLE_IMAGE(name,top,left,bottom,right) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]

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
#define RESIZABLE_IMAGE_MODEL(name,top,left,bottom,right,mode) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]

/**
 * 通过不同机型的设计稿像素值获取高度
 *
 *  @param p_x1  x1像素
 *  @param p_x2  x2像素
 *  @param p_x3  x3像素
 *
 */
#define STYLE_BY_PIXEL(p_x1, p_x2, p_x3)\
(TARGET_IPHONE_6PLUS ? p_x3 / 3.0 : (TARGET_IPHONE_6 ? p_x2 / 2.0 : p_x1 / 2.0))

/**
* 通过设计稿像素值获取高度
*
*  @param pixel  设计稿像素
*
*/
#define STYLE_BY_PIX(pixel)\
pixel * [UIScreen mainScreen].scale


/**
 *  通过设计稿中给的像素获取实际设备像素
 *
 *  @param designedPixel 设计稿中给的像素值
 */
#define REAL_PIXEL(designedPixel)\
(TARGET_IPHONE_6PLUS ? (designedPixel / 3.0) : (designedPixel / 2.0))

#define HEIGHT(px) (TARGET_IPHONE_6PLUS ? px*1.5 : px)
#define WIDTH(px) (TARGET_IPHONE_6PLUS ? px*1.5 : px)
