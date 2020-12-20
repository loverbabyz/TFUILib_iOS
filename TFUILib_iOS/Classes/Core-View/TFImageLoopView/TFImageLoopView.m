//
//  TFImageLoopView.m
//  TFImageLoopView
//
//  Created by Daniel on 2020/7/8.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//

#import "TFImageLoopView.h"
#import "TFImageLoopViewCell.h"
#import "UIImageView+Placeholder.h"

@interface TFImageLoopView ()

@end

@implementation TFImageLoopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self registerClass:[TFImageLoopViewCell class]];
    }
    
    return self;
}

/**
 *  初始轮播图（推荐使用）
 *
 *  @param frame            轮播视图大小
 *  @param block            回调
 *  @param placeholderImage 占位图片
 *
 *  @return 轮播视图
 */
+ (instancetype)loopViewWithFrame:(CGRect)frame
                 imagesGroup:(NSArray *)imagesGroup
                            block:(void(^)(NSInteger currentIndex))block
{
    TFImageLoopView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.clickItemOperationBlock = block;
    cycleScrollView.imagesGroup = imagesGroup;
    
    return cycleScrollView;

}

/**
 *  初始轮播图（推荐使用）
 *
 *  @param frame            轮播视图大小
 *  @param block            回调
 *  @param placeholderImage 占位图片
 *
 *  @return 轮播视图
 */
+ (instancetype)loopViewWithFrame:(CGRect)frame
                 placeholderImage:(UIImage *)placeholderImage
                            block:(void(^)(NSInteger currentIndex))block
{
    TFImageLoopView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.clickItemOperationBlock = block;
    cycleScrollView.placeholderImage = placeholderImage;
    
    return cycleScrollView;

}

- (void)setImagesGroup:(NSArray *)imagesGroup {
    _imagesGroup = imagesGroup;
    
    self.viewGroup = _imagesGroup;
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFImageLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TFImageLoopViewCell class]) forIndexPath:indexPath];
    
    long itemIndex = indexPath.item % self.viewGroup.count;
    id item = self.viewGroup[itemIndex];
    
    if ([item isKindOfClass:[NSString class]])
    {
        [cell.imageView setImageWithName:item placeholderImage:nil];
    }
    else if ([item isKindOfClass:[UIImage class]])
    {
        cell.imageView.image = (UIImage *)item;
    }
    
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    if (self.titlesGroup.count && itemIndex < self.titlesGroup.count)
    {
        cell.title = self.titlesGroup[itemIndex];
    }
    
    if (!cell.hasConfigured)
    {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight          = self.titleLabelHeight;
        cell.titleLabelTextColor       = self.titleLabelTextColor;
        cell.titleLabelTextFont        = self.titleLabelTextFont;
        cell.hasConfigured             = YES;
        cell.imageView.contentMode     = self.bannerViewContentMode;
        cell.clipsToBounds             = YES;
    }
    
    return cell;
}
@end
