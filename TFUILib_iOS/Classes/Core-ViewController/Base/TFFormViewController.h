//
//  TFFormViewController.h
//  TFUILib
//
//  Created by Daniel on 7/9/23.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "XLFormViewController.h"
#import "TFViewModel.h"
#import "TFView.h"
#import "TFActionSheet.h"
#import "TFFormViewModel.h"

typedef void (^TFViewControllerResultBlock)(id x);

@interface TFFormViewController : XLFormViewController

/**
 *  控制器的viewModel
 */
@property (nonatomic, strong) TFFormViewModel *viewModel;

/**
 *  控制器结果回调
 */
@property (nonatomic, strong) TFViewControllerResultBlock resultBlock;

@property (nonatomic, strong) TFView *customNaviBarView;

#pragma mark - init

/**
 *  初始化控制器
 *
 *  @param block 控制器回调
 *
 *  @return 控制器
 */
- (id)initWithResultBlock:(TFViewControllerResultBlock)block;

/**
 *  初始化控制器
 *
 *  @param viewModel 控制器viewModel
 *
 *  @return 控制器
 */
- (id)initWithViewModel:(id)viewModel;

/**
 *  初始化控制器
 *
 *  @param viewModel 控制器viewModel
 *  @param block     控制器回调
 *
 *  @return 控制器
 */
- (id)initWithViewModel:(id)viewModel resultBlock:(TFViewControllerResultBlock)block;

/**
 *  初始化控制器
 *
 *  @param data 数据
 *
 *  @return 控制器
 */
- (id)initWithData:(NSDictionary*)data;

/**
 *  初始化控制器
 *
 *  @param data  数据
 *  @param block 控制器回调
 *
 *  @return 控制器
 */
- (id)initWithData:(NSDictionary*)data resultBlock:(TFViewControllerResultBlock)block;

/**
 *  初始化控制器
 *
 *  @param viewModel 控制器viewModel
 *  @param nibName   nib名称
 *  @param bundle    NSBundle
 *
 *  @return 控制器
 */
- (id)initWithViewModel:(id)viewModel
                nibName:(NSString *)nibName
                 bundle:(NSBundle *)bundle;

/**
 *  初始化控制器
 *
 *  @param viewModel 控制器viewModel
 *  @param nibName   nib名称
 *  @param bundle    NSBundle
 *  @param block     控制器回调
 *
 *  @return 控制器
 */
- (id)initWithViewModel:(id)viewModel
                nibName:(NSString *)nibName
                 bundle:(NSBundle *)bundle
            resultBlock:(TFViewControllerResultBlock)block;

/**
 *  初始化视图
 */
- (void)initViews;

/**
 *  自动布局视图
 */
- (void)autolayoutViews;

/**
 *  绑定数据
 */
- (void)bindData;

#pragma mark-  load data

/**
 *  开始载入数据
 */
- (void)startLoadData;

/**
 *  停止载入数据
 */
- (void)endLoadData;

/**
 *  显示自定义导航栏
 *
 *  @param customNaviBar 自定义导航栏
 */
-(void)showCustomNaviBar:(TFView*)customNaviBar;

/**
 *  隐藏自定义导航栏
 */
-(void)hideCustomNaviBar;

/**
 弹出ActionSheet对话框
 
 @param title 标题
 @param cancelButtonTitle 取消按钮标题
 @param destructiveButtonTitle 特殊标记按钮标题
 @param otherButtonTitles 其他按钮项
 @param block 按钮点击事件block
 */
- (void)showWithTitle:(NSString *)title
    cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
    otherButtonTitles:(NSArray *)otherButtonTitles
                block:(ActionSheetBlock)block;

@end
