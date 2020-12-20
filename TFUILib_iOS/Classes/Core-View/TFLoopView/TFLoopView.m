//
//  TFLoopView.m
//  TFLoopView
//
//  Created by Daniel on 2020/7/8.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//

#import "TFLoopView.h"
#import "TFLoopViewCell.h"
#import "TFPageControl.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface TFLoopView () <UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) UIControl *pageControl;

@property (nonatomic, weak) UIImageView *backgroundImageView; // 当imageURLs为空时的背景图

@property (nonatomic, assign) NSInteger networkFailedRetryCount;

@end

@implementation TFLoopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initialization];
        [self setupcollectionView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialization];
    [self setupcollectionView];
}

- (void)initialization
{
    _pageControlAliment            = TFLoopViewPageContolAlimentCenter;
    _autoScrollTimeInterval        = 2.0;
    _titleLabelTextColor           = [UIColor whiteColor];
    _titleLabelTextFont            = [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor     = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight              = 30;
    _autoScroll                    = YES;
    _infiniteLoop                  = YES;
    _showPageControl               = YES;
    _pageControlDotSize            = CGSizeMake(10, 10);
    _pageControlStyle              = TFLoopViewPageContolStyleClassic;
    _hidesForSinglePage            = YES;
    _currentPageDotColor           = [UIColor whiteColor];
    _pageDotColor                  = [UIColor lightGrayColor];
    _bannerViewContentMode    = UIViewContentModeScaleToFill;
    
    _pageControlDistanceFormBottom = 10;
    
    self.backgroundColor = [UIColor lightGrayColor];
    
}

+ (instancetype)loopViewWithFrame:(CGRect)frame viewGroup:(NSArray *)viewGroup placeholderImage:(UIImage *)placeholderImage delegate:(id<TFLoopViewDelegate>)delegate
{
    TFLoopView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.delegate = delegate;
    cycleScrollView.viewGroup = [NSMutableArray arrayWithArray:viewGroup];
    cycleScrollView.placeholderImage = placeholderImage;
    
    return cycleScrollView;
}

+ (instancetype)loopViewWithFrame:(CGRect)frame viewGroup:(NSArray *)viewGroup placeholderImage:(UIImage *)placeholderImage block:(void(^)(NSInteger currentIndex))block
{
    TFLoopView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.clickItemOperationBlock = block;
    cycleScrollView.viewGroup = viewGroup;
    cycleScrollView.placeholderImage = placeholderImage;
    
    return cycleScrollView;
}

-(void)registerClass:(Class)cellClass
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (void)registerNib:(nullable Class)className
{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(className) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(className)];
}


// 设置显示图片的collectionView
- (void)setupcollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing                 = 0;
    flowLayout.scrollDirection                    = UICollectionViewScrollDirectionHorizontal;
    _flowLayout                                   = flowLayout;
    
    UICollectionView *collectionView              = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor                = [UIColor clearColor];
    collectionView.pagingEnabled                  = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator   = NO;
    collectionView.dataSource                     = self;
    collectionView.delegate                       = self;
    self.isNeedScroll = YES;
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    [self registerClass:[TFLoopViewCell class]];
}

#pragma mark - properties

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!self.backgroundImageView)
    {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:bgImageView belowSubview:self.collectionView];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
}

- (void)setPageControlDotSize:(CGSize)pageControlDotSize
{
    _pageControlDotSize = pageControlDotSize;
    [self setupPageControl];
    if ([self.pageControl isKindOfClass:[TFPageControl class]])
    {
        TFPageControl *pageContol = (TFPageControl *)_pageControl;
        pageContol.dotSize = pageControlDotSize;
    }
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    _pageControl.hidden = !showPageControl;
}

- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor
{
    _currentPageDotColor = currentPageDotColor;
    if ([self.pageControl isKindOfClass:[TFPageControl class]])
    {
        TFPageControl *pageControl = (TFPageControl *)_pageControl;
        pageControl.dotColor = currentPageDotColor;
    }
    else
    {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPageIndicatorTintColor = currentPageDotColor;
    }
}

- (void)setPageDotColor:(UIColor *)pageDotColor
{
    _pageDotColor = pageDotColor;
    
    if ([self.pageDotColor isKindOfClass:[UIPageControl class]])
    {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.pageIndicatorTintColor = pageDotColor;
    }
}

