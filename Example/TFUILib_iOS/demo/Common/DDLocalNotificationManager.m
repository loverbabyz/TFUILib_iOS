//
//  DDLocalNotificationManager.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/8/25.
//

#import "DDLocalNotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>

@interface DDLocalNotificationManager()<UNUserNotificationCenterDelegate>

@end
@implementation DDLocalNotificationManager

+ (instancetype)sharedInstance {
    static DDLocalNotificationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Notification

- (void)registerAPN {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {

    }];
}

- (void)addLocalNotification:(NSString *)title message:(NSString *)message deep:(BOOL)deep {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.body = message;
    content.sound = [UNNotificationSound defaultSound];
    NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:1] timeIntervalSinceNow];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:time
                                                  repeats:NO];

    NSString *identifier = @"noticeId";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content
                                                                          trigger:trigger];

    [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
        NSTimeInterval interval = 1.0;
        NSInteger numberOfVibrations = 1;
        if(deep) {
            numberOfVibrations = 2;
        }
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            for (NSInteger i = 0; i < numberOfVibrations; i++) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                });
            }
        });
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    // 在这里自定义通知的呈现方式
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
}

@end
