//
//  TFHeadFloatLayout.h
//  TFUILib
//
//  Created by Daniel on 16/3/4.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//
//  copy from https://github.com/HebeTienCoder/XLPlainFlowLayout
//

#import <UIKit/UIKit.h>

/// 一个像UITableView那样可以使得headView浮动的布局
@interface TFHeadFloatLayout : UICollectionViewFlowLayout

//默认为64.0, default is 64.0
@property (nonatomic, assign) CGFloat naviHeight;

@end
