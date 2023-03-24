//  代码地址: https://github.com/CoderMJLee/MJRefresh
#import <UIKit/UIKit.h>

const CGFloat TFMJRefreshLabelLeftInset = 25;
const CGFloat TFMJRefreshHeaderHeight = 54.0;
const CGFloat TFMJRefreshFooterHeight = 44.0;
const CGFloat TFMJRefreshTrailWidth = 60.0;
const CGFloat TFMJRefreshFastAnimationDuration = 0.25;
const CGFloat TFMJRefreshSlowAnimationDuration = 0.4;


NSString *const TFMJRefreshKeyPathContentOffset = @"contentOffset";
NSString *const TFMJRefreshKeyPathContentInset = @"contentInset";
NSString *const TFMJRefreshKeyPathContentSize = @"contentSize";
NSString *const TFMJRefreshKeyPathPanState = @"state";

NSString *const TFMJRefreshHeaderLastUpdatedTimeKey = @"TFMJRefreshHeaderLastUpdatedTimeKey";

NSString *const TFMJRefreshHeaderIdleText = @"TFMJRefreshHeaderIdleText";
NSString *const TFMJRefreshHeaderPullingText = @"TFMJRefreshHeaderPullingText";
NSString *const TFMJRefreshHeaderRefreshingText = @"TFMJRefreshHeaderRefreshingText";

NSString *const TFMJRefreshTrailerIdleText = @"TFMJRefreshTrailerIdleText";
NSString *const TFMJRefreshTrailerPullingText = @"TFMJRefreshTrailerPullingText";

NSString *const TFMJRefreshAutoFooterIdleText = @"TFMJRefreshAutoFooterIdleText";
NSString *const TFMJRefreshAutoFooterRefreshingText = @"TFMJRefreshAutoFooterRefreshingText";
NSString *const TFMJRefreshAutoFooterNoMoreDataText = @"TFMJRefreshAutoFooterNoMoreDataText";

NSString *const TFMJRefreshBackFooterIdleText = @"TFMJRefreshBackFooterIdleText";
NSString *const TFMJRefreshBackFooterPullingText = @"TFMJRefreshBackFooterPullingText";
NSString *const TFMJRefreshBackFooterRefreshingText = @"TFMJRefreshBackFooterRefreshingText";
NSString *const TFMJRefreshBackFooterNoMoreDataText = @"TFMJRefreshBackFooterNoMoreDataText";

NSString *const TFMJRefreshHeaderLastTimeText = @"TFMJRefreshHeaderLastTimeText";
NSString *const TFMJRefreshHeaderDateTodayText = @"TFMJRefreshHeaderDateTodayText";
NSString *const TFMJRefreshHeaderNoneLastDateText = @"TFMJRefreshHeaderNoneLastDateText";

NSString *const TFMJRefreshDidChangeLanguageNotification = @"TFMJRefreshDidChangeLanguageNotification";
