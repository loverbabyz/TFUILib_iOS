//
//  FSActionSheet.h
//  FSActionSheet
//
//  Created by Steven on 6/7/16.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "TFView.h"
#import "TFActionSheetItem.h"
#import "TFActionSheetConfig.h"

typedef void(^ActionSheetBlock)(NSInteger selectedIndex);

@interface TFActionSheet : TFView

/**
 *  默认是FSContentAlignmentCenter
 */
@property (nonatomic, assign) TFContentAlignment contentAlignment;

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
 *  @param title                  标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param destructiveButtonTitle 特殊标记按钮标题
 *  @param otherButtonTitles           其他按钮项
 *  @param block                  按钮点击事件block
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                        block:(ActionSheetBlock)block;

/**
 *  初始化
 *
 *  @param title                  标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param destructiveButtonTitle 特殊标记按钮标题
 *  @param otherButtons           其他按钮项
 *  @param block                  按钮点击事件block
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                 otherButtons:(NSArray<TFActionSheetItem *> *)otherButtons
                        block:(ActionSheetBlock)block;

/**
 *  显示UIActionSheet
 *
 *  @param title                  视图标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param destructiveButtonTitle 特殊标记按钮标题  红色
 *  @param otherButtonTitles      其他按钮标题
 *  @param block                  按钮点击事件block
 */
+ (void) showWithTitle:(NSString *)title
     cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
     otherButtonTitles:(NSArray *)otherButtonTitles
                 block:(ActionSheetBlock)block;

+ (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                 otherButtons:(NSArray<TFActionSheetItem *> *)otherButtons
                        block:(ActionSheetBlock)block;

- (void)show;

@end
