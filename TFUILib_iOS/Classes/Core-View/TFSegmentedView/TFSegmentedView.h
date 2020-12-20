//
//  TFSegmentedView.h
//  Treasure
//
//  Created by xiayiyong on 15/12/11.
//  Copyright © daniel.xiaofei@gmail All rights reserved.
//

#import "TFView.h"
#import "TFSegmentedControl.h"

/**
 *  TFSegmentedView点击回调Block
 *
 *  @param title 标题
 *  @param index index
 */
typedef void (^TFSegmentedViewTouchBlock)(NSString*title, NSInteger index);

/**
 *  TFSegmentedView
 */
@interface TFSegmentedView : TFView<UIScrollViewDelegate>

@property(nonatomic,strong)TFSegmentedControl *tfSegmentedControl;


/**
 *  初始化TFSegmentedView
 *
 *  @param frame    尺寸
 *  @param titleArr 每个page对应title
 *  @param viewArr  每个page对应view  view  或者viewController
 *  @param block    按钮点击事件的回调
 *
 *  @return TFSegmentedView
 */
- (id)initWithFrame:(CGRect)frame
             titles:(NSArray *)titleArr
              views:(NSArray *)viewArr
              block:(TFSegmentedControlTouchBlock)block;

/**
 *  初始化TFSegmentedView
 *
 *  @param titleArr 每个page对应title
 *  @param viewArr  每个page对应view  view  或者viewController
 *  @param block    按钮点击事件的回调
 *
 *  @return TFSegmentedView
 */
- (id)initWithTitles:(NSArray *)titleArr
               views:(NSArray *)viewArr
               block:(TFSegmentedControlTouchBlock)block;



@end
