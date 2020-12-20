//
//  BaseResult.h
//  SSXQ
//
//  Created by sunxiaofei on 16/3/16.
//  Copyright © 2016年 sunxiaofei. All rights reserved.
//

#import "TFModel.h"

@interface TFResult : TFModel

/**
 *  状态 [0:成功,-1:失败]
 */
@property (nonatomic, assign) NSInteger status;

/**
 *  错误信息
 */
@property (nonatomic, copy) NSString *errorMessage;

@end
