//
//  MKTagView.h
//  MKTagEditor
//
//  Created by milker on 16/5/12.
//  Copyright © 2016年 milker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFTagView;
@class TFTagLabel;

typedef NS_ENUM(NSInteger, TFTagStyle) {
    TFTagStyleEditable,     // tag editor can edit, normal status
    TFTagStyleEditing,      // tag editor can edit, input status
    TFTagStyleEditSelected, // tag editor can edit, select status
    TFTagStyleShow,         // tag editor can't edit, normal status
    TFTagStyleShowSelected  // tag editor can't edit, select stauts
};

@protocol TFTagViewDelegate <NSObject>
@optional
// tagview size changed
- (void)tagView:(TFTagView *)tagview sizeChange:(CGRect)newSize;
// onselect tag, use tagLabel.style to judge label status
- (void)tagView:(TFTagView *)tagview onSelect:(TFTagLabel *)tagLabel;
// onremove a tag from tag view
- (void)tagView:(TFTagView *)tagview onRemove:(TFTagLabel *)tagLabel;

// custome label style
// TFTagView can edit, normal style
- (void)tagView:(TFTagView *)tagview editableStyle:(TFTagLabel *)tagLabel;
// TFTagView can edit, editing style
- (void)tagView:(TFTagView *)tagview editingStyle:(TFTagLabel *)tagLabel;
// TFTagView can edit, selected style
- (void)tagView:(TFTagView *)tagview editSelectedStyle:(TFTagLabel *)tagLabel;
// TFTagView can't edit, normal style
- (void)tagView:(TFTagView *)tagview showStyle:(TFTagLabel *)tagLabel;
// TFTagView can't edit, selected style
- (void)tagView:(TFTagView *)tagview showSelectedStyle:(TFTagLabel *)tagLabel;

// tag is empty & keyboard press DELETE, !!don't rewrite!!
- (void)tagView:(TFTagView *)tagview deleteOnEmpty:(TFTagLabel *)tagLabel;
// tag not empty & keyboard press RETURN !!don't rewrite!!
- (void)tagView:(TFTagView *)tagview returnOnNotEmpty:(TFTagLabel *)tagLabel;
@end

#pragma mark - MKTagView

@interface TFTagView : UIView

@property(nonatomic, assign) BOOL editable;// default is false, if true, editor has a input label, can delete
@property(nonatomic, assign) CGFloat tagSpace;// space between two tag, default is 10
@property(nonatomic, assign) CGFloat tagFontSize; // default is 12
@property(nonatomic) UIEdgeInsets padding; // container inner spacing, default is {10, 10, 10, 10}
@property(nonatomic) UIEdgeInsets tagTextPadding; // tag text inner spaces, default is {3, 5, 3, 5}

@property(nonatomic, assign) id<TFTagViewDelegate> delegate;

- (void)addTag:(NSString *)tag;
- (void)addTags:(NSArray *)tags;

- (void)removeTag:(NSString *)tag;
- (void)removeTags:(NSArray *)tags;

- (void)selectTag:(NSString *)tag;
- (void)selectTags:(NSArray *)tags;

- (void)unSelectTag:(NSString *)tag;
- (void)unSelectTags:(NSArray *)tags;

// you can monitor viewcontroller's view's tab event, call this function, and auto add the editing tag
- (void)autoAddEdtingTag;
- (NSArray *)allTags;

@end
