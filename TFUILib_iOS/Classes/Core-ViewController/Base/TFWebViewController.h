//
//  TFWebViewController.h
//  Treasure
//
//  Created by xiayiyong on 15/9/9.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFViewController.h"
#import "WKWebViewJavascriptBridge.h"
#import "TFWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TFWebViewController : TFViewController

// 需要传入web的请求header
@property (nonatomic, strong) NSDictionary *addionalHeader;

/// 页面加载完回调
@property (nonatomic, copy) void (^didFinishNavigationBlock)(void);

// 网页加载请求
- (void)loadRequest:(NSURLRequest *)request;

// 网页加载网页URL
- (void)loadURL:(NSURL *)url;

// 加载 Html 字符串
- (void)loadHTMLString:(NSString *)htmlString baseURL:(nullable NSURL *)baseURL;

// 注册jsBridge plugin
- (void)addPlug:(id<TFWebBridgePluginDelegate>)plugin;

/// 隐藏返回按钮
- (void)hideBackButton;

@end

NS_ASSUME_NONNULL_END
