//
//  UIActionSheet+Block.h
//  UIActionSheet+Block
//
//  Created by Daniel on 16/1/28.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Block)

#pragma mark- show method

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
                 block:(void (^)(NSInteger buttonIndex))block;

/**
 *  显示UIActionSheet
 *
 *  @param title                  视图标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param otherButtonTitles      其他按钮标题
 *  @param block                  按钮点击事件block
 */
+ (void) showWithTitle:(NSString *)title
     cancelButtonTitle:(NSString *)cancelButtonTitle
     otherButtonTitles:(NSArray *)otherButtonTitles
                 block:(void (^)(NSInteger buttonIndex))block;

/**
 *  显示UIActionSheet
 *
 *  @param title                  视图标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param destructiveButtonTitle 特殊标记按钮标题  红色
 *  @param block                  按钮点击事件block
 */
+ (void) showWithTitle:(NSString *)title
     cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
                 block:(void (^)(NSInteger buttonIndex))block;

+ (void) showWithTitle:(NSString *)title
          buttonTitles:(NSArray *)buttonTitles
                 block:(void (^)(NSInteger buttonIndex))block;

#pragma mark- init method

/**
 *  初始化
 *
 *  @param title                  标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param destructiveButtonTitle 特殊标记按钮标题  红色
 *  @param otherButtonTitles      其他按钮标题
 *  @param block                  按钮点击事件block
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                        block:(void (^)(NSInteger))block;

/**
 *  初始化
 *
 *  @param title                  标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param destructiveButtonTitle 特殊标记按钮标题  红色
 *  @param block                  按钮点击事件block
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
                        block:(void (^)(NSInteger))block;

/**
 *  初始化
 *
 *  @param title                  标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param otherButtonTitles      其他按钮标题
 *  @param block                  按钮点击事件block
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                        block:(void (^)(NSInteger))block;


/**
 *  初始化
 *
 *  @param title        标题
 *  @param buttonTitles 按钮标题
 *  @param block        按钮点击事件block
 */
- (instancetype)initWithTitle:(NSString *)title
            buttonTitles:(NSArray *)buttonTitles
                        block:(void (^)(NSInteger))block;

#pragma mark- show

- (void)show;


@end
