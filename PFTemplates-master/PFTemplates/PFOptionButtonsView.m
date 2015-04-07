//
//  TLOptionButtonsView.m
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFOptionButtonsView.h"

@implementation PFOptionButtonsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _optionTemplateBtn=[[PFOptionTemplateBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.height) andImg:[UIImage imageNamed:@"iconTemplateSelect"]];
        [self addSubview:_optionTemplateBtn];
        
        _optionColorBtn=[[PFOptionTemplateBtn alloc] initWithFrame:CGRectMake(self.frame.size.width/3, 0, self.frame.size.width/3, self.frame.size.height) andImg:[UIImage imageNamed:@"iconColor"]];
        [self addSubview:_optionColorBtn];
        
        _optionCropBtn=[[PFOptionTemplateBtn alloc] initWithFrame:CGRectMake(self.frame.size.width/3*2, 0, self.frame.size.width/3, self.frame.size.height) andImg:[UIImage imageNamed:@"iconCrop"]];
        [self addSubview:_optionCropBtn];
        
        
        
        _imgArrowSelectOption=[[PFImageView alloc] initWithFrame:CGRectMake(_optionTemplateBtn.frame.size.width/2-10, self.frame.size.height-9, 20, 9)];
        [_imgArrowSelectOption setImage:[UIImage imageNamed:@"frecciaSelect"]];
        [self addSubview:_imgArrowSelectOption];
    }
    return self;
}

@end