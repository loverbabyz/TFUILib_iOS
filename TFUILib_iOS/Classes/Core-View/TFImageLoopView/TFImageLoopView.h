//
//  TFImageLoopView.h
//  图片轮播控件
//
//  Created by Daniel on 2020/7/8.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFView.h"
#import "TFLoopView.h"

@interface TFImageLoopView : TFLoopView

/**
 *  每张图片对应要显示的image数组
 */
@property (nonatomic, strong) NSArray *imagesGroup;

/**
 *  初始轮播图（推荐使用）
 *
 *  @param frame            轮播视图大小
 *  @param block            回调
 *  @param imagesGroup      轮播图片
 *
 *  @return 轮播视图
 */
+ (instancetype)loopViewWithFrame:(CGRect)frame
                 imagesGroup:(NSArray *)imagesGroup
                            block:(void(^)(NSInteger currentIndex))block;
/**
 *  初始轮播图（推荐使用）
 *
 *  @param frame            轮播视图大小
 *  @param block            回调
 *  @param placeholderImage 占位图片
 *
 *  @return 轮播视图
 */
+ (instancetype)loopViewWithFrame:(CGRect)frame
                      placeholderImage:(UIImage *)placeholderImage
                            block:(void(^)(NSInteger currentIndex))block;

@end
