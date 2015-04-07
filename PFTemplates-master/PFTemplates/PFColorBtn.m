//
//  TLColorBtn.m
//  PFTemplates
//
//  Created by Paolo Furlan on 20/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFColorBtn.h"

@implementation PFColorBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius=5.0;
        self.layer.masksToBounds=YES;
    }
    return self;
}

@end