//
//  TFMacro+Font.h
//  Treasure
//
//  Created by Daniel on 15/9/14.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

// Font Convenient api
#ifndef TF_Font
#   define TF_Font(fontSize, fontName) [UIFont fontWithName:fontName size:fontSize]
#endif

#ifndef TF_AppFont
#   define TF_AppFont(fontSize) [UIFont systemFontOfSize:fontSize]
#endif

#ifndef TF_AppMediumFont
#   define TF_AppMediumFont(fontSize) [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium]
#endif

#ifndef TF_AppBoldFont
#   define TF_AppBoldFont(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#endif
