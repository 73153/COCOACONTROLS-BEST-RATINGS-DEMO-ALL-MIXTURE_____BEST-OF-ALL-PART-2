//
//  TLBackBtn.m
//  PFTemplates
//
//  Created by Paolo Furlan on 05/09/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFBackBtn.h"

@implementation PFBackBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        UIImageView *imgBack=[[UIImageView alloc] initWithFrame:CGRectMake(0, 13, 12.5, 20.5)];
        [imgBack setImage:[UIImage imageNamed:@"iconBack"]];
        [self addSubview:imgBack];
    }
    return self;
}

@end