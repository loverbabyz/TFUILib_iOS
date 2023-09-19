//
//  DDHomeViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2023/9/10.
//  Copyright © 2023 SunXiaofei. All rights reserved.
//

#import "DDHomeViewController.h"
#import "DDHomeViewModel.h"
#import "DDLoginViewController.h"
#import <IngeekDK/IngeekDK.h>
#import "DDMessages.h"
#import "DDLocalNotificationManager.h"
#import "DDAuthManager.h"

@interface DDHomeViewController ()<IngeekBleDelegate, IngeekDkDelegate>

@property (nonatomic, strong) DDHomeViewModel *viewModel;

@end

@implementation DDHomeViewController
@dynamic viewModel;

- (void)initViews {
    self.title = TF_LSTR(@"INGEEK DK DEMO");
}

- (void)bindData {
    [super bindData];
    
    NSString *vin = self.viewModel.vin;
    if (![vin isEmpty]) {
        XLFormRowDescriptor *row = [self.form formRowWithTag:kRowTag_VIN];
        TFTableRowModel *model = [TFTableRowModel new];
        model.identity = vin;
        row.value = model;
        
        [self reloadFormRow:row];
    }
    
    [IngeekBle sharedInstance].delegate = self;
    [IngeekDk sharedInstance].delegate = self;
}

#pragma mark - method

- (void)exportLog {
    [[IngeekDk sharedInstance] shareLog];
}

- (void)enableKey {
    [self showToast:TF_LSTR(@"Activating vehicle...")];
    
    typedef void (^CompletionBlock)(NSInteger errorCode);
    CompletionBlock block = ^(NSInteger errorCode) {
        if (!errorCode) {
            [self showToast:TF_LSTR(@"Activation success.")];
        } else {
            [self showToast:TF_STR(TF_LSTR(@"Activation failed, error: %@"), EMSG(errorCode))];
        }
    };
    
#ifdef Feature_HH
    // NOTE: ⚠️需要根据项目进行区分⚠️
    // 高合的激活与其他厂商的激活激活不同
    [[IngeekBle sharedInstance] enableKey:self.self.viewModel.vin ext:@"" completion:block];
#else
    [[IngeekBle sharedInstance] enableKey:self.viewModel.vin completion:block];
#endif
}

- (void)downloadKey {
    [[IngeekBle sharedInstance] downloadKey:self.viewModel.vin completion:^(NSInteger errorCode) {
        if (!errorCode) {
            [self showToast:TF_LSTR(@"Download key success.")];
        } else {
            [self showToast:[NSString stringWithFormat:
                             TF_STRINGIFY(Download key failed, error: %@),
                             EMSG(errorCode)]];
        }
    }];
}

