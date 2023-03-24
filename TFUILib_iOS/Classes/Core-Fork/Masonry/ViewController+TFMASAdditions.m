//
//  UIViewController+TFMASAdditions.m
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+TFMASAdditions.h"

#ifdef TF_MAS_VIEW_CONTROLLER

@implementation TF_MAS_VIEW_CONTROLLER (TFMASAdditions)

- (TFMASViewAttribute *)tf_mas_topLayoutGuide {
    return [[TFMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (TFMASViewAttribute *)tf_mas_topLayoutGuideTop {
    return [[TFMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (TFMASViewAttribute *)tf_mas_topLayoutGuideBottom {
    return [[TFMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (TFMASViewAttribute *)tf_mas_bottomLayoutGuide {
    return [[TFMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (TFMASViewAttribute *)tf_mas_bottomLayoutGuideTop {
    return [[TFMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (TFMASViewAttribute *)tf_mas_bottomLayoutGuideBottom {
    return [[TFMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}



@end

#endif
