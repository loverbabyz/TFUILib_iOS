//
//  TFModel.h
//  TFUILib
//
//  Created by xiayiyong on 16/1/14.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -
#pragma mark - TFModel
@protocol TFModel <NSObject>
@end

@interface TFModel : NSObject

/**
 唯一标识
 */
@property (nonatomic, copy) NSString *identity;

/**
 *  title
 */
@property (nonatomic, copy) NSString *title;

@end
