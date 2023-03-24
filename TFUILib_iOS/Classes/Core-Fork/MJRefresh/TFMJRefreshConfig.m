//
//  TFMJRefreshConfig.m
//
//  Created by Frank on 2018/11/27.
//  Copyright © 2018 小码哥. All rights reserved.
//

#import "TFMJRefreshConfig.h"
#import "TFMJRefreshConst.h"
#import "NSBundle+TFMJRefresh.h"

@interface TFMJRefreshConfig (Bundle)

+ (void)resetLanguageResourceCache;

@end

@implementation TFMJRefreshConfig

static TFMJRefreshConfig *mj_RefreshConfig = nil;

+ (instancetype)defaultConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mj_RefreshConfig = [[self alloc] init];
    });
    return mj_RefreshConfig;
}

- (void)setLanguageCode:(NSString *)languageCode {
    if ([languageCode isEqualToString:_languageCode]) {
        return;
    }
    
    _languageCode = languageCode;
    // 重置语言资源
    [TFMJRefreshConfig resetLanguageResourceCache];
    [NSNotificationCenter.defaultCenter
     postNotificationName:TFMJRefreshDidChangeLanguageNotification object:self];
}

@end
