//
//  TFSegmentedView.m
//  Treasure
//
//  Created by Daniel on 15/12/11.
//  Copyright © daniel.xiaofei@gmail All rights reserved.
//

#import "TFSegmentedView.h"

#import "TFMasonry.h"

@interface TFSegmentedView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *viewArr;

@property (nonatomic, assign) NSInteger currentPage;
/**
 *  TFSegmentedControl点击回调Block
 */
@property (nonatomic, strong) TFSegmentedControlTouchBlock block;

@end

@implementation TFSegmentedView

#pragma mark ---init

- (id)initWithTitles:(NSArray *)titleArr
               views:(NSArray *)viewArr
               block:(TFSegmentedViewTouchBlock)block
{
    if (self = [self initWithFrame:CGRectMake(0, 0, TF_SCREEN_WIDTH, 44)
                            titles:titleArr
                             views:viewArr
                             block:block])
    {
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
             titles:(NSArray *)titleArr
              views:(NSArray *)viewArr
              block:(TFSegmentedViewTouchBlock)block
{
    if (self = [super initWithFrame:frame])
    {
        
        self.block = block;
         __weak __typeof(&*self)weakSelf = self;
        self.tfSegmentedControl = [[TFSegmentedControl alloc]initWithFrame:frame titles:titleArr block:^(NSString *title, NSInteger index) {
           
            if(index != weakSelf.currentPage)
            {
                [weakSelf.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width*index, 0) animated:YES];
            }

        }];
        [self addSubview:self.tfSegmentedControl];
        self.viewArr  = [self createViewArr:viewArr];
        [self initViews];
        [self autolayoutViews];
        [self bindData];
    }
    
    return self;
}


- (void) initViews
{
    self.clipsToBounds=YES;
    
    self.scrollView                 = [UIScrollView new];
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.delegate        = self;
    self.scrollView.pagingEnabled   = YES;
    self.scrollView.bounces         = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];

}

-(void)autolayoutViews
{
     __weak __typeof(&*self)weakSelf = self;
        // 下面的滚动视图
    [self.scrollView tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
            make.left.equalTo(weakSelf.tf_mas_left);
            make.top.equalTo(weakSelf.tfSegmentedControl.tf_mas_bottom);
            make.bottom.equalTo(weakSelf.tf_mas_bottom);
            make.width.equalTo(weakSelf.tf_mas_width);
    }];
        
    [self horizontalWidthViews:self.viewArr inScrollView:self.scrollView];

}

-(void)bindData
{
    
}


#pragma mark ---UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    self.currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self.tfSegmentedControl select:self.currentPage];
     //告诉self.view约束需要更新
    [self setNeedsUpdateConstraints];
    
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [self layoutIfNeeded];
    }];
    
}



-(NSMutableArray*)createViewArr:(NSArray*)arr
{
    NSMutableArray *tmpArr = [[NSMutableArray alloc]init];

    NSInteger count = arr.count;
    for (int i = 0; i < count; i ++)
    {
        id obj = arr[i];
        if ([obj isKindOfClass:[UIView class]])
        {
            [tmpArr addObject:obj];
        }
        else if ([obj isKindOfClass:[UIViewController class]])
        {
            [tmpArr addObject:((UIViewController*)obj).view];
        }
    }
    
    return tmpArr;
}



#pragma mark ---commonn method

/**
 *  将若干view等宽布局于容器containerView中
 *
 *  @param views         viewArray
 *  @param containerView 容器view
 *  @param containerPadding     距容器的左右边距
 *  @param viewPadding   各view的左右边距
 */
-(void)horizontalWidthViews:(NSArray *)views inView:(UIView *)containerView viewPadding:(CGFloat)viewPadding containerPadding:(CGFloat)containerPadding
{
    UIView *lastView;
    for (UIView *view in views)
    {
        [containerView addSubview:view];
        if (lastView)
        {
            [view tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                
                make.top.bottom.equalTo(containerView);
                make.left.equalTo(lastView.tf_mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }
        else
        {
            [view tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
                
                make.left.equalTo(containerView).offset(containerPadding);
                make.top.bottom.equalTo(containerView);
            }];
        }
        lastView=view;
    }
    
    [lastView tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        
        make.right.equalTo(containerView).offset(-containerPadding);
    }];
}

-(void)horizontalWidthViews:(NSArray *)views inScrollView:(UIScrollView *)scrollView
{
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.height.equalTo(scrollView);
    }];
    
    NSInteger count = views.count;
    
    UIView *lastView = nil;
    
    for ( int i = 0 ; i < count ; ++ i )
    {
        UIView *subv = views[i];
        [container addSubview:subv];
        subv.backgroundColor = [UIColor randomColor];
        
        [subv tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
            
            make.top.and.bottom.equalTo(container);
            make.width.mas_equalTo(scrollView.tf_mas_width);
            
            if ( lastView )
            {
                make.left.mas_equalTo(lastView.tf_mas_right);
            }
            else
            {
                make.left.mas_equalTo(container.tf_mas_left);
            }
            
        }];
        
        lastView = subv;
        
    }
    
    [container tf_mas_makeConstraints:^(TFMASConstraintMaker *make) {
        make.right.equalTo(lastView.tf_mas_right);
    }];
}

@end
