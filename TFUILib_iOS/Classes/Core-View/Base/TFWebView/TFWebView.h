//
//  TFWebView.h
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <WebKit/WebKit.h>

#import "WKWebViewJavascriptBridge.h"

NS_ASSUME_NONNULL_BEGIN

/// JSBridge插件协议定义
@protocol TFWebBridgePluginDelegate <NSObject>

/// 注册WebViewJavascriptBridge
/// @param bridge WebViewJavascriptBridge
- (BOOL)registerBridge:(WKWebViewJavascriptBridge *)bridge;

@optional

- (NSString *)handlerName;

- (BOOL)responseToHandler:(NSString *)handlerName;

- (void)performHandler:(NSString *)handlerName parameter:(NSObject *)parameter;

@end

@interface TFWebView : WKWebView

@property (nonatomic, strong, readonly) WKWebViewJavascriptBridge *jsBridge;

//传递给web页面的请求header
@property (nonatomic, strong) NSDictionary *additionHeader;

/// 设置webViewDelegate，用于拦截web请求
/// @param webViewDelegate webViewDelegate
- (void)setWebViewDelegate:(id<WKNavigationDelegate>)webViewDelegate;

// 注册jsBridge plugin
- (void)addPlug:(id<TFWebBridgePluginDelegate>)plugin;

@end

@interface WebBridgeResponseModel : NSObject

@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id result;

@end

@interface TFWebBridgePlugin : NSObject<TFWebBridgePluginDelegate>

@property (nonatomic) WKWebViewJavascriptBridge *bridge;

// 封包回调给web的数据结构包
+ (void)wrapResponseCallBack:(WVJBResponseCallback)responseCallBack
                     message:(NSString*)message result:(BOOL)result responseObject:(id)responseObject;

@end

NS_ASSUME_NONNULL_END
