//
//  TFImageAlertView.m
//  Treasure
//
//  Created by Daniel on 16/1/21.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFImageAlertView.h"
#import "UIImageView+Placeholder.h"

#import <Masonry/Masonry.h>
#import <TFBaseLib_iOS/TFBaseMacro+System.h>

/**
 显示和隐藏动画持续时间
 */
#define ANIMATION_DURATION_TIME 0.3

/**
容器左右padding
 */
#define LEFT_RIGHT_PADDING 30

@interface TFImageAlertView ()

@property (nonatomic, strong) TFImageAlertViewBlock block;

@property (nonatomic, strong) UIButton *maskView;

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *spaceView;

@property (nonatomic, strong) UIImageView *descImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *buttonContainerView;

@property (nonatomic, strong) NSMutableArray *buttonArr;

@property (nonatomic, strong) NSMutableArray *lineArr;

@property (nonatomic, assign) CGFloat lineHeight;

@property (nonatomic, strong) UIColor *lineColor;

@end

@implementation TFImageAlertView

+ (void)showWithTitle:(NSString*)title
              message:(NSString*)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                block:(TFImageAlertViewBlock)block
{
    TFImageAlertView *view = [[TFImageAlertView alloc]initWithTitle:title
                                                            message:message
                                                  cancelButtonTitle:cancelButtonTitle
                                                  otherButtonTitles:otherButtonTitles
                                                              block:block];
    [view show:^(BOOL finished) {
        
    }];
}

+ (void)showWithTitle:(NSString*)title
              message:(NSString*)message
         buttonTitles:(NSArray *)buttonTitles
                block:(TFImageAlertViewBlock)block
{
    TFImageAlertView *view = [[TFImageAlertView alloc]initWithTitle:title
                                                            message:message
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:buttonTitles
                                                              block:block];
    [view show:^(BOOL finished) {
        
    }];
}

+ (void)showWithTitle:(NSString*)title
                image:(NSString*)image
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                block:(TFImageAlertViewBlock)block
{
    TFImageAlertView *view=[[TFImageAlertView alloc]initWithTitle:title
                                                            image:image
                                                cancelButtonTitle:cancelButtonTitle
                                                otherButtonTitles:otherButtonTitles
                                                            block:block];
    [view show:^(BOOL finished) {
        
    }];
}

+ (void)showWithTitle:(NSString*)title
                image:(NSString*)image
    buttonTitles:(NSArray *)buttonTitles
                block:(TFImageAlertViewBlock)block
{
    TFImageAlertView *view=[[TFImageAlertView alloc]initWithTitle:title
                                                            image:image
                                                cancelButtonTitle:nil
                                                otherButtonTitles:buttonTitles
                                                            block:block];
    [view show:^(BOOL finished) {
        
    }];
}

