//
//  DDDefaultValueTransformer.m
//  IngeekDK-V4
//
//  Created by Ingeek-091 on 2023/9/17.
//

#import "DDDefaultValueTransformer.h"
#import <TFUILib_iOS/TFUILib_iOS.h>

@implementation DDDefaultValueTransformer

+ (Class)transformedValueClass {
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation {
    return NO;
}

- (id)transformedValue:(id)value {
    if (!value) {
        return nil;
    }
    
    TFTableRowModel * model = (TFTableRowModel *)value;
    return [NSString stringWithFormat:@"%@", model.identity];
}

@end
