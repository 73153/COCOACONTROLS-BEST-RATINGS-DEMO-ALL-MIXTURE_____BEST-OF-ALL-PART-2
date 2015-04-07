//
//  TLAvantiBtn.m
//  PFTemplates
//
//  Created by Paolo Furlan on 08/09/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFNextBtn.h"

@implementation PFNextBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [self setTitle:NSLocalizedString(@"NEXT", nil)  forState:UIControlStateNormal];
    }
    return self;
}


@end
