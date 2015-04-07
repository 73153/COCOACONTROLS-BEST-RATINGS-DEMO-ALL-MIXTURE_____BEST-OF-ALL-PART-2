//
//  TLImageViewCheck.m
//  20lines
//
//  Created by Paolo Furlan on 22/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFImageViewCheck.h"

@implementation PFImageViewCheck

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        PFImageView *imgBackCheck=[[PFImageView alloc] initWithFrame:CGRectMake(0, 1, self.frame.size.width, self.frame.size.height-1)];
        CALayer *maskLayer = [CALayer layer];
        UIImage *mask = [UIImage imageNamed:@"iconCheckColorize"];
        maskLayer.contents = (id)mask.CGImage;
        maskLayer.frame = CGRectMake(0, 0, 14, 13);
        imgBackCheck.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.15];
        imgBackCheck.layer.mask = maskLayer;
        [self addSubview:imgBackCheck];

        PFImageView *imgCheckColor=[[PFImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-1)];
        [imgCheckColor setImage:[UIImage imageNamed:@"iconCheckColorize"]];
        [self addSubview:imgCheckColor];
    }
    return self;
}


@end