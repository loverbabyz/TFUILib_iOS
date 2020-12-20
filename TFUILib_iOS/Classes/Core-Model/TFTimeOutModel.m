//
//  TFTimeOutModel.m
//  TFUILib
//
//  Created by sunxiaofei on 27/07/2017.
//  Copyright © 2017 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFTimeOutModel.h"

@implementation TFTimeOutModel

- (void)startTimeout:(float)timeout
          forKeyPath:(NSString *)forKeyPath
             content:(NSArray *)content
          completion:(timeoutCompletionBlock)completion {
    self.completionBlock = completion;
    __weak typeof(self) weakSelf = self;
    __block BOOL timeOut = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSString *item in content) {
            if ([item isEqualToString:forKeyPath]) {
                timeOut = YES;
                break;
            }
        }
        if (weakSelf.completionBlock) {
            weakSelf.completionBlock(forKeyPath, (timeOut) ? [NSError errorWithDomain:@"com.TFUILib" code:-1 userInfo:@{NSLocalizedDescriptionKey: @"读取超时"}] : nil, timeOut);
        }
    });
    
}

- (void)clean {
    self.completionBlock = nil;
}

@end
