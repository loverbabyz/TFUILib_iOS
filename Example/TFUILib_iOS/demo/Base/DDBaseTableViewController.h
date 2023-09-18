//
//  DDBaseTableViewController.h
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import <TFUILib_iOS/TFUILib_iOS.h>
#import "XLFormRowDescriptor.h"
#import "UIViewController+Goto.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDBaseTableViewController : TFTableViewController<XLFormRowDescriptorViewController>

- (void)showEmpty;

@end

NS_ASSUME_NONNULL_END