- (void)getLocalKey {
    [[IngeekBle sharedInstance] getLocalKey:self.viewModel.vin
                                 completion:^(IngeekBleKey * _Nullable key,
                                              NSInteger errorCode) {
        NSLog(TF_STRINGIFY(####### key: %@, error code: %d), key, (int)errorCode);
        if (!errorCode) {
            [self showToast:TF_LSTR(@"Has local key.")];
        } else {
            [self showToast:[NSString stringWithFormat:
                             TF_STRINGIFY(Get local key failed, error code: %@),
                             EMSG(errorCode)]];
        }
    }];
}

- (void)getKeyEnabledState {
    [[IngeekBle sharedInstance] getKeyEnabledState:self.viewModel.vin completion:^(NSInteger state) {
        NSLog(TF_STRINGIFY(######## state: %d), (int)state);
        if (state == 0) {
            [self showToast:TF_LSTR(@"Key enabled.")];
        } else if (state == 1) {
            [self showToast:TF_LSTR(@"Key not enabled.")];
        } else {
            [self showToast:[NSString stringWithFormat:
                             TF_LSTR(@"Key not enabled, error: %@"),
                             EMSG(state)]];
        }
    }];
}

- (void)terminateKey {
    // Terminate the key, which means that vehicle will be unbound.
    [[IngeekBle sharedInstance] terminateKey:self.viewModel.vin completion:^(NSInteger errorCode) {
        if (!errorCode) {
            [self showToast:TF_LSTR(@"Terminate key success.")];
        } else {
            [self showToast:[NSString stringWithFormat:
                             TF_STRINGIFY(Terminate key failed, error code: %@),
                             EMSG(errorCode)]];
        }
    }];
}

- (void)connect {
    [self showToast:TF_LSTR(@"Connecting to vehicle...")];
    [[IngeekBle sharedInstance] connect:self.viewModel.vin];
    if (self.viewModel.vin.length) {
        [[NSUserDefaults standardUserDefaults] setObject:self.viewModel.vin forKey:kIngeekVinKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)connectStatus {
    [[IngeekBle sharedInstance] getConnectState:self.viewModel.vin completion:^(NSInteger state) {
        if (state == 0) {
            [self showToast:TF_LSTR(@"Vehicle disconnected.")];
        }
        else if (state == 1) {
            [self showToast:TF_LSTR(@"Vehicle is connecting...")];
        }
        else if (state == 2) {
            [self showToast:TF_LSTR(@"Vehicle connected.")];
        }
        else {
            [self showToast:[NSString stringWithFormat:TF_STRINGIFY(Error: %@), EMSG(state)]];
        }
    }];
}

- (void)disconnect {
    [[IngeekBle sharedInstance] disconnect:self.viewModel.vin];
}

- (void)lock {
    [self showToast:TF_LSTR(@"Sending command...")];
    
    TF_WEAK_SELF
    [[IngeekBle sharedInstance] send:self.viewModel.vin
                             command:[IngeekBleLockCommand command]
                          completion:^(NSInteger errorCode) {
        [weakSelf handleSendCommand:errorCode];
    }];
}

- (void)unlock {
    [self showToast:@"unlock"];
}

#pragma mark - onChangeBlock

- (void)vinChanged:(id)newValue {
    TFTableRowModel *obj = newValue;
    
    TF_WEAK_SELF
    [self.viewModel updateVIN:obj.identity completion:^(BOOL result) {
        XLFormSectionDescriptor *section = [weakSelf.form formSectionAtIndex:1];
        for (XLFormRowDescriptor *row in section.formRows) {
            row.disabled = @(!result);
            [weakSelf updateFormRow:row];
        }
        
        section = [weakSelf.form formSectionAtIndex:2];
        for (XLFormRowDescriptor *row in section.formRows) {
            row.disabled = @(!result);
            [weakSelf updateFormRow:row];
        }
        
        section = [weakSelf.form formSectionAtIndex:3];
        for (XLFormRowDescriptor *row in section.formRows) {
            row.disabled = @(!result);
            [weakSelf updateFormRow:row];
        }
        
    }];
}

- (void)levelChanged:(id)newValue {
    XLFormOptionsObject *obj = newValue;
    IngeekCalibrationSensitivityLevel level = (IngeekCalibrationSensitivityLevel)((NSNumber *)obj.formValue).intValue;
    
    [[DDAuthManager sharedManager] updateCalibrationLevel:@(level)];
    
    TF_WEAK_SELF
    [[IngeekBle sharedInstance] setCalibrationSensitivity:self.viewModel.vin level:level completion:^(NSInteger errorCode) {
        if (!errorCode) {
            [weakSelf showToast:TF_LSTR(@"Set Calibration Sensitivity Success.")];
        } else {
            NSString *msg = [NSString stringWithFormat:
                             TF_LSTR(@"Set Calibration Sensitivity failed : error: %@"), EMSG(errorCode)];
            [weakSelf showToast:msg];
        }
    }];
}

#pragma mark - Predicate

//- (id)vinPredicate {
////    return [NSString stringWithFormat:@"NOT ($%@.count > 4)", kRowTag_VIN];
//    BOOL f = self.viewModel.vin.length > 0;
//    return @(!(self.viewModel.vin.length > 0));
//}

- (id)mc01Predicate {
    return @(![self.viewModel.appId isEqualToString:kRowTag_MC01]);
}

- (id)jxaPredicate {
    return @(![self.viewModel.appId isEqualToString:kRowTag_JXA]);
}

- (id)dfmPredicate {
    return @(![self.viewModel.appId isEqualToString:kRowTag_DFM]);
}

#pragma mark - DK delegate

- (void)didReceiveLog:(NSString *)log level:(IngeekDkLogLevel)level {
//    NSLog(@"🔔 %@", log);
    [self.viewModel addLog:log];
    if (!self.viewModel.ibeaconEnable) {
        return;
    }

    if ([log containsString:TF_STRINGIFY(Get paired peripheral retrieved with identifier.)]) {
        [[DDLocalNotificationManager sharedInstance] addLocalNotification:TF_LSTR(TF_STRINGIFY(notification_app)) message:TF_LSTR(@"start_connect_vehicle") deep:NO];
    }
    
    if ([log containsString:TF_STRINGIFY(Start to connect without peripheral, and try to scan then.)]) {
        [[DDLocalNotificationManager sharedInstance] addLocalNotification:TF_LSTR(TF_STRINGIFY(notification_app)) message:TF_LSTR(@"start_scan_vehicle") deep:NO];
    }
}

- (NSDictionary<NSString *,id> *)userInfo {
    return @{
        @"idk-calibration-level": [[DDAuthManager sharedManager] calibrationLevel] // Refer to @enum IngeekCalibrationSensitivityLevel
    };
}

#pragma mark - Ble delegate

- (void)didConnect:(NSString *)pid errorCode:(NSInteger)errorCode {
    NSLog(TF_STRINGIFY(############# did connect: %@, %d), pid, (int)errorCode);
    if (errorCode) {
        [self showToast:[NSString stringWithFormat:TF_LSTR(@"Connect to vehicle failed, error code: %@"), EMSG(errorCode)]];
    } else {
        self.title = TF_LSTR(@"INGEEK DK DEMO");
        [self showToast:TF_LSTR(@"Connect to vehicle success.")];
        
        if (self.viewModel.ibeaconEnable) {
            [[DDLocalNotificationManager sharedInstance] addLocalNotification:TF_LSTR(@"notification_app") message:TF_LSTR(@"Connect to vehicle success.") deep:YES];
        }
    }
    
    [self.viewModel addLog:TF_STR(TF_STRINGIFY(did connect: %@, %d), pid, (int)errorCode)];
}

- (void)didDisconnect:(NSString *)pid errorCode:(NSInteger)errorCode {
    NSLog(TF_STRINGIFY(############# did disconnect: %@), pid);
    [self showToast:TF_LSTR(@"Did disconnect from vehicle.")];
    
    [self.viewModel addLog:TF_STR(TF_STRINGIFY(did disconnect: %@, %d), pid, (int)errorCode)];
}

- (void)didReceivePairCode:(NSString *)pid pairCode:(NSString *)pairCode {
    NSLog(TF_STRINGIFY(############# did receive pair code: %@, %@), pid, pairCode);
    self.title = [NSString stringWithFormat:TF_STRINGIFY(Pair Code: %@), pairCode];
    
    [self.viewModel addLog:TF_STR(TF_STRINGIFY(did receive pair code: %@, %@), pid, pairCode)];
}

- (void)didReceiveData:(NSString *)pid data:(NSData *)data {
    return;
    NSLog(TF_STRINGIFY(############# data:%@, data: %@), pid, data);
    NSString *hexString = [self hexStringFromData:data];
    if(hexString.length < 8) {
        return;
    }
    if (![[[hexString substringWithRange:NSMakeRange(4, 4)] uppercaseString] isEqual:TF_STRINGIFY(F020)]){
        return;
    }
    
    static BOOL decrptCalibrateData = NO;
    
    NSString *val = [hexString substringFromIndex:6];
    
    NSString *str = val;
    // logI("收到周期性数据" + str);
    
    if (str.length < 120) {
//        logI([NSString stringWithFormat:@"周期性数据长度异常：%@", @(str.length)]);
        return;
    }
    //20
    NSString *mask = [str substringWithRange:NSMakeRange(10, 2)];
    NSLog(TF_STRINGIFY($$$$$$$$$%@), [NSString stringWithFormat:TF_STRINGIFY(周期性数据解析完成,mask:%@), mask]);
    //6
    NSString *lenStr = [str substringWithRange:NSMakeRange(14, 2)];
    NSInteger len = [self hexStringToInt:lenStr];
    NSLog(TF_STRINGIFY($$$$$$$$$%@), [NSString stringWithFormat:TF_STRINGIFY(周期性数据解析完成,len:%ld), (long)len]);
    //E8 82 82 82
    NSString *rssi = [str substringWithRange:NSMakeRange(16, len * 2)];
    NSLog(TF_STRINGIFY($$$$$$$$$%@), [NSString stringWithFormat:TF_STRINGIFY(周期性数据解析完成,rssi:%@), rssi]);
    //948C23EAEE29ECEE292A2B9091929330313233345645444B4A3A3B3C3D3E3F
    NSString *calibrateRawData = [str substringWithRange:NSMakeRange(16 + len * 2 + 4, 64)];
    NSLog(TF_STRINGIFY($$$$$$$$$%@), [NSString stringWithFormat:TF_STRINGIFY(周期性数据解析完成,calibrateRawData:%@), calibrateRawData]);
    
    //解密
    NSString *calibrateData = calibrateRawData;
    if (decrptCalibrateData) {
        calibrateData = [self getDecrptCalibrateBytes:calibrateRawData];
    }
    
    NSLog(TF_STRINGIFY($$$$$$$$$%@), [NSString stringWithFormat:TF_STRINGIFY(周期性数据解析完成,calibrateData:%@), calibrateData]);
    //0582E382050000FB00B57E0000000540
    NSString *debugData = [str substringWithRange:NSMakeRange(16 + len * 2 + 4 + 64 + 4, 32)];
    NSLog(TF_STRINGIFY($$$$$$$$$%@), [NSString stringWithFormat:TF_STRINGIFY(周期性数据解析完成.debugData:%@), debugData]);
    
    [self parseRightPopDataSourceWithRSSI:rssi debugData:debugData];
    [self parseCalibrationData:calibrateData];
    NSLog(TF_STRINGIFY(Done));
}

#pragma mark -

- (void)handleSendCommand:(NSInteger)errorCode {
    if (!errorCode) {
        [self showToast:TF_LSTR(@"Command send success.")];
    } else {
        [self showToast:[NSString stringWithFormat:TF_LSTR(@"Command send failed, error: %@"),
                         EMSG(errorCode)]];
    }
}

- (NSString *)hexStringFromData:(NSData *)data{
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

- (NSData *)hexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

- (NSInteger)hexStringToInt:(NSString *)hex {
    int val = 0;
    int len = (int)hex.length;
    for (int i = 0; i < len; i++) {
        unichar hexDigit = [hex characterAtIndex:i];
        if (hexDigit >= 48 && hexDigit <= 57) {
            val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
        } else if (hexDigit >= 65 && hexDigit <= 70) {
            // A..F
            val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
        } else if (hexDigit >= 97 && hexDigit <= 102) {
            // a..f
            val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
        } else {
            @throw [NSException exceptionWithName:TF_STRINGIFY(FormatException) reason:TF_STRINGIFY(Invalid hexadecimal value) userInfo:nil];
        }
    }
    return val;
}

- (NSInteger)hexStringToSignedInt:(NSString *)hex {
    NSInteger val = [self hexStringToInt:hex];
    
    if (val - 256 <= 126 && val - 256 >= (1 - 128)) {
        return val - 256;
    } else {
        return val;
    }
}

- (NSData *)xor_EncodeData:(NSData *)sourceData withKey:(NSData *)keyData{
    Byte *keyBytes = (Byte *)[keyData bytes];
    Byte *sourceDataPoint = (Byte *)[sourceData bytes];
    for (long i = 0; i < [sourceData length]; i++) {
        sourceDataPoint[i] = (32 + i) ^ keyBytes[i];
    }
    return sourceData;
}

- (NSString *)getDecrptCalibrateBytes:(NSString *)dataString {
    NSData *da = [self hexStrToData:dataString];
    NSData *sourceData= [[NSMutableData alloc] initWithLength:32].copy;
    NSData *calibrtionData = [self xor_EncodeData:sourceData withKey:da];
    NSString *str = [self hexStringFromData:calibrtionData];
    
    return str;
}

- (NSArray *)gModulesList {
    return @[@"主   ", @"左   ", @"右   @", @"后   ", @"B柱  ", @"尾箱 "];
}
- (void)parseRightPopDataSourceWithRSSI:(NSString *)rssi debugData:(NSString *)debugData {
    // 准备 RKE 数据
    if (rssi.length < 2 || debugData.length == 0) {
        NSLog(@"周期性数据格式错误");
        return;
    }
    
    NSMutableArray<NSString *> *modulesList = [NSMutableArray array];
    NSString *currentRightPopData = [NSString stringWithFormat:@"%@%@", rssi, debugData];
    
//    self.currentRightPopData = currentRightPopData;
    NSString *rssiVal = [NSString stringWithFormat:@"%ld", [self hexStringToSignedInt:[rssi substringWithRange:NSMakeRange(0, 2)]]];
//    self.rightPopDataSource = currentRightPopData;
    double valueLen = currentRightPopData.length / 2;
    NSString *moduleName;
    for (NSInteger i = 0; i < (NSInteger)valueLen; i++) {
        NSString *hexStr = [currentRightPopData substringWithRange:NSMakeRange(i * 2, 2)];
        if (i <= 5) {
            moduleName = self.gModulesList[i];
        } else {
            if (i == 6) {
                moduleName = (self.gModulesList.count == 6) ? @"m0 " : self.gModulesList[i];
            } else {
                moduleName = (self.gModulesList.count == 6) ? [NSString stringWithFormat:@"m%ld ", i - 6] : self.gModulesList[i];
            }
        }
        NSString *moduleData = [NSString stringWithFormat:@"%@: %ld", moduleName, [self hexStringToSignedInt:hexStr]];
        [modulesList addObject:moduleData];
    }
    NSLog(TF_STRINGIFY(RSSI));
}

- (void)parseCalibrationData:(NSString *)calibrateData {
    NSMutableArray<NSString *> *calibrationList = [NSMutableArray array];
    NSInteger length = calibrateData.length / 2;
    for (NSInteger i = 0; i < length; i++) {
        NSString *hexStr = [calibrateData substringWithRange:NSMakeRange(i * 2, 2)];
        NSString *calibrationValue = [NSString stringWithFormat:@"%ld", [self hexStringToSignedInt:hexStr]];
        [calibrationList addObject:calibrationValue];
    }
    NSLog(TF_STRINGIFY(CalibrationData));
}

#pragma mark - Inner methods

- (IngeekBleCommand *)ap:(uint8_t)v {
    NSMutableData *mData = [[NSMutableData alloc] init];
    uint8_t t = 0x61, l = 0x01;
    [mData appendBytes:&t length:1];
    [mData appendBytes:&l length:1];
    [mData appendBytes:&v length:1];
    return [[IngeekBleCommand alloc] initWithData:mData.copy];
}

@end
