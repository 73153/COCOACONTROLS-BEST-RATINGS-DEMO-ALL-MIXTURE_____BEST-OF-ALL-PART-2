//
//  TLTemplateBtn.m
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFTemplateBtn.h"

@implementation PFTemplateBtn

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)strTitle andStrImg:(NSString *)strImg
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
       
        [self.titleLabel setFont:fontMerriweatherItalic(11)];

        
        [self setTitle:strTitle forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        self.contentVerticalAlignment=UIControlContentVerticalAlignmentBottom;
        self.contentEdgeInsets=UIEdgeInsetsMake(0, 0, 15, 0);
        
        UIView *viewRigaDestra=[[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-1, 0, 1, self.frame.size.height)];
        viewRigaDestra.backgroundColor=[UIColor whiteColor];
        [self addSubview:viewRigaDestra];
        
        PFImageView *imgCop=[[PFImageView alloc] initWithFrame:CGRectMake(15, 15, 60, 90)];
        [imgCop setImage:[UIImage imageNamed:strImg]];
        [self addSubview:imgCop];
    }
    return self;
}

@end