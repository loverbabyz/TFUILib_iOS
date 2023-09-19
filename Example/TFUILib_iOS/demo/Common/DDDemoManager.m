//
//  DDDemoManager.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDDemoManager.h"
#import <TFBaseLib_iOS/TFAspects.h>
#import "UIViewController+Goto.h"
#import "TFUserDefaults+demo.h"
#import "DDDemoModel.h"
#import <IngeekDK/IngeekDK.h>
#import "DDLocalNotificationManager.h"

@interface DDDemoManager()<IngeekBleDelegate, IngeekDkDelegate>

@property (nonatomic, assign) NSInteger logIndex;

@end
@implementation DDDemoManager

TFSingletonM(Instance)

- (instancetype)init {
    if (self = [super init]) {
        self.logs = [NSMutableDictionary new];
    }
    
    return self;
}

#ifdef kUseDDDemo
+ (void)load {
    [super load];
    
    [[self class] trackAppDelegate];
}
#endif

+ (void)trackAppDelegate {
    [NSClassFromString([[self class] appDelegateClassString])
     tf_aspect_hookSelector:@selector(application:didFinishLaunchingWithOptions:)
     withOptions:TFAspectPositionAfter
     usingBlock:^(id<TFAspectInfo> aspectInfo, id application,id launchOptions){
        return [[DDDemoManager sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    } error:NULL];
}

#pragma mark - public

- (void)initDK:(DDDemoModel *)model completion:(IntegerBlock)completion {
    [IngeekBle sharedInstance].delegate = self;
    [IngeekDk sharedInstance].delegate = self;

    [IngeekDkConfig sharedConfig].url = model.envriment;
    [IngeekDkConfig sharedConfig].appId = model.appId;
    [IngeekDkConfig sharedConfig].dispatchedOnMainQueue = kUserDefaults.dispatchedOnMainQueue;
    [IngeekDkConfig sharedConfig].logLevel = (IngeekDkLogLevel)kUserDefaults.logLevel;
    [[IngeekDk sharedInstance] initDk:^(NSInteger errorCode) {
        NSLog(TF_STRINGIFY(>>>>>>>>> error: %d), (int)errorCode);
        
        if (errorCode) {
            if (completion) {
                completion(errorCode);
            }
            
            return;
        }
        
        IngeekDkLoginParams *params = [[IngeekDkLoginParams alloc] init];
        params.userId = model.userId;
        params.mobile = model.mobile;
        [[IngeekDk sharedInstance] login:params completion:^(NSInteger errorCode) {
            NSLog(TF_STRINGIFY(>>>>>>>>> login success: %d), (int)errorCode);
            
            if (errorCode) {
                if (completion) {
                    completion(errorCode);
                }
                
                return;
            }
            
            if (model.ibeaconEnable) {
                // NOTE: ⚠️需要根据项目进行区分⚠️ iBeacon 拉活连接
                NSString *vin = [[NSUserDefaults standardUserDefaults] stringForKey:kIngeekVinKey];
                if (vin.length) {
                    [[IngeekBle sharedInstance] connect:vin];
                }
            }
            
            if (completion) {
                completion(errorCode);
            }
        }];
    }];
}

- (void)addLog:(NSString *)log {
    if (log.trimAll.length == 0) {
        return;
    }
    
    NSString *key = TF_STR(@"%ld", self.logIndex);
    NSString *value = log;
    
    if (self.logs.count > 3000) {
        [self.logs removeAllObjects];
    }
    
    [self.logs setValue:value forKey:key];
    
    self.logIndex ++;
}

#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (kUserDefaults.model.ibeaconEnable) {
        NSString *title = TF_LSTR(TF_STRINGIFY(notification_app));
        NSString *message = @"Finish Launching";
        
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsBluetoothCentralsKey]) {
            title = TF_LSTR(TF_STRINGIFY(notification_ibeacon));
            title = @"APP is awakened by Bluetooth";
        }else if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
            title = TF_LSTR(TF_STRINGIFY(notification_ble));
            message = @"APP is awakened by iBeacon";
        }
        
        [[DDLocalNotificationManager sharedInstance] registerAPN];
        [[DDLocalNotificationManager sharedInstance] addLocalNotification:title message:message deep:NO];
    }
    
    // 不显示因Auto Layout约束问题的日志输出内容
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:TF_STRINGIFY(_UIConstraintBasedLayoutLogUnsatisfiable)];
    
    if (kUserDefaults.model) {
        [self initDK:kUserDefaults.model completion:^(NSInteger resultNumber) {
            NSLog(TF_STRINGIFY(>>>>>>>>> error: %d), (int)resultNumber);
            if (resultNumber) {
                [UIViewController gotoLoginViewController];
                
                return;
            }
            
            [UIViewController gotoRootViewController];
        }];
    } else {
        [UIViewController gotoLoginViewController];
    }
    
    return YES;
}

+ (NSString *)appDelegateClassString {
    if (NSClassFromString(@"AppDelegate")) {
        /// obj-c
        return @"AppDelegate";
    } else {
        /// swift
        return [NSString stringWithFormat:@"%@.%@", NSBundle.mainBundle.infoDictionary[@"CFBundleExecutable"], @"AppDelegate"];;
    }
}

#pragma mark - Dk delegate

- (void)didReceiveLog:(NSString *)log level:(IngeekDkLogLevel)level {
    if ([log containsString:TF_STRINGIFY(Get paired peripheral retrieved with identifier.)]) {
        [[DDLocalNotificationManager sharedInstance] addLocalNotification:TF_LSTR(@"notification_ibeacon") message:TF_LSTR(@"start_connect_vehicle") deep:NO];
    }
    
    if ([log containsString:TF_STRINGIFY(Start to connect without peripheral, and try to scan then.)]) {
        [[DDLocalNotificationManager sharedInstance] addLocalNotification:TF_LSTR(@"notification_ibeacon") message:TF_LSTR(@"start_scan_vehicle") deep:NO];
    }
}

#pragma mark - Ble delegate

- (void)didConnect:(NSString *)pid errorCode:(NSInteger)errorCode {
    NSLog(TF_STRINGIFY(>>>>>>>>> did connect: %@, %d), pid, (int)errorCode);
    if (!errorCode) {
        [[DDLocalNotificationManager sharedInstance] addLocalNotification:TF_LSTR(@"notification_ibeacon") message:TF_LSTR(@"Connect to vehicle success.") deep:YES];
    }
}

@end
