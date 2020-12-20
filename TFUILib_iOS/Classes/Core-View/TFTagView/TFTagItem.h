//
//  MKTagLabel.h
//  MKTagEditor
//
//  Created by milker on 16/5/12.
//  Copyright © 2016年 milker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFTagView.h"

@class TFTagLabel;

@interface TFTagItem : UIView
@property(nonatomic, strong) TFTagLabel *label;
@property(nonatomic, assign) TFTagStyle style;
@property(nonatomic) UIEdgeInsets padding;
@property(nonatomic, assign) id<TFTagViewDelegate> tagviewDelegate;
@property(nonatomic, copy) NSString *text;
@end

@interface TFTagLabel : UITextField<UITextFieldDelegate>
@property(nonatomic, assign) TFTagStyle style;
@property(nonatomic) UIEdgeInsets padding;
@property(nonatomic, assign) id<TFTagViewDelegate> tagviewDelegate;
- (void)deleteMe:(id)sender;
@end


@interface MKTabView : UIView

@end
