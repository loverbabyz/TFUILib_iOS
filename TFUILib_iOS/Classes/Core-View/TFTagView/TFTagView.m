//
//  tagView.m
//  MKTagEditor
//
//  Created by milker on 16/5/12.
//  Copyright © 2016年 milker. All rights reserved.
//

#import "TFTagView.h"
#import "TFTagItem.h"

#define kMKDefaultColor [UIColor colorWithRed:0.38 green:0.72 blue:0.91 alpha:1]
#define kMKTextColor [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1]

@interface TFTagView()<UITextFieldDelegate, TFTagViewDelegate>

@end

@implementation TFTagView

- (instancetype)init {
    self = [super init];
    [self initViews];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initViews];
}

- (void)initViews {
    // default style, you can set new style
    self.tagFontSize = 12;
    self.tagSpace = 10;
    self.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    self.tagTextPadding = UIEdgeInsetsMake(3, 5, 3, 5);
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(autoAddEdtingTag)]];
}

- (void)addTag:(NSString *)tag {
    if(!tag || [tag isEqual:[NSNull null]]) {
        return;
    }
    if([self isExistTag:tag]) {
        return;
    }
    CGRect frame = CGRectZero;
    if(self.subviews && self.subviews.count > 0) {
        frame = [self.subviews lastObject].frame;
    }
    TFTagItem *label = [self createTagWithStyle:(self.editable ? TFTagStyleEditable : TFTagStyleShow) tag:tag];
    label.frame = CGRectMake(frame.origin.x, frame.origin.y, label.frame.size.width, label.frame.size.height);
    if(self.editable) {
        [self insertSubview:label belowSubview:[self.subviews lastObject]];
    } else {
        [self addSubview:label];
    }
}

- (void)addTags:(NSArray *)tags {
    for(NSString *tag in tags) {
        [self addTag:tag];
    }
}

- (void)removeTag:(NSString *)tagString {
    for(TFTagLabel *tag in self.subviews) {
        if([self stringIsEquals:tag.text to:tagString]) {
            [tag removeFromSuperview];
            
            if ([self.delegate respondsToSelector:@selector(tagView:onRemove:)]) {
                [self.delegate tagView:self onRemove:tag];
            }
        }
    }
}

- (void)removeTags:(NSArray *)tags {
    for(NSString *tag in tags) {
        [self removeTag:tag];
    }
}

- (void)selectTag:(NSString *)tag {
    [self.subviews indexOfObjectWithOptions:NSEnumerationConcurrent passingTest:^BOOL(TFTagItem *obj, NSUInteger idx, BOOL *stop) {
        if([self stringIsEquals:obj.text to:tag]) {
            [obj setStyle:self.editable ? TFTagStyleEditSelected : TFTagStyleShowSelected];
            return YES;
        }
        return NO;
    }];
}

- (void)selectTags:(NSArray *)tags {
    for(NSString *tag in tags) {
        [self selectTag:tag];
    }
}

- (void)unSelectTag:(NSString *)tag {
    [self.subviews indexOfObjectWithOptions:NSEnumerationConcurrent passingTest:^BOOL(TFTagLabel *obj, NSUInteger idx, BOOL *stop) {
        if([self stringIsEquals:obj.text to:tag]) {
            [obj setStyle:self.editable ? TFTagStyleEditable : TFTagStyleShow];
            return YES;
        }
        return NO;
    }];
}

- (void)unSelectTags:(NSArray *)tags {
    for(NSString *tag in tags) {
        [self unSelectTag:tag];
    }
}

- (void)setEditable:(BOOL)editable {
    if(_editable == editable) {
        return;
    }
    _editable = editable;
    
    // update sub tags style
    for(TFTagItem *tagItem in self.subviews) {
        [tagItem setStyle:_editable ? TFTagStyleEditable : TFTagStyleShow];
    }
    
    if(_editable) {
        TFTagItem *v = [self.subviews lastObject];
        if(!v || v.style != TFTagStyleEditing) {
            // if has no edit style tag, add one
            TFTagItem *label = [self createTagWithStyle:TFTagStyleEditing tag:@"输入标签"];
            label.label.placeholder = @"输入标签";
            label.text = nil;
            [self addSubview:label];
        }
    } else {
        TFTagLabel *v = [self.subviews lastObject];
        if(v && v.style == TFTagStyleEditing) {
            [v removeFromSuperview];
        }
    }
}

