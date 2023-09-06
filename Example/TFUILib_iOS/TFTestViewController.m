//
//  TFTestViewController.m
//  TFUILib_iOS_Example
//
//  Created by Daniel on 2020/7/19.
//  Copyright © 2020 SunXiaofei. All rights reserved.
//

#import "TFTestViewController.h"
#import <TFUILib_iOS/TFUILib_iOS.h>
#import "DateAndTimeValueTrasformer.h"

@interface TFTestViewController ()

@end
@implementation TFTestViewController{

}

-(void)cancelPressed:(UIBarButtonItem * __unused)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)savePressed:(UIBarButtonItem * __unused)button {
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
}

- (void)initViews {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
}

//- (void)bindData {
//    [self initializeForm];
//}
- (void)handleFormData:(XLFormRowDescriptor *)data {
    TFTableRowModel *row = data.value;
    if (!row) {
        return;
    }
    
    if ([row.identity isEqualToString:@"41"]) {
        tf_showToast(row.title);
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
