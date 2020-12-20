//
//  TFImageLoopViewCell.h
//  TFImageLoopView
//
//  Created by Daniel on 2020/7/8.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFView.h"
#import "TFCollectionViewCell.h"

@interface TFLoopViewCell : TFCollectionViewCell

/**
 *  内容容器
 */
@property (strong, nonatomic) TFView *containerView;

/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;

/**
 *  标题颜色
 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;

/**
 *  标题字体
 */
@property (nonatomic, strong) UIFont *titleLabelTextFont;

/**
 *  标题背景颜色
 */
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;

/**
 *  标题高度
 */
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) BOOL hasConfigured;

@end
