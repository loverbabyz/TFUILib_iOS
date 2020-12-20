//
//  TFYearPicker.m
//  TFUILib
//
//  Created by xiayiyong on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFYearPicker.h"
#import "TFTreeNode.h"

#define kStartYear 2000

@interface TFYearPicker ()

@property (nonatomic,assign) NSInteger minYear;
@property (nonatomic,assign) NSInteger maxYear;
@property (nonatomic,strong) NSString *currentYear;

@end

@implementation TFYearPicker

+ (void)showWithBlock:(TFYearPickerBlock)block
{
    NSDate *dateNow = [NSDate date];
    NSInteger maxYear = [[TFYearPicker stringFromTime:dateNow format:@"yyyy"]integerValue];
    
    NSMutableArray *yearArray=[NSMutableArray arrayWithCapacity:maxYear];
    for (NSInteger year = kStartYear; year <= maxYear ; year++)
    {
        TFTreeNode *node = [TFTreeNode new];
        node.title = [NSString stringWithFormat:@"%ld年", year];
        
        [yearArray addObject:node];
    }
    TFTreeNode *node = [TFTreeNode new];
    node.nodes = [NSArray arrayWithArray:yearArray];
    
    TFPicker *pick = [TFPicker initWithBlock:^(NSDictionary *selectedData) {
        if (block) {
            TFTreeNode *node = [selectedData objectForKey:@(0)];
            block(node.title);
        }
    } dataArray:@[node] components:1];
    
    [pick selectRow:node.nodes.count - 1 inComponent:0 animated:YES];
    [pick show:^(BOOL finished) {
        
    }];
}

+ (NSString *)stringFromTime:(NSDate *)time format:(NSString*)format
{
    NSDateFormatter *dateFromatter=[[NSDateFormatter alloc] init];
    [dateFromatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFromatter setDateFormat:format];
    NSString *strTime = [dateFromatter stringFromDate:time];
    return strTime;
}

@end
