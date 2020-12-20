//
//  TFTimeoutPoolManager.h
//  TFUILib
//
//  Created by sunxiaofei on 28/07/2017.
//  Copyright © 2017 daniel.xiaofei@gmail.com All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTFTimeoutPoolManager ([TFTimeoutPoolManager sharedManager])

@interface TFTimeoutPoolManager : NSObject

+ (instancetype)sharedManager;

- (void)addTimeoutObserver:(float)timeout
                forKeyPath:(NSString *)forKeyPath
                completion:(void(^)(NSError *error, BOOL timeOut))completion;

- (void)removeTimeoutObserver:(NSString *)keyPath;

@end
