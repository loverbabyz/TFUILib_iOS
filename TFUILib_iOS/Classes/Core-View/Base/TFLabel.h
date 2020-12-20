//
//  TFLabel.h
//  TFUILib
//
//  Created by xiayiyong on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    /**
     *  水平顶端对齐
     */
    TFLabelVerticalTextAlignmentTop = UIControlContentVerticalAlignmentTop,
    
    /**
     *  水平居中对齐
     */
    TFLabelVerticalTextAlignmentMiddle = UIControlContentVerticalAlignmentCenter,
    
    /**
     *  水平底对齐
     */
    TFLabelVerticalTextAlignmentBottom = UIControlContentVerticalAlignmentBottom
} TFLabelVerticalTextAlignment;

@interface TFLabel : UILabel

@property (nonatomic, assign) TFLabelVerticalTextAlignment verticalTextAlignment;

@property (nonatomic, assign) UIEdgeInsets textEdgeInsets;

@end
