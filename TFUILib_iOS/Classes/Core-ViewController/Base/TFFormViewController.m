//
//  TFFormViewController.m
//  TFUILib
//
//  Created by Daniel on 7/9/23.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFFormViewController.h"
#import <TFBaseLib_iOS/TFBaseLib_iOS.h>
#import "TFFormSectionModel.h"

@interface TFFormViewController ()<UINavigationBarDelegate>

@property(nonatomic,strong)UIView *headView;

@property(nonatomic,strong)UIView *footView;

@end

@implementation TFFormViewController

#pragma mark- init

- (id)initWithResultBlock:(TFViewControllerResultBlock)block
{
    return [self initWithViewModel:nil resultBlock:block];
}

- (id)initWithViewModel:(id)viewModel
{
    return [self initWithViewModel:viewModel resultBlock:nil];
}

- (id)initWithViewModel:(id)viewModel resultBlock:(TFViewControllerResultBlock)block
{
    self = [super init];
    if (self)
    {
        // Initialization code
        _viewModel = viewModel;
        _resultBlock = block;
    }
    
    return self;
}

- (id)initWithData:(NSDictionary*)data
{
    return [self initWithData:data resultBlock:nil];
}

- (id)initWithData:(NSDictionary*)data resultBlock:(TFViewControllerResultBlock)block
{
    self = [super init];
    if (self)
    {
        // Initialization code
        _resultBlock=block;
        
        NSString *viewControllerClassName = NSStringFromClass([self class]);
        NSString *viewModelClassName      = [viewControllerClassName stringByReplacingOccurrencesOfString:@"ViewController" withString:@"ViewModel"];
        
        Class viewModel = NSClassFromString(viewModelClassName);
        if (viewModel)
        {
            _viewModel = [viewModel tf_mj_objectWithKeyValues:data];
        }
    }
    
    return self;
}

- (id)initWithViewModel:(id)viewModel
                nibName:(NSString *)nibName
                 bundle:(NSBundle *)bundle
            resultBlock:(TFViewControllerResultBlock)block
{
    self = [super initWithNibName:nibName bundle:bundle];
    if (self)
    {
        // Initialization code
        _viewModel = viewModel;
        _resultBlock     = block;
    }

    return self;
}

- (id)initWithViewModel:(id)viewModel
                nibName:(NSString *)nibName
                 bundle:(NSBundle *)bundle
{
    self = [super initWithNibName:nibName bundle:bundle];
    if (self == nil) return nil;

    _viewModel = viewModel;

    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
        
    {
        // Custom initialization
        
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    TF_APP_APPLICATION.statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    //self.view.backgroundColor = [UIColor clearColor];
    
    [self initBackButton];
    
    if ([self.viewModel respondsToSelector:@selector(title)])
    {
        if ([self.viewModel title] != nil)
        {
            [self initTitle:[self.viewModel title]];
        }
    }
    
    //statusbar改白色
    //[TF_APP_APPLICATION setStatusBarStyle:UIStatusBarStyleLightContent];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets           = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    [self initViews];
    [self autolayoutViews];
    [self bindData];
}

#pragma mark- 控制状态栏的样式

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark- init autolayout bind

- (void)initViews
{

}

- (void)autolayoutViews
{
    
}

#pragma mark - Common

- (XLFormRowDescriptor *)rowDescriptorCommon:(TFFormRowModel * _Nonnull)obj rowType:(NSString *)rowType {
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:obj.tag ?: [NSString stringWithFormat:@"row-%@", obj.identity] rowType:rowType title:obj.title];
    row.disabled = @(obj.disabled);
    if (obj.height > 0) {
        row.height = obj.height;
    }
    
    if (obj.config) {
        [obj.config enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [row.cellConfigAtConfigure setValue:obj forKey:key];
        }];
    }
    
    if (obj.style) {
        [obj.style enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [row.cellConfigForSelector setValue:obj forKey:key];
        }];
    }
    
    if (obj.valueTransformer) {
        row.valueTransformer = NSClassFromString(obj.valueTransformer);
    }
    
    typeof(self) __weak weakself = self;
    
    if (obj.onChangeBlock) {
        row.onChangeBlock = ^(id oldValue, id newValue, XLFormRowDescriptor* __unused rowDescriptor){
            if ([newValue isKindOfClass:[NSNull class]]) {
                return;
            }
            
            [weakself handleOnChangeBlock:obj newValue:newValue];
        };
    }
    
    row.hidden = [self predicateFromMethodString:obj.predicate] ?: @0;
    row.action.viewControllerPresentationMode = (XLFormPresentationMode)obj.viewControllerPresentationMode;
    
    if(obj.viewControllerClass) {
        row.action.viewControllerClass = NSClassFromString(obj.viewControllerClass);
    } else if (obj.viewControllerStoryboardId) {
        row.action.viewControllerStoryboardId = obj.viewControllerStoryboardId;
    } else if (obj.viewControllerNibName) {
        row.action.viewControllerNibName = obj.viewControllerNibName;
    } else if (obj.formSegueIdentifier) {
        row.action.formSegueIdentifier = obj.formSegueIdentifier;
    } else if (obj.formSegueClass) {
        row.action.formSegueClass = NSClassFromString(obj.formSegueClass);
    } else {
        __typeof(self) __weak weakSelf = self;
        row.action.formBlock = ^(XLFormRowDescriptor * sender){
            [weakSelf handleData:obj];
            [weakSelf deselectFormRow:sender];
        };
    }
    
    /**
     [row.cellConfigAtConfigure setObject:[UIColor purpleColor] forKey:@"backgroundColor"];
     [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textLabel.color"];
     [row.cellConfig setObject:[UIFont fontWithName:@"Helvetica" size:40] forKey:@"textLabel.font"];
     [row.cellConfig setObject:@(NSTextAlignmentNatural) forKey:@"textLabel.textAlignment"];
     [row.cellConfig setObject:@(UITableViewCellAccessoryDisclosureIndicator) forKey:@"accessoryType"];
     
     row.action.formSelector = @selector(didTouchButton:);
     row.action.formSegueClass = NSClassFromString(@"UIStoryboardPushSegue");
     row.action.formSegueIdentifier = @"MapViewControllerSegue";
     row.action.viewControllerStoryboardId = @"MapViewController";
     row.action.viewControllerNibName = @"MapViewController";
     row.action.viewControllerClass = [MapViewController class];
    */
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeText:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:obj.placeholder forKey:@"textField.placeholder"];
    row.required = obj.required;
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeBooleanSwitch:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeBooleanSwitch];
    row.value = ((NSNumber *)obj.value) ?: @(0);
    // [row.cellConfigAtConfigure setObject:[UIColor redColor] forKey:@"switchControl.onTintColor"];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeDateTimeInline:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeDateTimeInline];
    if (obj.value) {
        row.value = [NSDate dateWithTimeIntervalSinceNow:((NSNumber *)obj.value).integerValue];
    }
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeButton:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeButton];
    row.value = obj;
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeInfo:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeInfo];
    if (obj.value) {
        row.value = obj.value;
    }
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeName:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeName];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypePhone:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypePhone];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeNumber:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeNumber];
    
    return row;
}

