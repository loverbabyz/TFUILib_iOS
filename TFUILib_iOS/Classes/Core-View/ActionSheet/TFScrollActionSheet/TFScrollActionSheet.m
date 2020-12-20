//
//  TFScrollActionSheet.m
//  TFScrollActionSheet
//
//  Created by xiayiyong on 12/27/14.
//  Copyright (c) 2014 xiayiyong. All rights reserved.
//

#import "TFScrollActionSheet.h"

static CGFloat horizontalMargin = 20.0;

@interface TFScrollActionSheet ()

@property (nonatomic, assign) CGRect         screenRect;
@property (nonatomic, strong) UIWindow       *window;
@property (nonatomic, strong) UIView         *dimBackground;
@property (nonatomic, copy  ) NSArray        *actions;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *handlers;

@property (nonatomic, copy) void(^dismissHandler)(void);

@end

@implementation TFScrollActionSheet

- (instancetype)initWithCancelButtonTitle:(NSString*)cancelButtonTitle items:(NSArray *)actions
{
    self = [super init];
    if (self) {
        _screenRect = [UIScreen mainScreen].bounds;
        if ([[UIDevice currentDevice].systemVersion floatValue] < 7.5 &&
            UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
        {
            _screenRect = CGRectMake(0, 0, _screenRect.size.height, _screenRect.size.width);
        }
        _actions = actions;
        _buttons = [NSMutableArray array];
        _handlers = [NSMutableArray array];
        _dimBackground = [[UIView alloc] initWithFrame:_screenRect];
        _dimBackground.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_dimBackground addGestureRecognizer:gr];
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    
        //cal frame
        NSInteger rowCount = _actions.count;
        CGFloat height = 0.0;
        for (int i = 0; i < rowCount; i++)
        {
            if ([_actions[i] isKindOfClass:[NSString class]])
            {
                if ([_actions[i] isEqualToString:@""])
                {
                    height += 20;
                }
                else
                {
                    height += 40;
                }
            }
            else
            {
                height = height+60+30;
            }
        }
        height += 60;
        self.frame = CGRectMake(0, _screenRect.size.height, _screenRect.size.width, height);
        
        //add each row
        CGFloat y = 0.0;
        for (int i = 0; i < rowCount; i++)
        {
            if ([_actions[i] isKindOfClass:[NSString class]])
            {
                //title
                if ([_actions[i] isEqualToString:@""])
                {
                    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(0, y, _screenRect.size.width, 20.0)];
                    [self addSubview:marginView];
                    y+=20;
                }
                else
                {
                    UILabel *rowTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, y, _screenRect.size.width, 40.0)];
                    rowTitle.font = [UIFont systemFontOfSize:14.0];
                    rowTitle.text = _actions[i];
                    rowTitle.textAlignment = NSTextAlignmentCenter;
                    [self addSubview:rowTitle];
                    y+=40;
                }
            }
            else
            {
                NSArray *items = _actions[i];
                UIScrollView *rowContainer = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, _screenRect.size.width, 90)];
                rowContainer.directionalLockEnabled = YES;
                rowContainer.showsHorizontalScrollIndicator = NO;
                rowContainer.showsVerticalScrollIndicator = NO;
                rowContainer.contentSize = CGSizeMake(items.count*80+20, 90);
                [self addSubview:rowContainer];
                
                CGFloat x = horizontalMargin;
                for (int j = 0; j < items.count; j++)
                {
                    TFScrollActionSheetItem *action = items[j];
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(x, 0, 60, 60);
                    [button setImage:[UIImage imageNamed:action.icon] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(handlePress:) forControlEvents:UIControlEventTouchUpInside];
                    [rowContainer addSubview:button];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 60, 60, 30)];
                    label.text = action.title;
                    label.font = [UIFont systemFontOfSize:13.0];
                    label.textAlignment = NSTextAlignmentCenter;
                    [rowContainer addSubview:label];
                    x = x + 60 + horizontalMargin;
                    
                    [_buttons addObject:button];
                    [_handlers addObject:action.handler];
                }
                
                y+=90;
                UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, y, _screenRect.size.width,0.5)];
                separator.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:separator];
            }
        }
        
        //add cancel button
        UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
        cancel.frame = CGRectMake(0, y, _screenRect.size.width, 60);
        [cancel setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancel.titleLabel.font = [UIFont systemFontOfSize:20];
        cancel.backgroundColor = [UIColor whiteColor];
        [self addSubview:cancel];
        [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)handlePress:(UIButton *)button
{
    NSInteger index = [self.buttons indexOfObject:button];
    if (index < self.buttons.count)
    {
        void(^handler)(void) = self.handlers[index];
        handler();
    }
    [self dismiss];
}

- (void)show
{
    self.window = [[UIWindow alloc] initWithFrame:self.screenRect];
    self.window.windowLevel = UIWindowLevelAlert;
    self.window.backgroundColor = [UIColor clearColor];
    self.window.rootViewController = [UIViewController new];
    self.window.rootViewController.view.backgroundColor = [UIColor clearColor];
    
    [self.window.rootViewController.view addSubview:self.dimBackground];
    
    [self.window.rootViewController.view addSubview:self];
    
    self.window.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.dimBackground.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        self.frame = CGRectMake(0, self.screenRect.size.height-self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        //
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        self.dimBackground.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, self.screenRect.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        self.window = nil;
    }];
}

@end

@implementation TFScrollActionSheetItem

- (instancetype)initWithTitle:(NSString *)title
                         icon:(NSString *)icon
                      handler:(void(^)(void))handler{
    self = [super init];
    if (self) {
        _title = title;
        _icon = icon;
        _handler = handler;
    }
    return self;
}

@end
