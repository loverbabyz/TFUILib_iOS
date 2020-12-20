#import "UILabel+dynamicSizeMe.h"
#import "UILabel+ContentSize.h"

@implementation UILabel (dynamicSizeMe)

- (void)resizeToFit {
    float height = [self contentSize].height;
    float width = [self contentSize].width;
    CGRect newFrame = [self frame];
    newFrame.size.height = height;
    newFrame.size.width = width;
    [self setFrame:newFrame];
    //return newFrame.origin.y + newFrame.size.height;
}

@end
