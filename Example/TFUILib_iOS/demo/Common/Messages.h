//
//  Messages.h
//  IngeekDK-V4
//
//  Created by Chris on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define EMSG(code) [Messages message:code]

@interface Messages : NSObject

/**
 * @method message
 */
+ (NSString *)message:(NSInteger)code;

@end

NS_ASSUME_NONNULL_END
