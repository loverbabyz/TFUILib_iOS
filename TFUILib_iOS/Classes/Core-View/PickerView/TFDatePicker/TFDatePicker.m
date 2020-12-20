//
//  TFDatePicker.m
//  Treasure
//
//  Created by xiayiyong on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFDatePicker.h"

#define BTN_WIDTH 70
#define BTN_HEIGHT 40
#define DATE_PICK_HEIGHT 220
#define ANIMATION_DURATION_TIME 0.3

@interface TFDatePicker ()

@property (nonatomic, strong) TFDatePickerBlock block;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *maskView;

@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIButton *okButton;

@property (nonatomic,strong) NSDate *currentDate;

@property (nonatomic,strong) NSString *currentDateString;

@end

@implementation TFDatePicker

+ (void)showWithType:(TFDatePickerType)type block:(TFDatePickerBlock)block
{
    TFDatePicker *view=[[TFDatePicker alloc]initWithType:type block:block];
    [view show:^(BOOL finished) {
        
    }];
}

+ (void)showWithType:(UIDatePickerMode)mode
             maxDate:(NSDate *)maxDate
             minDate:(NSDate *)minDate
         currentDate:(NSDate *)currentDate
               block:(void (^)(NSDate *date, NSString *dateString))block
{
    
}

- (id)initWithType:(TFDatePickerType)type block:(TFDatePickerBlock)block
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    if (self)
    {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        self.block = block;
        
        self.maskView = [[UIButton alloc] initWithFrame:self.frame];
        self.maskView.backgroundColor = HEXCOLOR(0X000008,0.5);
        [self.maskView addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.maskView];
        
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BTN_HEIGHT+DATE_PICK_HEIGHT)];
        self.alertView.backgroundColor = HEXCOLOR(0XFAFAFD,  1);
        [self addSubview:self.alertView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, BTN_HEIGHT, self.frame.size.width, 0.5)];
        lineView.backgroundColor = HEXCOLOR(0XEFEFF4,  1);
        [self.alertView addSubview:lineView];
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BTN_WIDTH, BTN_HEIGHT)];
        self.cancelButton.backgroundColor = [UIColor clearColor];
        [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.cancelButton setTitleColor:HEXCOLOR(0X333333,  1) forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.cancelButton];
        
        self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-BTN_WIDTH, 0, BTN_WIDTH, BTN_HEIGHT)];
        self.okButton.backgroundColor = [UIColor clearColor];
        [self.okButton setTitle:@"确认" forState:UIControlStateNormal];
        [self.okButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.okButton setTitleColor:HEXCOLOR(0X03A9F4,  1) forState:UIControlStateNormal];
        [self.okButton setTitleColor:HEXCOLOR(0X0077DD,  1) forState:UIControlStateHighlighted];
        [self.okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.okButton];
        
        self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, BTN_HEIGHT+1, self.frame.size.width, DATE_PICK_HEIGHT)];
        self.datePicker.backgroundColor = [UIColor whiteColor];
        [self.datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"zh-CN"]];
        [self.datePicker setDatePickerMode:(int)type];
        self.datePicker.minuteInterval = 2;
        [self.alertView addSubview:self.datePicker];
        
    }
    
    return self;
}

- (void)show:(void (^)(BOOL finished))completion
{
    self.maskView.alpha = 0;
    self.alertView.frame = CGRectMake(0, SCREEN_HEIGHT, self.alertView.frame.size.width, self.alertView.frame.size.height);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    [UIView animateWithDuration:ANIMATION_DURATION_TIME
                          delay:0
                        options:UIViewAnimationOptionCurveLinear animations:^{
        self->_maskView.alpha = 1;
        [self->_alertView setFrame:CGRectMake(0, SCREEN_HEIGHT-(DATE_PICK_HEIGHT+STYLE_BY_PIXEL(80, 80 , 120)), self->_alertView.frame.size.width, self->_alertView.frame.size.height)];
                          } completion:^(BOOL finished) {
                              
                              if (completion)
                              {
                                  completion(finished);
                              }
                          }];
}

- (void)hide:(void (^)(BOOL finished))completion
{
    [UIView animateKeyframesWithDuration:ANIMATION_DURATION_TIME
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionLayoutSubviews
                              animations:^{

                                  self->_maskView.alpha = 0;
                                  [self->_alertView setFrame:CGRectMake(0, SCREEN_HEIGHT, self->_alertView.frame.size.width, self->_alertView.frame.size.height)];
                              }
                              completion:^(BOOL finished) {
                                  
                                  [self removeFromSuperview];
                                  if (completion)
                                  {
                                      completion(finished);
                                  }
                              }];
}

-(void)cancelButtonClick
{
    [self hide:^(BOOL finished) {
        
    }];
}

-(void)okButtonClick
{
    __weak __typeof(&*self)weakSelf = self;
    [self hide:^(BOOL finished) {
        
        if (weakSelf.block)
        {
            weakSelf.block(weakSelf.currentDate, weakSelf.currentDateString);
        }
    }];
}

-(NSDate *)currentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [self.datePicker date];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    NSLog(@"date=%@",currentDateString);
    return date;
}

-(NSString *)currentDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [self.datePicker date];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *currentDateString = [dateFormatter stringFromDate:date];
    NSLog(@"date=%@",currentDateString);
    return currentDateString;
}

@end
