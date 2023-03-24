//  代码地址: https://github.com/CoderMJLee/MJRefresh
#import <UIKit/UIKit.h>
#import <objc/message.h>
#import <objc/runtime.h>

// 弱引用
#define TFMJWeakSelf __weak typeof(self) weakSelf = self;

// 日志输出
#ifdef DEBUG
#define TFMJRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define TFMJRefreshLog(...)
#endif

// 过期提醒
#define TFMJRefreshDeprecated(DESCRIPTION) __attribute__((deprecated(DESCRIPTION)))

// 运行时objc_msgSend
#define TFMJRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define TFMJRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define TFMJRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define TFMJRefreshLabelTextColor TFMJRefreshColor(90, 90, 90)

// 字体大小
#define TFMJRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 常量
UIKIT_EXTERN const CGFloat TFMJRefreshLabelLeftInset;
UIKIT_EXTERN const CGFloat TFMJRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat TFMJRefreshFooterHeight;
UIKIT_EXTERN const CGFloat TFMJRefreshTrailWidth;
UIKIT_EXTERN const CGFloat TFMJRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat TFMJRefreshSlowAnimationDuration;


UIKIT_EXTERN NSString *const TFMJRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const TFMJRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const TFMJRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const TFMJRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const TFMJRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const TFMJRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const TFMJRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const TFMJRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const TFMJRefreshTrailerIdleText;
UIKIT_EXTERN NSString *const TFMJRefreshTrailerPullingText;

UIKIT_EXTERN NSString *const TFMJRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const TFMJRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const TFMJRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const TFMJRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const TFMJRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const TFMJRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const TFMJRefreshBackFooterNoMoreDataText;

UIKIT_EXTERN NSString *const TFMJRefreshHeaderLastTimeText;
UIKIT_EXTERN NSString *const TFMJRefreshHeaderDateTodayText;
UIKIT_EXTERN NSString *const TFMJRefreshHeaderNoneLastDateText;

UIKIT_EXTERN NSString *const TFMJRefreshDidChangeLanguageNotification;

// 状态检查
#define TFMJRefreshCheckState \
TFMJRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];

// 异步主线程执行，不强持有Self
#define TFMJRefreshDispatchAsyncOnMainQueue(x) \
__weak typeof(self) weakSelf = self; \
dispatch_async(dispatch_get_main_queue(), ^{ \
typeof(weakSelf) self = weakSelf; \
{x} \
});

/// 替换方法实现
/// @param _fromClass 源类
/// @param _originSelector 源类的 Selector
/// @param _toClass  目标类
/// @param _newSelector 目标类的 Selector
CG_INLINE BOOL TFMJRefreshExchangeImplementations(
                                                Class _fromClass, SEL _originSelector,
                                                Class _toClass, SEL _newSelector) {
    if (!_fromClass || !_toClass) {
        return NO;
    }
    
    Method oriMethod = class_getInstanceMethod(_fromClass, _originSelector);
    Method newMethod = class_getInstanceMethod(_toClass, _newSelector);
    if (!newMethod) {
        return NO;
    }
    
    BOOL isAddedMethod = class_addMethod(_fromClass, _originSelector,
                                         method_getImplementation(newMethod),
                                         method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        // 如果 class_addMethod 成功了，说明之前 fromClass 里并不存在 originSelector，所以要用一个空的方法代替它，以避免 class_replaceMethod 后，后续 toClass 的这个方法被调用时可能会 crash
        IMP emptyIMP = imp_implementationWithBlock(^(id selfObject) {});
        IMP oriMethodIMP = method_getImplementation(oriMethod) ?: emptyIMP;
        const char *oriMethodTypeEncoding = method_getTypeEncoding(oriMethod) ?: "v@:";
        class_replaceMethod(_toClass, _newSelector, oriMethodIMP, oriMethodTypeEncoding);
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
    return YES;
}
