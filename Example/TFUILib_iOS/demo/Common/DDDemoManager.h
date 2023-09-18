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

- (void)initDK:(DDDemoModel *)model completion:(IntegerBlock)completion;
- (void)addLog:(NSString *)log;

@end

NS_ASSUME_NONNULL_END
