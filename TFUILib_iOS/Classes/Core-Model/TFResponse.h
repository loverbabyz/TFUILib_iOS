//
//  BaseResponse.h
//  SSXQ
//
//  Created by sunxiaofei on 16/3/10.
//  Copyright © 2016年 sunxiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFModel.h"

@interface TFResponse : TFModel

/**
 *  0为成功 其他为失败错误码
 */
@property (nonatomic, assign) NSInteger errorCode;

/**
 * errorCode==0 时的错误描述
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 * errorCode=0 时的返回结果
 */
@property (nonatomic, strong) id result;

/**
 *  根据错误码来初始化，errorMessage为空字符串
 *
 *  @param errorCode 错误码
 */
- (instancetype)initWithErrorCode:(NSInteger)errorCode;

/**
 *  根据错误码和错误描述来初始化
 *
 *  @param errorCode    错误码
 *  @param errorMessage 错误描述
 */
- (instancetype)initWithErrorCode:(NSInteger)errorCode errorMessage:(NSString*)errorMessage;

@end
