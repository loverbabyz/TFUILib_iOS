//
//  DDDemoManager.h
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import <Foundation/Foundation.h>
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>

NS_ASSUME_NONNULL_BEGIN

@class DDDemoModel;
@interface DDDemoManager : NSObject

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *logs;

TFSingletonH(Instance)

/// 初始化DK
/// - Parameters:
///   - model: 用户配置信息
///   - completion: completion
- (void)initDK:(DDDemoModel *)model completion:(IntegerBlock)completion;

/// 添加日志到缓存
/// - Parameter log: log
- (void)addLog:(NSString *)log;

/// 清空缓存日志
/// - Parameters:
///   - completion: completion
- (void)cleanLog:(VoidBlock)completion;

@end

NS_ASSUME_NONNULL_END