#pragma mark - SelectorCommon

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorCommon:(TFFormRowModel * _Nonnull)obj rowType:(NSString *)rowType {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:rowType];
    
    if(obj.selectorOptions) {
        NSMutableArray<XLFormOptionsObject *> *selectorOptions = [NSMutableArray new];
        [obj.selectorOptions enumerateObjectsUsingBlock:^(TFModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            [selectorOptions addObject:[XLFormOptionsObject formOptionsObjectWithValue:model.identity displayText:model.title]];
        }];

        row.value = selectorOptions.firstObject;
        row.selectorTitle = obj.title;
        row.selectorOptions = selectorOptions;
    }

    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorPush:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorPush];

    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorPickerViewInline:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorPickerViewInline];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorAlertView:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorAlertView];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorActionSheet:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorActionSheet];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorPopover:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorPopover];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorPickerView:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorPickerView];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeMultipleSelector:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeMultipleSelector];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeMultipleSelectorPopover:(TFFormRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorPopover];
    
    return row;
}

#pragma mark -

- (void)bindData
{
    if (self.viewModel.formDataArray) {
        XLFormDescriptor * form = [XLFormDescriptor formDescriptor];
        [self.viewModel.formDataArray enumerateObjectsUsingBlock:^(__kindof TFTableSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TFFormSectionModel *sectionModel = (TFFormSectionModel *)obj;
            XLFormSectionDescriptor * section = [XLFormSectionDescriptor formSectionWithTitle:sectionModel.title];
            [sectionModel.dataArray enumerateObjectsUsingBlock:^(__kindof TFFormRowModel * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                XLFormRowDescriptor * row;
                if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeText]){
                    row = [self rowDescriptorTypeText:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeName]){
                    row = [self rowDescriptorTypeName:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeNumber]){
                    row = [self rowDescriptorTypeNumber:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypePhone]){
                    row = [self rowDescriptorTypePhone:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPush]){
                    row = [self rowDescriptorTypeSelectorPush:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPopover]){
                    row = [self rowDescriptorTypeSelectorPopover:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSelectorActionSheet]){
                    row = [self rowDescriptorTypeSelectorActionSheet:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSelectorAlertView]){
                    row = [self rowDescriptorTypeSelectorAlertView:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPickerView]){
                    row = [self rowDescriptorTypeSelectorPickerView:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSelectorPickerViewInline]){
                    row = [self rowDescriptorTypeSelectorPickerViewInline:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeMultipleSelector]){
                    row = [self rowDescriptorTypeMultipleSelector:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeMultipleSelectorPopover]){
                    row = [self rowDescriptorTypeMultipleSelectorPopover:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSelectorLeftRight]){
                    //                row = [self rowDescriptorTypeSelectorLeftRight:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSelectorSegmentedControl]){
                    //                row = [self rowDescriptorTypeSelectorSegmentedControl:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeDateInline]){
                    //                row = [self rowDescriptorTypeDateInline:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeDateTimeInline]){
                    row = [self rowDescriptorTypeDateTimeInline:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeTimeInline]){
                    //                row = [self rowDescriptorTypeTimeInline:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeCountDownTimerInline]){
                    //                row = [self rowDescriptorTypeCountDownTimerInline:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeDate]){
                    //                row = [self rowDescriptorTypeDate:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeDateTime]){
                    //                row = [self rowDescriptorTypeDateTime:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeTime]){
                    //                row = [self rowDescriptorTypeTime:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeCountDownTimer]){
                    //                row = [self rowDescriptorTypeCountDownTimer:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeDatePicker]){
                    //                row = [self rowDescriptorTypeDatePicker:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypePicker]){
                    //                row = [self rowDescriptorTypePicker:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeSlider]){
                    //                row = [self rowDescriptorTypeSlider:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeBooleanCheck]){
                    //                row = [self rowDescriptorTypeBooleanCheck:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeBooleanSwitch]){
                    row = [self rowDescriptorTypeBooleanSwitch:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeButton]){
                    row = [self rowDescriptorTypeButton:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeInfo]){
                    row = [self rowDescriptorTypeInfo:obj1];
                }
                else if([obj1.rowType isEqualToString:XLFormRowDescriptorTypeStepCounter]){
                    //                row = [self rowDescriptorTypeStepCounter:obj1];
                }
                
                if (row) {
                    [section addFormRow:row];
                }
            }];
            
            section.footerTitle = sectionModel.footTitle;
            section.hidden = [self predicateFromMethodString:sectionModel.predicate] ?: @0;
            
            [form addFormSection:section];
        }];
        
        self.form = form;
    }
}

