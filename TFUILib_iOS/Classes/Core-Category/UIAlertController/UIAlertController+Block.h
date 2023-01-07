//
//  UIAlertController+Block.h
//  TFUILib
//
//  Created by Daniel on 16/1/28.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  带回调block的UIAlertController
 */
@interface UIAlertController (Block)

/**
 *   显示UIAlertView
 *
 *  @param title             视图标题
 *  @param message           内容
 *  @param cancelButtonTitle 取消按钮标题
 *  @param otherButtonTitles 其他按钮标题
 *  @param block             按钮点击事件block
 */
+ (void)showAlertViewWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                block:(void (^)(NSInteger buttonIndex))block;

/**
 *   显示UIAlertView
 *
 *  @param title             视图标题
 *  @param message           内容
 *  @param buttonTitles 其他按钮标题
 *  @param block             按钮点击事件block
 */
+ (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             buttonTitles:(NSArray *)buttonTitles
                         block:(void (^)(NSInteger buttonIndex))block;

/**
 *  显示UIActionSheet
 *
 *  @param title                  视图标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param destructiveButtonTitle 特殊标记按钮标题 红色
 *  @param otherButtonTitles      其他按钮标题
 *  @param block                  按钮点击事件block
 */
+ (void) showActionSheetWithTitle:(NSString *)title
     cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
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
+ (void) showActionSheetWithTitle:(NSString *)title
                cancelButtonTitle:(NSString *)cancelButtonTitle
           destructiveButtonTitle:(NSString *)destructiveButtonTitle
                            block:(void (^)(NSInteger buttonIndex))block;

/**
 *  显示UIActionSheet
 *
 *  @param title                  视图标题
 *  @param cancelButtonTitle      取消按钮标题
 *  @param otherButtonTitles      其他按钮标题
 *  @param block                  按钮点击事件block
 */
+ (void) showActionSheetWithTitle:(NSString *)title
                cancelButtonTitle:(NSString *)cancelButtonTitle
                otherButtonTitles:(NSArray *)otherButtonTitles
                            block:(void (^)(NSInteger buttonIndex))block;



@end
