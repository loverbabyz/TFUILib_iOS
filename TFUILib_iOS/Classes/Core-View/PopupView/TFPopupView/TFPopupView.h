//
//  TFPopupView.h
//  TFUILib
//
//  Created by Daniel on 2020/7/13.
//  Copyright © 2020 com.treasure.TFUILib. All rights reserved.
//

#import "TFView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger
{
    /**
     *  无动画
     */
    kPopupViewAnimateNone = 0,
    /**
     *  弹性动画
     */
    kPopupViewAnimateSpring = 1,
    /**
     *  渐隐渐现动画
     */
    kPopupViewAnimateFade = 2,
} TFPopupViewAnimateType;

@interface TFPopupView : TFView

/**
 *  是否开启点击半透明层隐藏弹窗, 默认为YES
 */
@property (nonatomic, assign) BOOL hideOnTouchOutside;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  Default is [UIFont systemFontOfSize:18]
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 * 是否隐藏右上角关闭按钮， 默认为YES
 */
@property (nonatomic, assign) BOOL hideCloseBtn;

/**
 *  Default is Black
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  Default is 0.3 seconds
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  Opacity of background, default is 0.3f
 */
@property (nonatomic, assign) CGFloat backgroundOpacity;

#pragma mark- init method

/**
 *  初始化
 *
 *  @param title 标题
 *  @param cancelButtonTitle  取消按钮标题
 *  @param content 要显示的内容
 *  @param block 取消按钮点击事件block
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
                      content:(UIView *)content
                        block:(void(^)(void))block;

/// 显示
- (void)show;

/// 隐藏
- (void)hideWithCompletion:(void(^)(void))completion;

/**
 *  显示Popup View
 *
 *  @param title 标题
 *  @param cancelButtonTitle  取消按钮标题
 *  @param content 要显示的内容
 *  @param block 取消按钮点击事件block
 */
+ (void)showWithTitle:(NSString *)title
    cancelButtonTitle:(NSString *)cancelButtonTitle
              contentView:(UIView *)content
                block:(void(^)(void))block;



@end

NS_ASSUME_NONNULL_END
