//
//  TFImageView.m
//  TFUILib
//
//  Created by Daniel on 16/1/12.
//  Copyright © 2016年 daniel.xiaofei@gmail.com All rights reserved.
//

#import "TFImageView.h"

@interface TFImageView()

@end

@implementation TFImageView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {

    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {

    }

    return self;
}

#pragma mark - Set -

-(void)setPlaceholderImage:(UIImage *)placeholderImage
{
    self.image = placeholderImage;
}

#pragma mark - Set Up -

@end
