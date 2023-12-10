//
//  FSActionSheetConfig.m
//  FSActionSheet
//
//  Created by Steven on 6/8/16.
//  Copyright © 2016 Steven. All rights reserved.
//

#import "TFActionSheetConfig.h"

// float
CGFloat const TFActionSheetCornerRadius            = 12;///< 圆角大小
CGFloat const TFActionSheetDefaultMargin           = 10;///< 默认边距 (标题四边边距, 选项靠左或靠右时距离边缘的距离)
CGFloat const TFActionSheetContentMaxScale         = 0.65;///< 弹窗内容高度与屏幕高度的默认比例
CGFloat const TFActionSheetRowHeight               = 49;///< 行高
CGFloat const TFActionSheetTitleLineSpacing        = 2.5;///< 标题行距
CGFloat const TFActionSheetTitleKernSpacing        = 0.5;///< 标题字距
CGFloat const TFActionSheetItemTitleFontSize       = 16;///< 选项文字字体大小, default is 16.
CGFloat const TFActionSheetItemContentSpacing      = 5;///< 选项图片和文字的间距
// color
NSString * const TFActionSheetTitleColor           = @"#888888";///< 标题颜色
NSString * const TFActionSheetBackColor            = @"#E8E8ED";///< 背景颜色
NSString * const TFActionSheetRowNormalColor       = @"#FBFBFE";///< 单元格背景颜色
NSString * const TFActionSheetRowHighlightedColor  = @"#F1F1F5";///< 选中高亮颜色
NSString * const TFActionSheetRowTopLineColor      = @"#D7D7D8";///< 单元格顶部线条颜色
NSString * const TFActionSheetItemNormalColor      = @"#000000";///< 选项默认颜色
NSString * const TFActionSheetItemHighlightedColor = @"#E64340";///< 选项高亮颜色