- (id)initWithTitle:(NSString*)title
            message:(NSString*)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
              block:(TFImageAlertViewBlock)block
{
    self = [super initWithFrame:CGRectMake(0, 0, TF_SCREEN_WIDTH, TF_SCREEN_HEIGHT)];
    
    if (self)
    {
        self.lineColor= TF_HRGBA(0xe0e0e0, 1);
        self.lineHeight=1;
        
        self.frame = CGRectMake(0, 0, TF_SCREEN_WIDTH, TF_SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        
        self.clipsToBounds=YES;
        
        self.maskView = [[UIButton alloc] initWithFrame:self.frame];
        self.maskView.backgroundColor = TF_HRGBA(0X000008,0.5);
        [self.maskView addTarget:self action:@selector(dismissButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.maskView];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = TF_HRGBA(0xffffff, 1);
        self.alertView.layer.masksToBounds=YES;
        self.alertView.layer.cornerRadius=2;
        [self addSubview:self.alertView];
        
        self.titleLabel=[[UILabel alloc]init];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.text=title;
        self.titleLabel.font= TF_AppFont(20);
        self.titleLabel.textColor= TF_HRGBA(0x000000, 1);
        [self.alertView addSubview:self.titleLabel];
        
        self.messageLabel=[[UILabel alloc]init];
        self.messageLabel.textAlignment=NSTextAlignmentCenter;
        self.messageLabel.numberOfLines=0;
        self.messageLabel.text=message;
        self.messageLabel.font= TF_AppFont(18);
        self.messageLabel.textColor= TF_HRGBA(0x333333, 1);;
        [self.alertView addSubview:self.messageLabel];
        
        self.spaceView = [[UIView alloc] init];
        self.spaceView.backgroundColor = [UIColor clearColor];
        [self.alertView addSubview:self.spaceView];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = TF_HRGBA(0xdfdfdf, 1);
        [self.alertView addSubview:self.lineView];
        
        self.buttonContainerView = [[UIView alloc] init];
        self.buttonContainerView.backgroundColor = TF_HRGBA(0XEFEFF4,  1);
        [self.alertView addSubview:self.buttonContainerView];
        
        NSMutableArray *buttonTitles=[[NSMutableArray alloc]init];
        if (cancelButtonTitle!=nil)
        {
            [buttonTitles addObject:cancelButtonTitle];
        }
        
        for (NSString *item in otherButtonTitles)
        {
            [buttonTitles addObject:item];
        }
        
        self.buttonArr = [self createButtonArr:buttonTitles];
        self.lineArr = [self createLineArr:buttonTitles];
        
        [self autolayoutViews1];
        
        self.maskView.userInteractionEnabled=NO;

        self.block=block;
        
    }
    
    return self;
}

- (id)initWithTitle:(NSString*)title
              image:(NSString*)image
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)otherButtonTitles
              block:(TFImageAlertViewBlock)block
{
    self = [super initWithFrame:CGRectMake(0, 0, TF_SCREEN_WIDTH, TF_SCREEN_HEIGHT)];
    
    if (self)
    {
        self.lineColor  = TF_HRGBA(0X03A9F4,  1);
        self.lineHeight = 2;
        
        self.frame = CGRectMake(0, 0, TF_SCREEN_WIDTH, TF_SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        
        self.clipsToBounds=YES;
        
        self.maskView = [[UIButton alloc] initWithFrame:self.frame];
        self.maskView.backgroundColor = TF_HRGBA(0X000008,0.5);
        [self.maskView addTarget:self action:@selector(dismissButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.maskView];
        
        self.alertView = [[UIView alloc] init];
        self.alertView.backgroundColor = TF_HRGBA(0xffffff, 1);
        self.alertView.layer.masksToBounds=YES;
        self.alertView.layer.cornerRadius=2;
        [self addSubview:self.alertView];
        
        self.titleLabel=[[UILabel alloc]init];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.text=title;
        self.titleLabel.font= TF_AppFont(20);
        self.titleLabel.textColor= TF_HRGBA(0x000000, 1);
        [self.alertView addSubview:self.titleLabel];
        
        self.descImageView = UIImageView.new;
        self.descImageView.backgroundColor=[UIColor clearColor];
        [self.descImageView setImageWithName:image placeholderImage:nil];
        [self.alertView addSubview:self.descImageView];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = TF_HRGBA(0xdfdfdf, 1);
        [self.alertView addSubview:self.lineView];
        
        self.buttonContainerView = [[UIView alloc] init];
        self.buttonContainerView.backgroundColor = TF_HRGBA(0xffffff, 1);
        [self.alertView addSubview:self.buttonContainerView];
        
        NSMutableArray *buttonTitles=[[NSMutableArray alloc]init];
        if (cancelButtonTitle!=nil)
        {
            [buttonTitles addObject:cancelButtonTitle];
        }
        
        for (NSString *item in otherButtonTitles)
        {
            [buttonTitles addObject:item];
        }
        
        self.buttonArr = [self createButtonArr:buttonTitles];
        self.lineArr = [self createLineArr:buttonTitles];
        
        [self autolayoutViews2];
        
        self.block=block;
        
    }
    
    return self;
}

-(void)autolayoutViews1
{
    __weak __typeof(&*self)weakSelf = self;
    
    //alwertview
    // 上面的title
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(LEFT_RIGHT_PADDING);
        make.right.equalTo(weakSelf).offset(-LEFT_RIGHT_PADDING);
    }];
    
    // 上面的title
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.alertView).offset(10);
        make.right.equalTo(weakSelf.alertView);
        make.height.equalTo(@(44));
    }];
    
    // 上面的内容
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView).offset(20);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.alertView).offset(-20);;
        make.bottom.equalTo(weakSelf.spaceView.mas_top).offset(-10);
    }];
    
    // 中间的填充
    [self.spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.messageLabel.mas_bottom);
        make.right.equalTo(weakSelf.alertView);
        make.bottom.equalTo(weakSelf.lineView.mas_top);
    }];

    // 中间的线条
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.spaceView.mas_bottom);
        make.right.equalTo(weakSelf.alertView);
        make.height.equalTo(@(weakSelf.lineHeight));
    }];
    
    // 中间的线条
    [self.buttonContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.lineView.mas_bottom);
        make.right.equalTo(weakSelf.alertView);
        make.height.equalTo(@(60));
        make.bottom.equalTo(weakSelf.alertView);
    }];
    
    // 下面的按钮
    [self horizontalWidthViews:self.buttonArr inView:self.buttonContainerView viewPadding:0 containerPadding:0];
    
    [self horizontalWidthViews:self.lineArr inView:self.buttonContainerView];
}

