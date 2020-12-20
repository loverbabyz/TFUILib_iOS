//
//  TFPicker.m
//  TFUILib
//
//  Created by Daniel.Sun on 2018/1/27.
//

#import "TFPicker.h"
#import "TFTreeNode.h"

#define BTN_WIDTH 70
#define BTN_HEIGHT 40

#define DATE_PICK_HEIGHT 220

#define ANIMATION_DURATION_TIME 0.3

@interface TFPicker ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, copy) TFPickerBlock block;

@property (nonatomic, strong) NSArray<TFTreeNode *> *dataArray;
@property (nonatomic, assign) NSInteger components;

@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIButton *maskView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSArray<TFTreeNode *> *> *componentsDirctionary;
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, TFTreeNode *> *resultDirctionary;



@end

@implementation TFPicker

+ (id)initWithBlock:(TFPickerBlock)block dataArray:(NSArray<TFTreeNode *> *)dataArray components:(NSInteger)components{
    return [[TFPicker alloc] initWithBlock:block dataArray:dataArray components:components];
}

- (id)initWithBlock:(TFPickerBlock)block dataArray:(NSArray<TFTreeNode *> *)dataArray components:(NSInteger)components
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self)
    {
        self.block = block;
        self.dataArray = dataArray;
        self.components = components;
        self.resultDirctionary = [NSMutableDictionary dictionaryWithCapacity:self.dataArray.count];
        
        self.backgroundColor = [UIColor clearColor];
        
        self.maskView = [[UIButton alloc] initWithFrame:self.frame];
        self.maskView.backgroundColor = HEXCOLOR(0X000008,0.5) ;
        [self.maskView addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.maskView];
        
        self.alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BTN_HEIGHT+DATE_PICK_HEIGHT + self.tf_safeAreaInset.bottom)];
        self.alertView.backgroundColor = HEXCOLOR(0XFAFAFD,  1);
        [self addSubview:self.alertView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, BTN_HEIGHT, self.width, 0.5)];
        lineView.backgroundColor = HEXCOLOR(0XEFEFF4,  1);
        [self.alertView addSubview:lineView];
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BTN_WIDTH, BTN_HEIGHT)];
        self.cancelButton.backgroundColor = [UIColor clearColor];
        [self.cancelButton setTitle:NSLocalizedString(@"cancel", @"cancel") forState:UIControlStateNormal];
        [self.cancelButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.cancelButton setTitleColor:HEXCOLOR(0X333333,  1) forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.cancelButton];
        
        self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-BTN_WIDTH, 0, BTN_WIDTH, BTN_HEIGHT)];
        self.okButton.backgroundColor = [UIColor clearColor];
        [self.okButton setTitle:NSLocalizedString(@"ok", @"ok") forState:UIControlStateNormal];
        [self.okButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.okButton setTitleColor:HEXCOLOR(0X03A9F4,  1) forState:UIControlStateNormal];
        [self.okButton setTitleColor:HEXCOLOR(0X0077DD,  1) forState:UIControlStateHighlighted];
        [self.okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:self.okButton];
        
        self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, BTN_HEIGHT + 1, self.width, DATE_PICK_HEIGHT)];
        self.picker.backgroundColor = [UIColor whiteColor];
        self.picker.delegate = self;
        self.picker.dataSource = self;
        [self.alertView addSubview:self.picker];
        
        [self selectRowWithArray:self.dataArray row:0 inComponent:0 animated:YES];
    }
    
    return self;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    [self selectRowWithArray:nil row:row inComponent:component animated:animated];
}

- (void)show:(void (^)(BOOL finished))completion
{
    self.maskView.alpha = 0;
    self.alertView.frame = CGRectMake(0, SCREEN_HEIGHT, self.alertView.width, self.alertView.height);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:ANIMATION_DURATION_TIME
                          delay:0
                        options:UIViewAnimationOptionCurveLinear animations:^{
                            weakSelf.maskView.alpha = 1;
        [weakSelf.alertView setFrame:CGRectMake(0, SCREEN_HEIGHT - weakSelf.alertView.height, weakSelf.alertView.width, weakSelf.alertView.height)];
                        } completion:^(BOOL finished) {
                            if (completion) {
                                completion(finished);
                            }
                        }];
}

- (void)hide:(void (^)(BOOL finished))completion
{
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateKeyframesWithDuration:ANIMATION_DURATION_TIME
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionLayoutSubviews
                              animations:^{
        weakSelf.maskView.alpha = 0;
        [weakSelf.alertView setFrame:CGRectMake(0, SCREEN_HEIGHT, weakSelf.alertView.width, weakSelf.alertView.height)];
                              }
                              completion:^(BOOL finished) {
                                  [weakSelf removeFromSuperview];
                                  if (completion) {
                                      completion(finished);
                                  }
                              }];
}

-(void)cancelButtonClick
{
    _resultDirctionary = nil;
    [self hide:^(BOOL finished) {
        
    }];
}

-(void)okButtonClick
{
    __weak __typeof(&*self)weakSelf = self;
    [self hide:^(BOOL finished) {
        if (weakSelf.block)
        {
            weakSelf.block([NSDictionary dictionaryWithDictionary:weakSelf.resultDirctionary]);
        }
    }];
}

#pragma -mark - picker view delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.components;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.componentsDirctionary objectForKey:@(component)].count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.componentsDirctionary objectForKey:@(component)][row].title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self selectRowWithArray:[self.componentsDirctionary objectForKey:@(component)] row:row inComponent:component animated:YES];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
    }
   
    label.text = [self.componentsDirctionary objectForKey:@(component)][row].title;
    
    return label;
}

- (void)selectRowWithArray:(NSArray<TFTreeNode *> *)array row:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    if (!array) {
        array = [self.componentsDirctionary objectForKey:@(component)];
    } else {
        [self.componentsDirctionary setObject:array forKey:@(component)];
    }
    [self.picker reloadComponent:component];
    
    if (component < (self.components - 1)) {
        [self.picker selectRow:0 inComponent:component animated:animated];
        
        [self selectRowWithArray:array[row].nodes row:0 inComponent:(component + 1) animated:animated];
    }
    
    [self.picker selectRow:row inComponent:component animated:animated];
    [self saveSelectedItemAtRow:row inComponent:component];
}

- (void)saveSelectedItemAtRow:(NSInteger)row inComponent:(NSInteger)component {
    TFTreeNode *selectedNode = [self.componentsDirctionary objectForKey:@(component)][row];
    TFTreeNode *node = [TFTreeNode new];
    node.identity = selectedNode.identity;
    node.rootIdentity = selectedNode.rootIdentity;
    node.title = selectedNode.title;
    
    [self.resultDirctionary setObject:node forKey:@(component)];
}

#pragma mark - getter & setter

- (NSMutableDictionary<NSNumber *,NSArray<TFTreeNode *> *> *)componentsDirctionary {
    if (!_componentsDirctionary) {
        _componentsDirctionary = [NSMutableDictionary new];
        [_componentsDirctionary setObject:_dataArray forKey:@(0)];
    }
    
    return _componentsDirctionary;
}

@end