- (TFTagItem *)createTagWithStyle:(TFTagStyle)style tag:(NSString *)tag {
    TFTagItem *label = [[TFTagItem alloc] init];
    label.tagviewDelegate = self;
    label.padding = self.tagTextPadding;
    label.text = tag;
    label.label.font = [UIFont systemFontOfSize:self.tagFontSize];
    [label sizeToFit];
    [label setStyle:style];
    return label;
}


- (void)layoutSubviews {
    [UIView beginAnimations:nil context:nil];
    CGFloat paddingRight = self.padding.right;
    CGFloat cellspace = self.tagSpace;
    CGFloat y = self.padding.top;
    CGFloat x = self.padding.left;
    CGRect frame;
    for(UIView *tag in self.subviews) {
        frame = tag.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        
        if(frame.origin.x + frame.size.width + paddingRight > self.frame.size.width) {
            // 换行
            frame.origin.x = self.padding.left;
            frame.origin.y = frame.origin.y + frame.size.height + cellspace;
            
            y = frame.origin.y;
        }
        
        if(frame.origin.x + frame.size.width > self.frame.size.width - paddingRight) {
            frame.size.width = self.frame.size.width - paddingRight - frame.origin.x;
        }
        
        x = frame.origin.x + frame.size.width + cellspace;
        tag.frame = frame;
    }
    CGFloat containerHeight = frame.origin.y + frame.size.height + self.padding.bottom;
    CGRect containerFrame = self.frame;
    containerFrame.size.height = containerHeight;
    self.frame = containerFrame;
    if([self.delegate respondsToSelector:@selector(tagView:sizeChange:)]) {
        [self.delegate tagView:self sizeChange:self.frame];
    }
    [UIView commitAnimations];
}

- (NSArray *)allTags {
    NSMutableArray *tags = [NSMutableArray arrayWithCapacity:self.subviews.count];
    for(TFTagItem *tagItem in self.subviews) {
        if(tagItem.style != TFTagStyleEditing) {
            [tags addObject:tagItem.text];
        }
    }
    return tags;
}

- (void)autoAddEdtingTag {
    TFTagItem *tag = [self.subviews lastObject];
    if(tag.style == TFTagStyleEditing) {
        NSString *tagString = tag.text;
        if(!tagString || [tagString isEqual:[NSNull null]]) {
            [self addTag:tagString];
            tag.text = nil;
        }
    }
}

#pragma mark - self delegate

