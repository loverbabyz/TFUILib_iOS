//
//  TFCollectionView.m
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFCollectionView.h"

@implementation TFCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor                 = [UIColor whiteColor];
        self.backgroundView                  = UIView.new;
        
        [self setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        self.showsVerticalScrollIndicator    = NO;
        self.showsHorizontalScrollIndicator  = NO;
        self.allowsMultipleSelection         = YES;
    }
    
    return self;
}

-(void)registerCell:(Class)cellClass
{
    [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

-(void)registerHeaderClass:(Class)cellClass
{
    [self registerClass:cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(cellClass)];
}

-(void)registerFooterClass:(Class)cellClass
{
    [self registerClass:cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNib:(nullable Class)className {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(className)];
}

- (void)registerHeaderNib:(nullable Class)className {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(className)];
}

- (void)registerFooterNib:(nullable Class)className {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(className)];
}

@end
