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

/// tag
@property (nonatomic, copy) NSString *tag;

/// Row类型
/// @see define from 'XLForm.h'
@property (nonatomic, copy) NSString *rowType;

/// 是否为必填
@property (nonatomic, assign) BOOL required;

/// value
@property (nonatomic, strong) id value;

/// 多个选项的数据源
@property (nonatomic, strong) NSArray<TFModel *> *selectorOptions;

/// 跳转目标viewController通过类名
@property (nonatomic, copy) NSString *viewControllerClass;

/// 跳转目标viewController通过StoryboardId
@property (nonatomic, copy) NSString * viewControllerStoryboardId;

/// 跳转目标viewController的NibName
@property (nonatomic, copy) NSString * viewControllerNibName;

/// 跳转目标viewController的模式
/// @see 'XLFormPresentationMode'
@property (nonatomic, assign) NSInteger viewControllerPresentationMode;

/// 跳转目标viewController通过SegueIdentifier
@property (nonatomic, copy) NSString * formSegueIdentifier;

/// 跳转目标viewController通过SegueClass
@property (nonatomic, copy) NSString *formSegueClass;

@end

NS_ASSUME_NONNULL_END
