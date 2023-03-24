//
//  NSBundle+TFMJRefresh.h
//  TFMJRefresh
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (TFMJRefresh)
+ (instancetype)tf_mj_refreshBundle;
+ (UIImage *)tf_mj_arrowImage;
+ (UIImage *)tf_mj_trailArrowImage;
+ (NSString *)tf_mj_localizedStringForKey:(NSString *)key value:(nullable NSString *)value;
+ (NSString *)tf_mj_localizedStringForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
