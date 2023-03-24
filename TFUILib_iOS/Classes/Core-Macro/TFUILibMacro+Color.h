//
//  TFMacro+Color.h
//  Treasure
//
//  Created by Daniel on 15/9/14.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

// Color Convenient api
#ifndef TF_RGB
#   define TF_RGB(r, g, b) (TF_RGBA(r, g, b, 1.0))
#endif

#ifndef TF_RGBA
#define TF_RGBA(r, g, b, a) \
    [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
#endif

#ifndef TF_HRGB
#   define TF_HRGB(hex) (TF_HRGBA(hex, 1.0))
#endif

#ifndef TF_HRGBA
#define TF_HRGBA(hex, alpha) \
    (TF_RGBA(((hex >> 16) & 0xff), ((hex >> 8) & 0xff), (hex & 0xff), alpha))
#endif

#ifndef TF_HRGBA2
#define TF_HRGBA2(hex) \
    (TF_RGBA(((hex >> 24) & 0xff), ((hex >> 16) & 0xff), ((hex >> 8) & 0xff), ((hex & 0xff) / 255.0)))
#endif

#ifndef TF_HARGB
#define TF_HARGB(alpha, hex) \
    (TF_RGBA(((hex >> 16) & 0xff), ((hex >> 8) & 0xff), (hex & 0xff), alpha))
#endif

#ifndef TF_HARGB2
#define TF_HARGB2(hex) \
    (TF_RGBA(((hex >> 16) & 0xff), ((hex >> 8) & 0xff), (hex & 0xff), (((hex >> 24) & 0xff) / 255.0)))
#endif

#ifndef TF_RandomColor
#   define TF_RandomColor (TF_RandomColorA(1.0))
#endif

#ifndef TF_RandomColorA
#define TF_RandomColorA(alpha) \
    (TF_RGBA(arc4random() % 255, arc4random() % 255, arc4random() % 255, alpha))
#endif

#define TF_CLEARCOLOR      [UIColor clearColor]
