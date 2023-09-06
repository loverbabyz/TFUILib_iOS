//
//  TFFormViewController.m
//  TFUILib_iOS
//
//  Created by Daniel on 2023/9/6.
//

#import "TFFormViewController.h"

#import <TFBaseLib_iOS/TFMJExtension.h>
#import <TFUILib_iOS/TFUILib_iOS.h>

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

- (XLFormRowDescriptor *)rowDescriptorCommon:(__kindof TFTableRowModel * _Nonnull)obj rowType:(NSString *)rowType {
    XLFormRowDescriptor *row = [XLFormRowDescriptor formRowDescriptorWithTag:[NSString stringWithFormat:@"row-%@", obj.identity] rowType:rowType title:obj.title];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeText:(__kindof TFTableRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:obj.placeholder forKey:@"textField.placeholder"];
    row.required = (((NSNumber *)obj.parameter) ?: @(0)).boolValue;
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeBooleanSwitch:(__kindof TFTableRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeBooleanSwitch];
    row.value = ((NSNumber *)obj.parameter) ?: @(0);
    // [row.cellConfigAtConfigure setObject:[UIColor redColor] forKey:@"switchControl.onTintColor"];
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeDateTimeInline:(__kindof TFTableRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeDateTimeInline];
    if (obj.parameter) {
        row.value = [NSDate dateWithTimeIntervalSinceNow:((NSNumber *)obj.parameter).integerValue];
    }
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorCommon:(__kindof TFTableRowModel * _Nonnull)obj rowType:(NSString *)rowType {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:rowType];
    
    if(obj.parameter) {
        NSArray<TFTableRowModel *> *rows = [TFTableRowModel tf_mj_objectArrayWithKeyValuesArray:[obj.parameter tf_mj_JSONObject]];
        
        if (rows) {
            NSMutableArray<XLFormOptionsObject *> *selectorOptions = [NSMutableArray new];
            [rows enumerateObjectsUsingBlock:^(TFTableRowModel * _Nonnull rowModel, NSUInteger idx, BOOL * _Nonnull stop) {
                [selectorOptions addObject:[XLFormOptionsObject formOptionsObjectWithValue:rowModel.identity displayText:rowModel.title]];
            }];
            
            row.value = selectorOptions.firstObject;
            row.selectorTitle = obj.title;
            row.selectorOptions = selectorOptions;
        }
    }

    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorPush:(__kindof TFTableRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorPush];

    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeButton:(__kindof TFTableRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeButton];
    row.value = obj;
    
    if (obj.method) {
        row.action.formSegueIdentifier = obj.method;
    } else if(obj.vc && obj.vc.length > 0) {
        row.action.viewControllerClass = NSClassFromString(obj.vc);
    } else {
        __typeof(self) __weak weakSelf = self;
        row.action.formBlock = ^(XLFormRowDescriptor * sender){
            [weakSelf handleFormData:sender];
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

- (XLFormRowDescriptor *)rowDescriptorTypeInfo:(__kindof TFTableRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorCommon:obj rowType:XLFormRowDescriptorTypeInfo];
    row.value = obj.parameter;
    
    return row;
}

- (XLFormRowDescriptor *)rowDescriptorTypeSelectorPickerViewInline:(__kindof TFTableRowModel * _Nonnull)obj {
    XLFormRowDescriptor *row = [self rowDescriptorTypeSelectorCommon:obj rowType:XLFormRowDescriptorTypeSelectorPickerViewInline];
    
    return row;
}

- (void)bindData
{
    XLFormDescriptor * form = [XLFormDescriptor formDescriptor];
    
    [self.viewModel.dataArray enumerateObjectsUsingBlock:^(__kindof TFTableSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XLFormSectionDescriptor * section = [XLFormSectionDescriptor formSectionWithTitle:obj.title];
        [obj.dataArray enumerateObjectsUsingBlock:^(__kindof TFTableRowModel * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            XLFormRowDescriptor * row;
            if([obj1.action isEqualToString:XLFormRowDescriptorTypeText]){
                row = [self rowDescriptorTypeText:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeName]){
//                row = [self rowDescriptorTypeName:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeNumber]){
//                row = [self rowDescriptorTypeNumber:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypePhone]){
//                row = [self rowDescriptorTypePhone:obj1];
            }
            
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSelectorPush]){
                row = [self rowDescriptorTypeSelectorPush:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSelectorPopover]){
//                row = [self rowDescriptorTypeSelectorPopover:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSelectorActionSheet]){
//                row = [self rowDescriptorTypeSelectorActionSheet:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSelectorAlertView]){
//                row = [self rowDescriptorTypeSelectorAlertView:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSelectorPickerView]){
//                row = [self rowDescriptorTypeSelectorPickerView:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSelectorPickerViewInline]){
                row = [self rowDescriptorTypeSelectorPickerViewInline:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeMultipleSelector]){
//                row = [self rowDescriptorTypeMultipleSelector:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeMultipleSelectorPopover]){
//                row = [self rowDescriptorTypeMultipleSelectorPopover:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSelectorLeftRight]){
//                row = [self rowDescriptorTypeSelectorLeftRight:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSelectorSegmentedControl]){
//                row = [self rowDescriptorTypeSelectorSegmentedControl:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeDateInline]){
//                row = [self rowDescriptorTypeDateInline:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeDateTimeInline]){
                row = [self rowDescriptorTypeDateTimeInline:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeTimeInline]){
//                row = [self rowDescriptorTypeTimeInline:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeCountDownTimerInline]){
//                row = [self rowDescriptorTypeCountDownTimerInline:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeDate]){
//                row = [self rowDescriptorTypeDate:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeDateTime]){
//                row = [self rowDescriptorTypeDateTime:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeTime]){
//                row = [self rowDescriptorTypeTime:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeCountDownTimer]){
//                row = [self rowDescriptorTypeCountDownTimer:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeDatePicker]){
//                row = [self rowDescriptorTypeDatePicker:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypePicker]){
//                row = [self rowDescriptorTypePicker:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeSlider]){
//                row = [self rowDescriptorTypeSlider:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeBooleanCheck]){
//                row = [self rowDescriptorTypeBooleanCheck:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeBooleanSwitch]){
                row = [self rowDescriptorTypeBooleanSwitch:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeButton]){
                row = [self rowDescriptorTypeButton:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeInfo]){
                row = [self rowDescriptorTypeInfo:obj1];
            }
            else if([obj1.action isEqualToString:XLFormRowDescriptorTypeStepCounter]){
//                row = [self rowDescriptorTypeStepCounter:obj1];
            }
            
            if (row) {
                [section addFormRow:row];
            }
        }];
        section.footerTitle = obj.detail;
        [form addFormSection:section];
    }];

    self.form = form;
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

-(UIView *)findInView:(UIView *)aView withName:(NSString *)name
{
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

@end


