//
//  TFTableViewHeaderFooterView.h
//  TFUILib
//
//  Created by Daniel.Sun on 2017/12/19.
//  Copyright © 2017年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTableSectionModel.h"
#import "TFUILibMacro.h"

@interface TFTableViewHeaderFooterView : UITableViewHeaderFooterView

/// 点击后回调
@property (nonatomic, copy) void (^touchAction)(void);

/**
 *  cell数据
 */
@property (nonatomic, strong) id data;

/**
 *  从XIB获取view
 */
+ (id)loadViewFromXib;

/**
 *  初始化视图
 */
- (void)initViews;

/**
 *  自动布局视图
 */
- (void)autolayoutViews;

/**
 *  绑定数据
 */
- (void)bindData;

/**
 *  返回view高度
 *
 *  @return view高度
 */
- (CGFloat)viewHeight;

/**
 *  获取view高度
 *
 *  @return view高度
 */
+ (CGFloat)viewHeight;

/**
 *  获取reusableIdentifier
 *
 *  @return reusableIdentifier
 */
+(NSString*)reusableIdentifier;

@end
