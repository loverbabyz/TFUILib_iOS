//
//  TFMacro+GCD.h
//  Treasure
//
//  Created by Daniel on 15/9/14.
//  Copyright (c) daniel.xiaofei@gmail.com All rights reserved.
//

/**
 *  获取主线程
 */
#ifndef TF_MAIN_THREAD
#define TF_MAIN_THREAD(block) dispatch_async(dispatch_get_main_queue(),block)
#endif
/**
 *  异步线程
 */
#ifndef TF_BACK_THREAD
#define TF_BACK_THREAD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#endif
