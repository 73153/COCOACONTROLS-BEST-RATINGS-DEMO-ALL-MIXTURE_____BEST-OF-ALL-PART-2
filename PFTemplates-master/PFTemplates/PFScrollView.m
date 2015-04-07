//
//  PFScrollView.m
//  PFTemplates
//
//  Created by Paolo Furlan on 22/09/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFScrollView.h"

@implementation PFScrollView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
    }
    return self;
}

@end