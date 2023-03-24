//  代码地址: https://github.com/CoderMJLee/MJRefresh

#import <Foundation/Foundation.h>

#if __has_include(<TFUILib_iOS/TFMJRefresh.h>)
FOUNDATION_EXPORT double TFMJRefreshVersionNumber;
FOUNDATION_EXPORT const unsigned char TFMJRefreshVersionString[];

#import <TFUILib_iOS/UIScrollView+TFMJRefresh.h>
#import <TFUILib_iOS/UIScrollView+TFMJExtension.h>
#import <TFUILib_iOS/UIView+TFMJExtension.h>

#import <TFUILib_iOS/TFMJRefreshNormalHeader.h>
#import <TFUILib_iOS/TFMJRefreshGifHeader.h>

#import <TFUILib_iOS/TFMJRefreshBackNormalFooter.h>
#import <TFUILib_iOS/TFMJRefreshBackGifFooter.h>
#import <TFUILib_iOS/TFMJRefreshAutoNormalFooter.h>
#import <TFUILib_iOS/TFMJRefreshAutoGifFooter.h>

#import <TFUILib_iOS/TFMJRefreshNormalTrailer.h>
#import <TFUILib_iOS/TFMJRefreshConfig.h>
#import <TFUILib_iOS/NSBundle+TFMJRefresh.h>
#import <TFUILib_iOS/TFMJRefreshConst.h>
#else
#import "UIScrollView+TFMJRefresh.h"
#import "UIScrollView+TFMJExtension.h"
#import "UIView+TFMJExtension.h"

#import "TFMJRefreshNormalHeader.h"
#import "TFMJRefreshGifHeader.h"

#import "TFMJRefreshBackNormalFooter.h"
#import "TFMJRefreshBackGifFooter.h"
#import "TFMJRefreshAutoNormalFooter.h"
#import "TFMJRefreshAutoGifFooter.h"

#import "TFMJRefreshNormalTrailer.h"
#import "TFMJRefreshConfig.h"
#import "NSBundle+TFMJRefresh.h"
#import "TFMJRefreshConst.h"
#endif
