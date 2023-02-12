//
//  TFWebViewController.m
//  Treasure
//
//  Created by Daniel on 15/9/9.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFWebViewController.h"
#import "TFWebViewControllerAppearance.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "TFBaseLib_iOS.h"

#define kScreen_Height SCREEN_HEIGHT
#define kScreen_Width  SCREEN_WIDTH

NSString * const DKWebViewKeyEstimateProgress = @"estimatedProgress";
NSString * const DKWebViewKeyCanGoBack = @"canGoBack";
NSString * const DKWebViewKeyTitle = @"title";

@interface TFWebViewController () <WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate>

/// webview
@property (nonatomic, strong) TFWebView *webView;

@property (nonatomic, strong) UIBarButtonItem *closeItem;
@property (nonatomic, strong) UIBarButtonItem *backItem;

/// 进度条
@property (nonatomic) UIProgressView *progressView;

@end

@implementation TFWebViewController

- (instancetype)init {
    if (self = [super init]) {
        
    }

    return self;
}

- (void)initViews {
    [super initViews];
    
    [self initNaviItem];
    [self createBaseView];
}

- (void)bindData {
    [super bindData];
}

- (void)createBaseView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    [self.webView addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:DKWebViewKeyEstimateProgress options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:DKWebViewKeyCanGoBack options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:DKWebViewKeyTitle options:NSKeyValueObservingOptionNew context:nil];
    
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.offset(0);
    }];
    
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.equalTo(@(1));
    }];
}

- (void)addPlug:(id<TFWebBridgePluginDelegate>)plugin {
    [self.webView addPlug:plugin];
}

- (void)hideBackButton {
    self.navigationItem.leftBarButtonItems = @[];
}

- (void)initNaviItem {
    UIImage *backImage = [TFWebViewControllerAppearance sharedAppearance].backItemImage;
    self.backItem = [[UIBarButtonItem alloc] initWithImage:[backImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImage.size.width, 0, 0)] style:UIBarButtonItemStylePlain target:self action:@selector(naviBackButtonClicked)];

    UIImage *closeImage = [TFWebViewControllerAppearance sharedAppearance].closeItemImage;
    self.closeItem = [[UIBarButtonItem alloc] initWithImage:closeImage style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonClicked)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (object == self.webView) {
        if([keyPath isEqualToString:DKWebViewKeyEstimateProgress]) {
            CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
            [self.progressView setProgress:newprogress animated:YES];
            if (newprogress >= 1) {
                [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                } completion:^(BOOL finished) {
                    self.progressView.hidden = YES;
                }];
            }
        } else if ([keyPath isEqualToString:DKWebViewKeyTitle]) {
            NSString *title = [[change objectForKey:NSKeyValueChangeNewKey] stringValue];
            self.title = title;
        } else if ([keyPath isEqualToString:DKWebViewKeyCanGoBack]) {
            bool x = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
            if (x) {
                self.navigationItem.leftBarButtonItems = @[self.backItem,self.closeItem];
            } else {
                self.navigationItem.leftBarButtonItems = @[self.backItem];
            }
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 让webview的内容一直居中显示
    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - kScreen_Width) / 2, scrollView.contentOffset.y);
}

#pragma mark -- load request
- (void)loadRequest:(NSURLRequest *)request {
    [self.webView loadRequest:request];
}

- (void)loadURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

- (void)loadHTMLString:(NSString *)htmlString baseURL:(nullable NSURL *)baseURL {
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}

#pragma mark - click method
- (void)naviBackButtonClicked {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
        /// html历史记录返回时，强制刷新页面，解决前端无法获取数据问题(太low)
        [self.webView reload];
    } else {
        [self closeButtonClicked];
    }
}

- (void)closeButtonClicked {
    [self.view resignFirstResponder];
    if (self.navigationController
        && self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - WKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation  API_AVAILABLE(ios(8.0)){
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation  API_AVAILABLE(ios(8.0)){
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
//    [((TFWebView *)webView).jsBridge callHandler:@"refreshData" data:nil responseCallback:^(id responseData) {
//        NSLog(@"Refresh Data Done");
//    }];
    
    if (self.didFinishNavigationBlock) {
        self.didFinishNavigationBlock();
    }
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error  API_AVAILABLE(ios(8.0)){
    NSLog(@"加载失败");
    //加载失败隐藏progressView
    self.progressView.hidden = YES;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [URL resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [APP_APPLICATION openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:^(BOOL success) {
                
            }];
        });
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
        CFDataRef exceptions = SecTrustCopyExceptions(serverTrust);
        SecTrustSetExceptions(serverTrust, exceptions);
        CFRelease(exceptions);
        
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

#pragma mark - get & set
- (TFWebView *)webView {
    if (!_webView) {
        _webView = [[TFWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-STATUS_BAR_HEIGHT-44)];
        _webView.scrollView.delegate = self;
        [_webView setWebViewDelegate:self];
        
        if (self.addionalHeader) {
            _webView.additionHeader = self.addionalHeader;
        }
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        [_progressView setTintColor:[TFWebViewControllerAppearance sharedAppearance].progressColor];
        _progressView.progress = 0.2;
        _progressView.backgroundColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:DKWebViewKeyEstimateProgress];
    [self.webView removeObserver:self forKeyPath:DKWebViewKeyCanGoBack];
    [self.webView removeObserver:self forKeyPath:DKWebViewKeyTitle];
}

@end
