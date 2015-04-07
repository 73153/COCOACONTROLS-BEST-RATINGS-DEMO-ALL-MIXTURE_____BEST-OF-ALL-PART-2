//
//  TLNoColorLbl.m
//  PFTemplates
//
//  Created by Paolo Furlan on 20/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFNoColorLbl.h"

@implementation PFNoColorLbl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font=[UIFont fontWithName:@"HelveticaNeue" size:15];
        self.textColor=colorTextBlack;
        self.textAlignment=NSTextAlignmentCenter;
        self.numberOfLines=-1;
        self.lineBreakMode=NSLineBreakByWordWrapping;
        self.text=NSLocalizedString(@"No color options for this theme", nil);
    }
    return self;
}

@end