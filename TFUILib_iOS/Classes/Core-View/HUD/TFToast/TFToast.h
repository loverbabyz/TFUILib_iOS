//
//  TFToast.h
//  TFUILib
//
//  Created by Daniel on 16/4/15.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFView.h"

/**
 *  文字和loading相对位置
 */
typedef NS_ENUM(NSUInteger, TFToastType) {
    /**
     *  文字居上
     */
    kToastTypeTop,
    /**
     *  文字居下
     */
    kToastTypeBottom,
    /**
     *  文字居中
     */
    kToastTypeCenter
};



typedef void (^TFToastBlock)(void);

@interface TFToast : TFView

@property (nonatomic, strong) NSString *text;

/**
 *  显示toast
 *
 *  @param text text
 */
+ (void)showWithText:(NSString *)text duration:(NSTimeInterval)duration atView:(UIView*)atView type:(TFToastType)type offsetY:(CGFloat)offsetY;

- (id)initWithText:(NSString*)text;

@end
