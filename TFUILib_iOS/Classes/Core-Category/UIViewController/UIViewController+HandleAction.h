//
//  UIViewController+HandleAction.h
//  TFUILib
//
//  Created by xiayiyong on 16/3/21.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTableRowModel.h"

@interface UIViewController (HandleAction)

/**
 *  统一数据处理
 *
 *  @param data 数据
 */
-(void) handleData:(TFTableRowModel*)data;

/**
 *  统一数据处理
 *
 *  @param data 数据
 *  @param completion 处理不了的通过回调函数提交给APP去处理
 */
-(void) handleData:(TFTableRowModel*)data completion:(void (^)(TFTableRowModel*))completion;

@end
