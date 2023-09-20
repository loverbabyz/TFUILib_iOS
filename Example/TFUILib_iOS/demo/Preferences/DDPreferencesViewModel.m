//
//  DDPreferencesViewModel.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/16.
//

#import "DDPreferencesViewModel.h"
#import <TFUILib_iOS/TFFormRowModel.h>
#import <IngeekDK/IngeekDk.h>

@implementation DDPreferencesViewModel

- (NSString *)title {
    return TF_LSTR(@"SET/GET PREFERENCES");
}

- (void)fetchData:(IntegerBlock)completion {
    [[IngeekBle sharedInstance] getPreferences:self.vin
                                    completion:^(NSDictionary<NSNumber *, NSNumber *>
                                                 * _Nullable preferences, NSInteger errorCode) {
        
        if (errorCode) {
            if (completion) {
                completion(errorCode);
            }
            
            return;
        }
        
        for (NSInteger i = 0, n = [self numberOfRowsInSection:0]; i < n; ++i) {
            NSNumber *v = [preferences objectForKey:@(i)];
            
            TFFormRowModel *row = [self dataAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            row.value = v? @(v.integerValue) : @(0);
        }
        
        if (completion) {
            completion(0);
        }
    }];
}

- (void)save:(NSDictionary *)form completion:(IntegerBlock)completion {
    NSMutableDictionary<NSNumber *, NSNumber *> *preferences = [NSMutableDictionary<NSNumber *, NSNumber *> dictionary];
    for (NSInteger i = 0, n = form.count; i < n; ++i) {
        NSNumber *value = form[TF_STR(TF_STRINGIFY(%ld), i)];
        NSNumber *object = [NSNumber numberWithInteger:value.integerValue];
        [preferences setObject:object forKey:@(i)];
    }
    [[IngeekBle sharedInstance] setPreferences:self.vin
                                   preferences:preferences.copy
                                    completion:^(NSInteger errorCode) {
        if (completion) {
            completion(errorCode);
        }
    }];
}

@end
