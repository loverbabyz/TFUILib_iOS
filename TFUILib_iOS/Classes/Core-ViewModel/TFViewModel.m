//
//  TFViewModel.m
//  TFUILib
//
//  Created by Daniel on 16/1/5.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFViewModel.h"
#import <TFBaseLib_iOS/TFMJExtension.h>
#import <TFBaseLib_iOS/TFBaseMacro+Path.h>

@implementation TFViewModel

-(instancetype)init
{
    if (self = [super init])
    {
        self.title = @"";
    }
    
    return self;
}

- (instancetype)initWithDataArray:(NSArray<__kindof TFTableSectionModel *> *)dataArray {
    if (self = [self init]) {
        _dataArray = dataArray;
    }
    
    return self;
}

-(NSArray<__kindof TFTableSectionModel *> *)dataArray
{
    if(_dataArray==nil)
    {
        NSString *className=NSStringFromClass([self class]);
        NSString *fileName=[NSString stringWithFormat:@"%@.json",className];
        NSDictionary *data = [self jsonDataFromFileName:fileName];
        _dataArray=[TFTableSectionModel tf_mj_objectArrayWithKeyValuesArray:data];
    }
    return _dataArray;
}

-(NSInteger)numberOfSections
{
    return self.dataArray.count;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return [self dataAtSection:section].dataArray.count;
}

- (__kindof TFTableRowModel *)dataAtIndexPath:(NSIndexPath *)indexPath
{
    TFTableSectionModel *obj = [self dataAtSection:indexPath.section];
    if (!obj)
    {
        return nil;
    }
    
    return obj.dataArray[indexPath.row];
}

- (void)removeDataAtIndexPath:(NSIndexPath *)indexPath {
    TFTableSectionModel *section = [self dataAtSection:indexPath.section];
    if (!section) {
        return;
    }
    
    // 如果当前section中只有一条数据，直接删除该section
    if (section.dataArray.count == 1) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:self.dataArray];
        [sectionArray removeObjectAtIndex:indexPath.section];
        
        self.dataArray = [NSArray arrayWithArray:sectionArray];
        
        return;
    }
    
    TFTableRowModel *obj = [self dataAtIndexPath:indexPath];
    if (!obj) {
        return;
    }
    
    NSMutableArray *rowArray = [NSMutableArray arrayWithArray:section.dataArray];
    [rowArray removeObjectAtIndex:indexPath.row];
    
    section.dataArray = [NSArray arrayWithArray:rowArray];
}

- (TFTableSectionModel *)dataAtSection:(NSInteger)section {
    return self.dataArray[section];
}

- (NSString*)titleAtSection:(NSInteger)section
{
    TFTableSectionModel *obj = [self dataAtSection:section];
    if (!obj)
    {
        return nil;
    }
    
    return obj.title;
}

- (NSString *)footTitleAtSection:(NSInteger)section
{
    TFTableSectionModel *obj = [self dataAtSection:section];
    if (!obj)
    {
        return nil;
    }
    
    return obj.footTitle;
}

- (BOOL)isEmpty {
    return [self numberOfSections] == 0;
}

- (id)mockData {
    return [self mockDataWithFileName:NSStringFromClass([self class])];
}

- (id)mockDataWithFileName:(NSString *)fileName {
    return [self jsonDataFromFileName:[NSString stringWithFormat:@"%@.json", fileName]];
}

- (id)jsonDataFromFileName:(NSString *)fileName
{
    NSString *jsonString = [self contentsOfFile:fileName];
    NSData* data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (data==nil)
    {
        return nil;
    }
    
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil)
    {
        return nil;
    }
    return result;
}

- (NSString *)contentsOfFile:(NSString *)fileName
{
    __autoreleasing NSError* error = nil;
    NSString *result = [[NSString alloc] initWithContentsOfFile:[self pathWithFileName:fileName]
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
    if (error != nil)
    {
        return nil;
    }
    return result;
}

- (NSString *)pathWithFileName:(NSString *)fileName
{
    return [self pathWithFileName:fileName ofType:nil];
}

- (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type
{
    return [TF_MAIN_BUNDLE pathForResource:fileName ofType:type];
}

@end
