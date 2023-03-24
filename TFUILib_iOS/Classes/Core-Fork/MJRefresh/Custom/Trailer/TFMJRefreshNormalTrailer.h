//
//  TFMJRefreshNormalTrailer.h
//  TFMJRefresh
//
//  Created by kinarobin on 2020/5/3.
//  Copyright © 2020 小码哥. All rights reserved.
//

#if __has_include("TFMJRefreshStateTrailer.h")
#import "TFMJRefreshStateTrailer.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface TFMJRefreshNormalTrailer : TFMJRefreshStateTrailer

@property (weak, nonatomic, readonly) UIImageView *arrowView;

@end

NS_ASSUME_NONNULL_END
