//
//  NSArray+TFMASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+TFMASAdditions.h"

#ifdef MAS_SHORTHAND

/**
 *	Shorthand array additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface NSArray (TFMASShorthandAdditions)

- (NSArray *)tf_makeConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)tf_updateConstraints:(void(^)(MASConstraintMaker *make))block;
- (NSArray *)tf_remakeConstraints:(void(^)(MASConstraintMaker *make))block;

@end

@implementation NSArray (TFMASShorthandAdditions)

- (NSArray *)tf_makeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_makeConstraints:block];
}

- (NSArray *)tf_updateConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_updateConstraints:block];
}

- (NSArray *)tf_remakeConstraints:(void(^)(MASConstraintMaker *))block {
    return [self mas_remakeConstraints:block];
}

@end

#endif