-(void)autolayoutViews2
{
    __weak __typeof(&*self)weakSelf = self;
    
    //alwertview
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-20);
        make.height.greaterThanOrEqualTo(@(250));
    }];
    
    //alwertview 上面的title
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.alertView).offset(10);
        make.right.equalTo(weakSelf.alertView);
        make.height.equalTo(@(44));
    }];
    
    //alwertview 中间的imageview
    [self.descImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView).offset(10);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.alertView).offset(-10);
        make.bottom.equalTo(weakSelf.lineView.mas_top).offset(-10);
    }];
    
    //alwertview 中间的line
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.descImageView.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.alertView);
        make.height.equalTo(@(weakSelf.lineHeight));
    }];
    
    //alwertview 下面的button容器
    [self.buttonContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.alertView);
        make.top.equalTo(weakSelf.lineView.mas_bottom);
        make.right.equalTo(weakSelf.alertView);
        make.height.equalTo(@(60));
        make.bottom.equalTo(weakSelf.alertView);
    }];
    
    // 下面的按钮
    [self horizontalWidthViews:self.buttonArr inView:self.buttonContainerView viewPadding:0 containerPadding:0];
    
    [self horizontalWidthViews:self.lineArr inView:self.buttonContainerView];
}

-(void)bindData
{
    
}

#pragma mark -
#pragma mark show hide

- (void)show:(void (^)(BOOL finished))completion
{
    self.maskView.alpha = 0;
    [TF_APP_KEY_WINDOW addSubview:self];
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:ANIMATION_DURATION_TIME
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         weakSelf.maskView.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                         if (completion)
                         {
                             completion(finished);
                         }
                     }];
    
}

- (void)hide:(void (^)(BOOL finished))completion
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{}
                     completion:^(BOOL finished) {
                         weakSelf.maskView.alpha = 0;
                         [self removeFromSuperview];
                         if (completion)
                         {
                             completion(finished);
                         }
                     }];
    
}

-(NSMutableArray*)createButtonArr:(NSArray*)arr
{
    NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
    
    NSInteger count = arr.count;
    for (int i = 0; i < count; i ++)
    {
        UIButton *btn = UIButton.new;
        
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor: i==count-1 ? TF_HRGBA(0X0077DD,  1):TF_HRGBA(0X333333,  1) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageWithColor:TF_HRGBA(0xffffff, 1)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:TF_HRGBA(0xeeeeee, 1)] forState:UIControlStateHighlighted];
        btn.tag=i;
        btn.titleLabel.font = TF_AppFont(18);
        
        [tmpArr addObject:btn];
    }
    
    return tmpArr;
}

-(NSMutableArray*)createLineArr:(NSArray*)arr
{
    NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
    
    NSInteger count = arr.count;
    for (int i=0; i<count-1; i++)
    {
        UILabel *ln = UILabel.new;
        ln.backgroundColor = TF_HRGBA(0xededed, 1);
        [tmpArr addObject:ln];
    }
    
    return tmpArr;
}

-(void)clickButton:(UIButton*)sender
{
    __weak __typeof(&*self)weakSelf = self;
    [self hide:^(BOOL finished) {
        if (weakSelf.block)
        {
            weakSelf.block(sender.tag);
        }
        
    }];
}

-(void)dismissButtonClick
{
    [self hide:^(BOOL finished) {
        
    }];
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
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.bottom.equalTo(containerView);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }
        else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(containerView).offset(containerPadding);
                make.top.bottom.equalTo(containerView);
            }];
        }
        lastView=view;
    }
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(containerView).offset(-containerPadding);
    }];
}

-(void)horizontalWidthViews:(NSArray *)views inView:(UIView *)containerView
{
    // 中间的线条
    NSInteger count = views.count;
    
    CGFloat width=(TF_SCREEN_WIDTH-LEFT_RIGHT_PADDING*2)/(count+1);
    
    for (int i=0; i<count; i++)
    {
        UIView *view=views[i];
        [containerView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(width*(i+1)));
            make.top.equalTo(containerView);
            make.width.equalTo(@(1));
            make.bottom.equalTo(containerView);
        }];
    }
}

@end
