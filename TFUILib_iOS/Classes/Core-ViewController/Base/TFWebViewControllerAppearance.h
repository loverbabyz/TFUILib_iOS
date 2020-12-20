//
//  DKWebAppearance.h
//  LightBundle_iOS
//
//  Created by SunXiaofei on 09/16/2020.
//  Copyright (c) 2020 SunXiaofei. All rights reserved.
//

/**
 设置web页面的样式类
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFWebViewControllerAppearance : NSObject

+ (instancetype)sharedAppearance;

// 导航栏返回按钮的图片
@property (nonatomic) UIImage *backItemImage;
// 关闭按钮的图片
@property (nonatomic) UIImage *closeItemImage;
// 网页访问进度条颜色
@property (nonatomic) UIColor *progressColor;
// 网页 MenuItem 的图标
@property (nonatomic) UIImage *menuItemImage;

@end

NS_ASSUME_NONNULL_END
