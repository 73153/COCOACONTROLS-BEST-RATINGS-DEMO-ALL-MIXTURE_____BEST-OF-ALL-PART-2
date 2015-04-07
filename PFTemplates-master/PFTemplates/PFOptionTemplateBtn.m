//
//  TLOptionTemplateBtn.m
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFOptionTemplateBtn.h"

@implementation PFOptionTemplateBtn

- (id)initWithFrame:(CGRect)frame andImg:(UIImage *)img
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _imgBtn=[[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-img.size.width/4, self.frame.size.height/2-img.size.height/4, img.size.width/2, img.size.height/2)];
        [_imgBtn setImage:img];
        [self addSubview:_imgBtn];
    }
    return self;
}

@end