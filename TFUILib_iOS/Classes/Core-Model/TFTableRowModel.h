//
//  TFTableRowModel.h
//  TFUILib
//
//  Created by xiayiyong on 16/3/11.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFModel.h"

#pragma mark -
#pragma mark - TFTableRowModel
//@protocol TFTableRowModel <NSObject>
//@end

@interface TFTableRowModel : TFModel

/**
 *  action
 */
@property (nonatomic, copy) NSString *action;

/**
 *  附加参数
 */
@property (nonatomic, strong) id parameter;

/**
 *  vc
 */
@property (nonatomic, copy) NSString *vc;

/**
 *  method
 */
@property (nonatomic, copy) NSString *method;

/**
 *  url
 */
@property (nonatomic, copy) NSString *url;

/**
 *  place holder
 */
@property (nonatomic, copy) NSString *placeholder;

/**
 *  content
 */
@property (nonatomic, copy) NSString *content;

/**
 *  thumbnail
 */
@property (nonatomic, copy) NSString *thumbnail;

/**
 *  是否需要网络才能访问
 */
@property (nonatomic, assign) BOOL isNeedNetwork;

/**
 *  webModel
 */
@property (nonatomic, strong) id webModel;

@end
