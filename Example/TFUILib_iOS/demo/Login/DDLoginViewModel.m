//
//  DDLoginViewModel.m
//  TFUILib_iOS_Example
//
//  Created by Ingeek-091 on 2023/9/6.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDLoginViewModel.h"
#import "TFUserDefaults+demo.h"
#import <TFUILib_iOS/TFFormRowModel.h>
#import <IngeekDK/IngeekDK.h>
#import "DDDemoManager.h"

@implementation DDLoginViewModel

- (NSString *)title {
    return TF_LSTR(@"LOGIN");
}

- (void)login:(NSDictionary *)form completion:(IntegerBlock)completion {
    DDDemoModel *model = [DDDemoModel tf_mj_objectWithKeyValues:form];
    
    if (tf_isEmpty(model.envriment) || tf_isEmpty(model.appId)) {
        if (completion) {
            completion(IngeekDkErrorCodeInvalidArguments);
        }
        
        return;
    }
    
    [[DDDemoManager sharedInstance] initDK:model completion:^(NSInteger errorCode) {
        if (!errorCode) {
            [kUserDefaults login:[DDDemoModel tf_mj_objectWithKeyValues:form]];
        }
        
        if (completion) {
            completion(errorCode);
        }
    }];
}

- (NSString *)appId {
    return kUserDefaults.model.appId;
}

- (NSString *)envriment {
    return kUserDefaults.model.envriment;
}

- (NSString *)userId {
    return kUserDefaults.model.userId;
}

- (NSString *)mobile {
    return kUserDefaults.model.mobile;
}

-(BOOL)ibeaconEnable {
    return kUserDefaults.model.ibeaconEnable;
}

@end
@implementation TFTableRowModel (XLForm)

- (NSString *)formDisplayText {
    return self.title;
}

- (id)formValue {
    return self.identity;
}

@end
