//
//  TFTimeOutModel.h
//  TFUILib
//
//  Created by sunxiaofei on 27/07/2017.
//  Copyright © 2017 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFModel.h"

typedef void (^timeoutCompletionBlock)(NSString *key, NSError *error, BOOL timeOut);
@interface TFTimeOutModel : TFModel

@property (nonatomic, copy) timeoutCompletionBlock completionBlock;

/**
 *  启动超时检测
 *
 *  @param timeout    超时时间
 *  @param forKeyPath 要检测的对象
 *  @param content    检测池
 *  @param completion 超时回调
 */
- (void)startTimeout:(float)timeout
          forKeyPath:(NSString *)forKeyPath
             content:(NSArray *)content
          completion:(timeoutCompletionBlock)completion;

/**
 *  清除注册的超时回调
 */
- (void)clean;

@end
