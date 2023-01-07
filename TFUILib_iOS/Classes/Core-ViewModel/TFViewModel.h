//
//  TFViewModel.h
//  TFUILib
//
//  Created by Daniel on 16/1/5.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TFTableSectionModel.h"
#import "TFModel.h"

#pragma mark -
#pragma mark - TFModel
@protocol TFViewModel <NSObject>
@end

@interface TFViewModel : NSObject

@property (nonatomic, copy) NSString *title;

/**
 *  
 */
@property (nonatomic,strong) NSArray<__kindof TFTableSectionModel *> *dataArray;

/**
 用dataArray初始化模型

 @param dataArray 数据源
 */
- (instancetype)initWithDataArray:(NSArray<__kindof TFTableSectionModel *> *)dataArray;

/**
 *  获取indexPath所在行数据
 *
 *  @param indexPath indexPath
 */
- (__kindof TFTableRowModel *)dataAtIndexPath:(NSIndexPath *)indexPath;

/**
 移除indexPath所在数据

 @param indexPath indexPath
 */
- (void)removeDataAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  获取section所在数据
 *
 *  @param section section
 */
- (TFTableSectionModel *)dataAtSection:(NSInteger)section;

/**
 *  获取section段title
 *
 *  @param section section
 */
- (NSString*)titleAtSection:(NSInteger)section;

/**
 *  有多少行
 */
- (NSInteger)numberOfSections;

/**
 *  所在行有多少列
 *
 *  @param section section
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 数据源是否为空
 */
- (BOOL)isEmpty;

/// 返回Mock数据
- (id)mockData;

/// 通过文件名返回Mock数据
/// @param fileName JSON文件名称
- (id)mockDataWithFileName:(NSString *)fileName;

@end
