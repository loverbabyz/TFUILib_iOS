//
//  Created by xiayiyong on 16/3/29.
//  含开关的cell
//
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TFTableViewCell.h"

@interface TFLabelSwitchCell : TFTableViewCell

//标签
@property (nonatomic,strong) UILabel *label;
//开关
@property (nonatomic,strong) UISwitch *switcher;

@end
