//
//  TFViewController.m
//  TFUILib_iOS
//
//  Created by SunXiaofei on 07/19/2020.
//  Copyright (c) 2020 SunXiaofei. All rights reserved.
//

#import "TFAViewController.h"
#import "TFTestViewController.h"

#import <TFUILib_iOS/TFUILib_iOS.h>

@interface TFAViewController ()

@end

@implementation TFAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     [TFActionSheet showWithTitle:@"是否要删除" cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil block:nil];
               NSLog(@"dddddddd");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
