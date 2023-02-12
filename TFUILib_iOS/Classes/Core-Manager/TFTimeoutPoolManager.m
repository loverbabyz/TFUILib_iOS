//
//  TFTimeoutPoolManager.m
//  TFUILib
//
//  Created by sunxiaofei on 28/07/2017.
//  Copyright © 2017 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFTimeoutPoolManager.h"
#import "TFTimeOutModel.h"
#import <TFBaseLib_iOS/TFBaseMacro+Singleton.h>

@interface TFTimeoutPoolManager()

@property (nonatomic, strong) NSMutableDictionary *poolDict;

@end

@implementation TFTimeoutPoolManager

- (void)dealloc {
    [_poolDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, TFTimeOutModel *obj, BOOL * _Nonnull stop) {
        [obj clean];
    }];
    
    [_poolDict removeAllObjects];
}

TFSingletonM(Manager)

- (void)addTimeoutObserver:(float)timeout
                forKeyPath:(NSString *)forKeyPath
                completion:(void(^)(NSError *error, BOOL timeOut))completion {
    __block typeof(self) weakSelf = self;
    
    // 等待时间后判断分辨是否切换成功
    TFTimeOutModel *timeoutModel = [TFTimeOutModel new];
    [timeoutModel startTimeout:timeout
                    forKeyPath:forKeyPath
                       content:_poolDict.allKeys
                    completion:^(NSString *key, NSError *error, BOOL timeOut) {
                        // 移除超时对象中的回调
                        [weakSelf removeTimeoutObserver:forKeyPath];
                        
                        if (completion) {
                            completion(error, timeout);
                        }
                    }];
    
    [self.poolDict setObject:timeoutModel forKey:forKeyPath];
}

- (void)removeTimeoutObserver:(NSString *)keyPath {
    TFTimeOutModel *timeoutModel = [_poolDict objectForKey:keyPath];
    [timeoutModel clean];
    
    [_poolDict removeObjectForKey:keyPath];
}

@end
