//
//  TLTitleLbl.m
//  PFTemplates
//
//  Created by Paolo Furlan on 05/09/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFTitleLbl.h"

@implementation PFTitleLbl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.textColor=[UIColor whiteColor];
        self.textAlignment=NSTextAlignmentCenter;
        self.font=fontHelveticaNeueBold(15);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)strTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.textColor=[UIColor whiteColor];
        self.textAlignment=NSTextAlignmentCenter;
        self.font=fontHelveticaNeueBold(15);
        self.text=strTitle;
    }
    return self;
}

@end