- (void)setCurrentPageDotImage:(UIImage *)currentPageDotImage
{
    _currentPageDotImage = currentPageDotImage;
    
    [self setCustomPageControlDotImage:currentPageDotImage isCurrentPageDot:YES];
}

- (void)setPageDotImage:(UIImage *)pageDotImage
{
    _pageDotImage = pageDotImage;
    
    [self setCustomPageControlDotImage:pageDotImage isCurrentPageDot:NO];
}

- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPageDot:(BOOL)isCurrentPageDot
{
    if (!image || !self.pageControl) return;
    
    if ([self.pageControl isKindOfClass:[TFPageControl class]])
    {
        TFPageControl *pageControl = (TFPageControl *)_pageControl;
        pageControl.dotSize = _pageControlDotSize;
        if (isCurrentPageDot)
        {
            pageControl.currentDotImage = image;
        }
        else
        {
            pageControl.dotImage = image;
        }
    }
    else
    {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        if (isCurrentPageDot)
        {
            [pageControl setValue:image forKey:@"_currentPageImage"];
        }
        else
        {
            [pageControl setValue:image forKey:@"_pageImage"];
        }
    }
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    
    if (self.viewGroup.count)
    {
        self.viewGroup = self.viewGroup;
    }
}

-(void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    [_timer invalidate];
    _timer = nil;
    
    if (_autoScroll)
    {
        [self setupTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

- (void)setPageControlStyle:(TFLoopViewPageContolStyle)pageControlStyle
{
    _pageControlStyle = pageControlStyle;
    
    [self setupPageControl];
}

- (void)setViewGroup:(NSArray *)viewGroup
{
    _viewGroup = viewGroup;
    
//    _totalItemsCount = self.infiniteLoop ? self.imagesGroup.count * 100 : self.imagesGroup.count;
    _totalItemsCount = _viewGroup.count;
    
    if (_viewGroup.count != 1)
    {
        self.collectionView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    }
    else
    {
        self.collectionView.scrollEnabled = NO;
    }
    
    [self setupPageControl];
    [self.collectionView reloadData];
}

#pragma mark - actions

- (void)setupPageControl
{
    if (_pageControl) [_pageControl removeFromSuperview]; // 重新加载数据时调整
    
    if ((self.viewGroup.count <= 1) && self.hidesForSinglePage)
    {
        return;
    }
    
    switch (self.pageControlStyle)
    {
        case TFLoopViewPageContolStyleAnimated:
        {
            TFPageControl *pageControl = [[TFPageControl alloc] init];
            pageControl.numberOfPages = self.viewGroup.count;
            pageControl.dotColor = self.currentPageDotColor;
            pageControl.userInteractionEnabled = NO;
            pageControl.dotSize = _pageControlDotSize;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
            
        case TFLoopViewPageContolStyleClassic:
        {
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            pageControl.numberOfPages = self.viewGroup.count;
            pageControl.currentPageIndicatorTintColor = self.currentPageDotColor;
            pageControl.pageIndicatorTintColor = self.pageDotColor;
            pageControl.userInteractionEnabled = NO;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
            
        default:
            break;
    }
    
    // 重设pagecontroldot图片
    self.currentPageDotImage = self.currentPageDotImage;
    self.pageDotImage = self.pageDotImage;
}

- (void)automaticScroll
{
    if (0 == _totalItemsCount) return;
    int currentIndex = _collectionView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    if (targetIndex == _totalItemsCount)
    {
        if (self.infiniteLoop)
        {
            targetIndex = 0;
        }
        else
        {
            return;
        }
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        return;
    }
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)clearCache
{
    [[self class] clearImagesCache];
}

+ (void)clearImagesCache
{
    [[[SDWebImageManager sharedManager] imageCache] clearWithCacheType:SDImageCacheTypeDisk completion:nil];
}

#pragma mark - life circles

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    
    _collectionView.frame = self.bounds;
    if (_collectionView.contentOffset.x == 0 &&  _totalItemsCount)
    {
        int targetIndex = 0;
//        if (self.infiniteLoop)
//        {
//            targetIndex = _totalItemsCount * 0.5;
//        }
//        else
//        {
//            targetIndex = 0;
//        }
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    CGSize size = CGSizeZero;
    if ([self.pageControl isKindOfClass:[TFPageControl class]])
    {
        TFPageControl *pageControl = (TFPageControl *)_pageControl;
        pageControl.dotSize = _pageControlDotSize;
        size = [pageControl sizeForNumberOfPages:self.viewGroup.count];
    }
    else
    {
        size = CGSizeMake(self.viewGroup.count * self.pageControlDotSize.width * 1.2, self.pageControlDotSize.height);
    }
    
    CGFloat x = (self.width - size.width) * 0.5;
    if (self.pageControlAliment == TFLoopViewPageContolAlimentRight)
    {
        x = self.collectionView.width - size.width - 10;
    }
    CGFloat y = self.collectionView.height - size.height - self.pageControlDistanceFormBottom;
    
    if ([self.pageControl isKindOfClass:[TFPageControl class]])
    {
        TFPageControl *pageControl = (TFPageControl *)_pageControl;
        pageControl.dotSize = _pageControlDotSize;
        [pageControl sizeToFit];
    }
    
    self.pageControl.frame = CGRectMake(x, y, size.width, size.height);
    self.pageControl.hidden = !_showPageControl;
    
    if (self.backgroundImageView)
    {
        self.backgroundImageView.frame = self.bounds;
    }
    
}

//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

#pragma mark - public actions


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TFLoopViewCell class]) forIndexPath:indexPath];
    
    long itemIndex = indexPath.item % self.viewGroup.count;
    id item = self.viewGroup[itemIndex];
    
    if ([item isKindOfClass:[UIView class]]) {
        [cell.containerView addSubview:item];
        
        [(TFView *)item masViewEqualToSuperViewWithInsets:UIEdgeInsetsZero];
    }
    
    if (_titlesGroup.count && itemIndex < _titlesGroup.count)
    {
        cell.title = _titlesGroup[itemIndex];
    }
    
    if (!cell.hasConfigured)
    {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight          = self.titleLabelHeight;
        cell.titleLabelTextColor       = self.titleLabelTextColor;
        cell.titleLabelTextFont        = self.titleLabelTextFont;
        cell.hasConfigured             = YES;
        cell.containerView.contentMode = self.bannerViewContentMode;
        cell.clipsToBounds             = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.delegate respondsToSelector:@selector(loopView:didSelectItemAtIndex:)])
    {
        [self.delegate loopView:self didSelectItemAtIndex:indexPath.item % self.viewGroup.count];
    }
    
    if (self.clickItemOperationBlock)
    {
        self.clickItemOperationBlock(indexPath.item % self.viewGroup.count);
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    scrollView.scrollEnabled = self.isNeedScroll;
    int itemIndex = (scrollView.contentOffset.x + self.collectionView.width * 0.5) / self.collectionView.width;
    if (!self.viewGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int indexOnPageControl = itemIndex % self.viewGroup.count;
    
    if ([self.pageControl isKindOfClass:[TFPageControl class]])
    {
        TFPageControl *pageControl = (TFPageControl *)_pageControl;
        pageControl.dotSize = _pageControlDotSize;
        pageControl.currentPage = indexOnPageControl;
    }
    else
    {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.currentPage = indexOnPageControl;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll)
    {
        [self setupTimer];
    }
    
    int itemIndex = (scrollView.contentOffset.x + self.collectionView.width * 0.5) / self.collectionView.width;
    int indexOnPageControl = itemIndex % self.viewGroup.count;
    if ([self.delegate respondsToSelector:@selector(loopView:didScrollToIndex:)])
    {
        [self.delegate loopView:self didScrollToIndex:indexOnPageControl];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (!self.viewGroup.count)
    {
        return; // 解决清除timer时偶尔会出现的问题
    }
    
    int itemIndex = (scrollView.contentOffset.x + self.collectionView.width * 0.5) / self.collectionView.width;
    int indexOnPageControl = itemIndex % self.viewGroup.count;
    if ([self.delegate respondsToSelector:@selector(loopView:didScrollToIndex:)])
    {
        [self.delegate loopView:self didScrollToIndex:indexOnPageControl];
    }
    
}


@end
