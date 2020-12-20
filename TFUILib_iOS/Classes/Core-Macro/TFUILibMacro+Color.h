//
//  TFMacro+Color.h
//  Treasure
//
//  Created by xiayiyong on 15/9/14.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

// rgbs设置颜色
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

/**
 *  十六进制设置颜色
 *
 *  @param c 十六进制
 *  @param a 透明度
 */
#define HEXCOLOR(c,a)   [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]
#define CLEARCOLOR      [UIColor clearColor]
