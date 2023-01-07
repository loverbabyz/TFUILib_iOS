//
//  TFCustomSegmentedControl.h
//  Treasure
//
//  Created by Daniel on 16/1/15.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFView.h"

/**
 *  TFSegmentedView点击回调Block
 *
 *  @param title 标题
 *  @param index index
 */
typedef void (^TFSegmentedControlTouchBlock)(NSString*title, NSInteger index);

/**
 *  TFSegmentedView
 */
@interface TFSegmentedControl : TFView

/**
 *  标题数组
 */
@property (nonatomic, strong) NSMutableArray *titleArr;

/**
 *  标题高度
 */
@property (nonatomic, assign) CGFloat titleHeight;

/**
 *  标题颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 *  标题选择颜色
 */
@property (nonatomic, strong) UIColor *titleSelectedColor;

/**
 *  标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 *  标题选择状态字体
 */
@property (nonatomic, strong) UIFont *titleSelectedFont;

/**
 *  中间线条高度
 */
@property (nonatomic, assign) CGFloat lineHeight;

/**
 *  中间线条颜色
 */
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat horizontalWidth;

/**
 *  选择项
 */
@property (nonatomic, assign) NSInteger selectedIndex;

/**
 *  TFSegmentedControl点击回调Block
 */
@property (nonatomic, strong) TFSegmentedControlTouchBlock block;

/**
 *  初始化TFSegmentedView
 *
 *  @param frame    尺寸
 *  @param titleArr 每个page对应title
 *  @param block    按钮点击事件的回调
 *
 *  @return TFSegmentedControl
 */
- (id)initWithFrame:(CGRect)frame
             titles:(NSArray *)titleArr
              block:(TFSegmentedControlTouchBlock)block;

/**
 *  初始化TFSegmentedView
 *
 *  @param frame          尺寸
 *  @param imageNormelArr 正常情况下的图片
 *  @param imageSelectArr 选中情况下的图片
 *  @param block          按钮点击事件的回调
 *
 *  @return TFSegmentedControl
 */
- (id)initWithFrame:(CGRect)frame
     imageNormelArr:(NSArray *)imageNormelArr
     imageSelectArr:(NSArray *)imageSelectArr
              block:(TFSegmentedControlTouchBlock)block;

/**
 *  初始化TFSegmentedView
 *
 *  @param titleArr 每个page对应title
 *  @param block    按钮点击事件的回调
 *
 *  @return TFSegmentedControl
 */
- (id)initWithTitles:(NSArray *)titleArr block:(TFSegmentedControlTouchBlock)block;

/**
 *  点选标题
 *
 *  @param index 标题index
 */
- (void)select:(NSInteger)index;

@end