// default style, if user don't implement style deledate
- (void)tagView:(TFTagView *)tag editableStyle:(TFTagLabel *)tagLabel {
    if([self.delegate respondsToSelector:@selector(tagView:editableStyle:)]) {
        [self.delegate tagView:self editableStyle:tagLabel];
    } else {
        tagLabel.backgroundColor = [UIColor whiteColor];
        tagLabel.textColor = kMKDefaultColor;
        tagLabel.layer.borderColor = [kMKDefaultColor CGColor];
        tagLabel.layer.borderWidth = 1;
        tagLabel.layer.cornerRadius = tagLabel.frame.size.height / 2;
    }
}
- (void)tagView:(TFTagView *)tag editingStyle:(TFTagLabel *)tagLabel {
    if([self.delegate respondsToSelector:@selector(tagView:editingStyle:)]) {
        [self.delegate tagView:self editingStyle:tagLabel];
    } else {
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.textColor = [UIColor blackColor];
        tagLabel.layer.borderColor = [[UIColor clearColor] CGColor];
        tagLabel.layer.borderWidth = 0;
        tagLabel.layer.cornerRadius = 0;
    }
}
- (void)tagView:(TFTagView *)tag editSelectedStyle:(TFTagLabel *)tagLabel {
    if([self.delegate respondsToSelector:@selector(tagView:editSelectedStyle:)]) {
        [self.delegate tagView:self editSelectedStyle:tagLabel];
    } else {
        tagLabel.backgroundColor = kMKDefaultColor;
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.layer.borderColor = [kMKDefaultColor CGColor];
        tagLabel.layer.borderWidth = 1;
        tagLabel.layer.cornerRadius = tagLabel.frame.size.height / 2;
    }
}
- (void)tagView:(TFTagView *)tag showSelectedStyle:(TFTagLabel *)tagLabel {
    if([self.delegate respondsToSelector:@selector(tagView:showSelectedStyle:)]) {
        [self.delegate tagView:self showSelectedStyle:tagLabel];
    } else {
        tagLabel.backgroundColor = kMKDefaultColor;
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.layer.borderColor = [kMKDefaultColor CGColor];
        tagLabel.layer.borderWidth = 1;
        tagLabel.layer.cornerRadius = tagLabel.frame.size.height / 2;
    }
}
- (void)tagView:(TFTagView *)tag showStyle:(TFTagLabel *)tagLabel {
    if([self.delegate respondsToSelector:@selector(tagView:showStyle:)]) {
        [self.delegate tagView:self showStyle:tagLabel];
    } else {
        tagLabel.backgroundColor = [UIColor whiteColor];
        tagLabel.textColor = kMKTextColor;
        tagLabel.layer.borderColor = [kMKTextColor CGColor];
        tagLabel.layer.borderWidth = 1;
        tagLabel.layer.cornerRadius = 10;
    }
}
// default style end

- (void)tagView:(TFTagView *)tag deleteOnEmpty:(TFTagLabel *)tagLabel {
    if(self.subviews.count == 1) {
        return;
    }
    TFTagLabel *selectedTag = [self.subviews objectAtIndex:self.subviews.count - 2];
    if(selectedTag.style == TFTagStyleEditable) {
        selectedTag.style = TFTagStyleEditSelected;
    } else if(selectedTag.style == TFTagStyleEditSelected) {
        NSString *tagString = selectedTag.text;
        [self removeTag:tagString];
        if([self.delegate respondsToSelector:@selector(tagView:onRemove:)]) {
            [self.delegate tagView:self onRemove:tagLabel];
        }
    }
}

- (void)tagView:(TFTagView *)tagview returnOnNotEmpty:(TFTagLabel *)tagLabel {
    [self autoAddEdtingTag];
}

- (void)tagView:(TFTagView *)tagview onSelect:(TFTagLabel *)tagLabel {
    if([self.delegate respondsToSelector:@selector(tagView:onSelect:)]) {
        [self.delegate tagView:self onSelect:tagLabel];
    }
}

- (void)tagView:(TFTagView *)tagview onRemove:(TFTagLabel *)tagLabel {
    [self removeTag:tagLabel.text];
    if([self.delegate respondsToSelector:@selector(tagView:onRemove:)]) {
        [self.delegate tagView:self onRemove:tagLabel];
    }
}

#pragma mark - Tool Functions

- (BOOL)isExistTag:(NSString *)tag {
    if(!self.subviews || self.subviews.count == 0) {
        return NO;
    }
    __block BOOL isExist = NO;
    NSUInteger len = self.editable ? (self.subviews.count - 1) : self.subviews.count;
    [[self.subviews subarrayWithRange:NSMakeRange(0, len)] indexOfObjectWithOptions:NSEnumerationConcurrent passingTest:^BOOL(TFTagLabel *obj, NSUInteger idx, BOOL *stop) {
        isExist = [self stringIsEquals:obj.text to:tag];
        return isExist;
    }];
    return isExist;
}

- (BOOL)stringIsEquals:(NSString *)string to:(NSString *)string2 {
    return [string isEqualToString:string2];
}

@end
