//
//  UIViewController+TFMASAdditions.h
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "TFMASUtilities.h"
#import "TFMASConstraintMaker.h"
#import "TFMASViewAttribute.h"

#ifdef TF_MAS_VIEW_CONTROLLER

@interface TF_MAS_VIEW_CONTROLLER (TFMASAdditions)

/**
 *	following properties return a new TFMASViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_topLayoutGuide;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_bottomLayoutGuide;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_topLayoutGuideTop;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) TFMASViewAttribute *tf_mas_bottomLayoutGuideBottom;


@end

#endif
