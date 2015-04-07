//
//  PFImageView.m
//  PFTemplates
//
//  Created by Paolo Furlan on 16/09/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFImageView.h"

@implementation PFImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)setImageImg:(UIImage *)img
{
    self.layer.contents = (__bridge id)([img CGImage]);
    self.layer.contentsGravity = kCAGravityResizeAspectFill;
    self.layer.masksToBounds = YES;
    [self setImage:img];
}

@end