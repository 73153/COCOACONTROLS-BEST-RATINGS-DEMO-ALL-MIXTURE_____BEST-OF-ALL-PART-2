//
//  TLColorTemplateView.m
//  PFTemplates
//
//  Created by Paolo Furlan on 20/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFColorTemplateView.h"

#import "PFColorBtn.h"
#import "PFNoColorLbl.h"

#import "PFImageViewCheck.h"

@interface PFColorTemplateView () {
    UIView *viewBtns;
    PFNoColorLbl *lblNoColor;
    
    PFImageViewCheck *imgCheck;
    
    int indexColor;
}

@end

@implementation PFColorTemplateView

- (id)initWithFrame:(CGRect)frame andArrayColors:(NSArray *)arrayColors
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=colorGray245;
        
        imgCheck=[[PFImageViewCheck alloc] initWithFrame:CGRectMake(8, 8, 14, 14)];
        
        [self setColors:arrayColors andIndex:0];
    }
    return self;
}

-(void)setColors:(NSArray *)arrayColors andIndex:(int)index
{
    indexColor=index;
    [lblNoColor removeFromSuperview];
    lblNoColor=nil;
    [viewBtns removeFromSuperview];
    viewBtns=nil;
    viewBtns=[[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-(arrayColors.count*45+10)/2, 0, arrayColors.count*45+10, self.frame.size.height-60)];
    viewBtns.backgroundColor=[UIColor clearColor];
    [self addSubview:viewBtns];
    
    if(arrayColors.count!=0){
        for(int i=0; i<[arrayColors count]; i++){
            PFColorBtn *btn=[self createButton:i andColor:[[PFUtils sharedInstance] colorWithHexString:[NSString stringWithFormat:@"%@", [arrayColors objectAtIndex:i]]]];
            [viewBtns addSubview:btn];
        }
    }else{
        lblNoColor=[[PFNoColorLbl alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width-40, self.frame.size.height-100)];
        [self addSubview:lblNoColor];
    }
}

-(PFColorBtn *)createButton:(NSInteger)index andColor:(UIColor *)colorBtn
{
    PFColorBtn *button=[[PFColorBtn alloc] initWithFrame:CGRectMake(10+(index*45), viewBtns.frame.size.height/2-15, 30, 30)];
    button.tag=index;
    [button setBackgroundColor:colorBtn];
    [button addTarget:self action:@selector(targetBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexColor==index) {
        [button addSubview:imgCheck];
    }
    
    return button;
}

-(void)targetBtn:(PFColorBtn *)sender
{
    [imgCheck removeFromSuperview];
    [sender addSubview:imgCheck];
    
    [_delegate colorSelected:sender.backgroundColor];
}

@end