-(void)handleOnChangeBlock:(TFFormRowModel *)data newValue:(id)newValue
{
    if (data==nil)
    {
        return;
    }
    
    if (![data isKindOfClass:[TFFormRowModel class]])
    {
        return;
    }
    
    if (data.onChangeBlock!=nil)
    {
        SEL selector = NSSelectorFromString(data.onChangeBlock);
        if ([self respondsToSelector:selector])
        {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selector withObject:newValue withObject:nil];
#pragma clang diagnostic pop
        }
        else
        {
            NSCAssert(NO, ([NSString stringWithFormat:@"method对应%@不存在",data.onChangeBlock]));
        }
        
        return;
    }
}

#pragma mark load data

- (void)startLoadData
{
    TF_MAIN_THREAD(^(){
          [self showHud];
       });
}

- (void)endLoadData
{
    TF_MAIN_THREAD(^(){
       [self hideHud];
    });
}

-(void)showCustomNaviBar:(TFView *)customNaviBar
{
    self.customNaviBarView = customNaviBar;
    
    UIView *view = [self findInView:self.navigationController.navigationBar withName:@"_UINavigationBarBackground"];
    [view addSubview:self.customNaviBarView];
    self.customNaviBarView.alpha = 0;
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.customNaviBarView.alpha = 1;
                     }];

}

-(void)hideCustomNaviBar
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         self.customNaviBarView.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self.customNaviBarView removeFromSuperview];
                     }];
}

- (void)showWithTitle:(NSString *)title
    cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                block:(ActionSheetBlock)block
{
    [TFActionSheet showWithTitle:title
               cancelButtonTitle:cancelButtonTitle
          destructiveButtonTitle:destructiveButtonTitle
               otherButtonTitles:otherButtonTitles
                           block:block];
}

- (void)assignFirstResponderOnShow {
    self.form.assignFirstResponderOnShow = YES;
}

#pragma mark- setter getter

- (id)viewModel
{
    if (_viewModel == nil)
    {
        NSString *viewControllerClassName = NSStringFromClass([self class]);
        NSString *viewModelClassName      = [viewControllerClassName stringByReplacingOccurrencesOfString:@"ViewController" withString:@"ViewModel"];
        
        Class viewModel = NSClassFromString(viewModelClassName);
        if (viewModel)
        {
            _viewModel = [[viewModel alloc]init];
        }
    }

    return _viewModel;
}

#pragma mark - privite method -

-(UIView *)findInView:(UIView *)aView withName:(NSString *)name {
    Class cl = [aView class];
    NSString *desc = [cl description];
    
    if ([name isEqualToString:desc])
    {
        return aView;
    }
    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++)
    {
        UIView *subView = [aView.subviews objectAtIndex:i];
        subView = [self findInView:subView withName:name];
        if (subView)
        {
            return subView;
        }
    }
    return nil;
}

- (id)predicateFromMethodString:(NSString * _Nonnull)string {
    if (tf_isEmpty(string)) {
        return nil;
    }
    
    SEL selector = NSSelectorFromString(string);
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self performSelector:selector withObject:nil withObject:nil];
#pragma clang diagnostic pop
    } else {
        NSCAssert(NO, ([NSString stringWithFormat:@"predicate对应%@不存在", string]));
    }
    
    return nil;
}

@end


