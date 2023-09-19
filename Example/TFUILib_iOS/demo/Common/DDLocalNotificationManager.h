//
//  DDLocalNotificationManager.h
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/8/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDLocalNotificationManager : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Notification

- (void)registerAPN;

- (void)addLocalNotification:(NSString *)title message:(NSString *)message deep:(BOOL)deep;

@end

NS_ASSUME_NONNULL_END
