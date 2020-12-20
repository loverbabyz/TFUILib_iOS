//
//  TFImageLoopViewCell.m
//  TFImageLoopView
//
//  Created by Daniel on 2020/7/8.
//  Copyright © 2020 Daniel.Sun. All rights reserved.
//

#import "TFImageLoopViewCell.h"

@implementation TFImageLoopViewCell

- (void)initViews {
    [super initViews];
    
    [self setupImageView];
}

- (void)setupImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    
    [self.containerView addSubview:imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.containerView.bounds;
}

@end
