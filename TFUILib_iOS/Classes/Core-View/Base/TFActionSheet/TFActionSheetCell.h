//
//  FSActionSheetCell.h
//  FSActionSheet
//
//  Created by Steven on 6/7/16.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFActionSheetConfig.h"
@class TFActionSheetItem;

@interface TFActionSheetCell : UITableViewCell

@property (nonatomic, assign) TFContentAlignment contentAlignment;
@property (nonatomic, strong) TFActionSheetItem *item;
@property (nonatomic, assign) BOOL hideTopLine; ///< 是否隐藏顶部线条

@end
