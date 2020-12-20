//
//  TFWebView.m
//  TFUILib
//
//  Created by xiayiyong on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFWebView.h"
#import <MJExtension/MJExtension.h>

@interface TFWebView()

/// 拓展的plugin（每次增加新交互不用频繁修改基础组件）
@property (nonatomic, strong) NSMutableArray<id<TFWebBridgePluginDelegate>> *pluginArray;

@end
@implementation TFWebView

- (instancetype)initWithFrame:(CGRect)frame {
    // 允许跨域访问
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:[TFWebView noneSelectScript]];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
     config.userContentController = userContentController;
     config.preferences.javaScriptEnabled = YES;
     config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
     config.suppressesIncrementalRendering = YES; // 是否支持记忆读取
    [config.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
     if (@available(iOS 10.0, *)) {
          [config setValue:@YES forKey:@"_allowUniversalAccessFromFileURLs"];
     }
    
    if (self = [super initWithFrame:frame configuration:config]) {
        _pluginArray = [NSMutableArray array];
        _jsBridge = [WKWebViewJavascriptBridge bridgeForWebView:self];
    }
    
    return self;
}

- (void)addPlug:(id<TFWebBridgePluginDelegate>)plugin {
    [self.pluginArray addObject:plugin];
    
    [self registerJsBridge];
}

- (void)setWebViewDelegate:(id<WKNavigationDelegate>)webViewDelegate {
    [_jsBridge setWebViewDelegate:webViewDelegate];
}

- (void)registerJsBridge {
    [self registerJavaScriptHandler:_jsBridge];
}

- (void)registerJavaScriptHandler:(WKWebViewJavascriptBridge *)bridge {
    // 拓展的plugin（每次增加新交互不用频繁修改基础组件）
    for (id<TFWebBridgePluginDelegate>plugin in self.pluginArray) {
        [plugin registerBridge:bridge];
    }
    
    // 基础plugin可以放在这里
    /*
    __weak typeof(self) weakSelf = self;
    [bridge registerHandler:@"setNavigationInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSDictionary *dict = (NSDictionary *)data;
        NSString *title = dict[@"toolbarTitle"];
        if (title.length == 0) {
            [DKBridgeCallBack wrapResponseCallBack:responseCallback message:@"title为空" result:NO responseObject:nil];
        }
        
        strongSelf.containerViewController.title = title;
        [DKBridgeCallBack wrapResponseCallBack:responseCallback message:nil result:YES responseObject:nil];
    }];
     */
}

- (WKNavigation *)loadRequest:(NSURLRequest *)request {
    return [self loadRequest:request additionHeader:self.additionHeader];
}

- (BOOL)urlMatch:(NSString *)urlString host:(NSString *)host {
    return [urlString containsString:host];
}

- (WKNavigation *)loadRequest:(NSURLRequest *)request additionHeader:(NSDictionary *)additionHeader {
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:request.URL];
    for (NSString *key in additionHeader.allKeys) {
        NSString *value = additionHeader[key];
        [urlRequest setValue:value forHTTPHeaderField:key];
    }
    return [super loadRequest:urlRequest];
}

/// 禁止长按弹出 UIMenuController 相关
+ (WKUserScript *)noneSelectScript{
    //禁止选择 css 配置相关
    NSString*css = @"body{-webkit-user-select:none;-webkit-user-drag:none;}";

    //css 选中样式取消
    NSMutableString*javascript = [NSMutableString string];
    [javascript appendString:@"var style = document.createElement('style');"];
    [javascript appendString:@"style.type = 'text/css';"];
    [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [javascript appendString:@"style.appendChild(cssContent);"];
    [javascript appendString:@"document.body.appendChild(style);"];
    [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按

    //javascript 注入
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];

    return noneSelectScript;
}

@end

@implementation WebBridgeResponseModel

@end

@implementation TFWebBridgePlugin

+ (void)wrapResponseCallBack:(WVJBResponseCallback)responseCallBack message:(NSString *)message result:(BOOL)result responseObject:(id)responseObject {
    NSString *realMessage = message ? message : @"";
    if(!responseObject) {
        responseObject = @{};
    }
    
    WebBridgeResponseModel *response = [WebBridgeResponseModel new];
    response.errorCode = result ? @(200) : @(-1);
    response.message = realMessage;
    response.result = responseObject;

    responseCallBack([response mj_keyValues]);
}

- (BOOL)registerBridge:(nonnull WKWebViewJavascriptBridge *)bridge {
    self.bridge = bridge;
    
    return YES;
}

@end
