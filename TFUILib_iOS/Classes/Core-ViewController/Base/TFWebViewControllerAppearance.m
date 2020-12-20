//
//  DKWebAppearance.m
//  LightBundle_iOS
//
//  Created by SunXiaofei on 09/16/2020.
//  Copyright (c) 2020 SunXiaofei. All rights reserved.
//

#import "TFWebViewControllerAppearance.h"
#import "NSBundle+TFUILib_iOS.h"

@implementation TFWebViewControllerAppearance

+ (instancetype)sharedAppearance {
    static TFWebViewControllerAppearance *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TFWebViewControllerAppearance alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.progressColor = [UIColor grayColor];
        self.closeItemImage = [NSBundle tflib_imageWithName:@"webKitClose@2x"];
        self.backItemImage = [NSBundle tflib_imageWithName:@"webKitNaviBack@2x"];
    }
    return self;
}

@end
