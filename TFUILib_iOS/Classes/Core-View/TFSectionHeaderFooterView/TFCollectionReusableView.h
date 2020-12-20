//
//  TFCollectionReusableView.h
//  TFUILib
//
//  Created by Daniel on 2020/7/15.
//  Copyright © 2020 com.treasure.TFUILib. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFCollectionReusableView : UICollectionReusableView

/// 点击后回调
@property (nonatomic, copy) void(^touchAction)(void);

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

NS_ASSUME_NONNULL_END
