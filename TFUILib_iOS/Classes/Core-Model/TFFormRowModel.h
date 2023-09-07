//
//  TFFormRowModel.h
//  TFUILib
//
//  Created by Daniel on 7/9/23.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <TFUILib_iOS/TFUILib_iOS.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFFormRowModel : TFTableRowModel

/// rowType
/// @see define from 'XLForm.h'
@property (nonatomic, copy) NSString *rowType;

/// required
@property (nonatomic, assign) BOOL required;

@end

NS_ASSUME_NONNULL_END
