//
//  TFFormViewModel.h
//  TFUILib
//
//  Created by Daniel on 7/9/23.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//


#import "TFViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TFFormSectionModel;
@protocol TFFormViewModel <NSObject>

@end
@interface TFFormViewModel : TFViewModel

@property (nonatomic,strong) NSArray<__kindof TFFormSectionModel *> *formDataArray;

@end

NS_ASSUME_NONNULL_END
