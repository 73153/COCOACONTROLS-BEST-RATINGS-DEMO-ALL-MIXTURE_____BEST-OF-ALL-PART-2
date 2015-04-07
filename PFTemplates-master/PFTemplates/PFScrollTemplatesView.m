//
//  TLScrollTemplatesView.m
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFScrollTemplatesView.h"

#import "PFTemplateBtn.h"


@interface PFScrollTemplatesView ()

@end

@implementation PFScrollTemplatesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollViewTemplates=[[PFScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollViewTemplates.backgroundColor=colorGray245;
        [self addSubview:_scrollViewTemplates];
        
        //all the colors of the template
        NSArray *arrayTemplateColors2=[[NSArray alloc] initWithObjects:@"8A8A8A",@"DD705D",@"DDC35D",@"619D65",@"90CBCB",@"5E85AC",@"C87994", nil];
        NSArray *arrayTemplateColors3=[[NSArray alloc] initWithObjects:@"DDDDDD",@"D7ADAD",@"D7C9AD",@"DAE9C9",@"C9E4E2",@"C9D4E4",@"D9D2E4", nil];
        NSArray *arrayTemplateColors4=[[NSArray alloc] initWithObjects:@"1E1E1E",@"792727",@"493214",@"2C512F",@"608F92",@"2A3C60",@"5C3E58", nil];
        
        NSArray *arrayTemplateColors5=[[NSArray alloc] initWithObjects:@"000000",@"1A2137",@"FFFFFF", nil];
        NSArray *arrayTemplateColors6=[[NSArray alloc] initWithObjects:@"000000",@"FFFFFF",@"581313",@"2F4C54",@"608F92",@"22264E",@"75BFAE", nil];
        NSArray *arrayTemplateColors7=[[NSArray alloc] initWithObjects:@"7FAACD",@"FFFFFF",@"FF8686",@"7BCD89",@"7BCDC7",@"897FCD",@"E3B25C", nil];
        
        NSArray *arrayTemplateColors8=[[NSArray alloc] initWithObjects:@"4A4A4A",@"C55656",@"C5A756",@"59815C",@"7DC7CB",@"375A7A",@"5C3E58", nil];
        NSArray *arrayTemplateColors9=[[NSArray alloc] initWithObjects:@"4A4A4A",@"C55656",@"C5A756",@"59815C",@"7DC7CB",@"375A7A",@"5C3E58", nil];
        
        NSArray *arrayTemplateColors10=[[NSArray alloc] initWithObjects:@"000000",@"1A2137",@"FFFFFF", nil];
        
        NSArray *arrayTemplateColors11=[[NSArray alloc] initWithObjects:@"000000",@"FFFFFF",@"FF9C9C",@"FAE181",@"6DD090",@"383071",@"6DA2D0", nil];
        NSArray *arrayTemplateColors12=[[NSArray alloc] initWithObjects:@"FF9C9C",@"F3B27E",@"8FC38A",@"9FCFCB",@"84ADCD",@"8884CD",@"CD84B8", nil];

        _dataTemplates = @[
                           @{@"Original" : @{@"image":@"copertina1", @"array":@[]}},
                           
                           @{@"Edgar Allan" : @{@"image":@"copertina4", @"array":arrayTemplateColors4}},
                           
                           @{@"Charles" : @{@"image":@"copertina6", @"array":arrayTemplateColors6}},
                           
                           @{@"Dante" : @{@"image":@"copertina8", @"array":arrayTemplateColors8}},
                           
                           @{@"Chuck" : @{@"image":@"copertina5", @"array":arrayTemplateColors5}},
                           
                           @{@"Leo" : @{@"image":@"copertina2", @"array":arrayTemplateColors2}},
                           
                           @{@"Ernest" : @{@"image":@"copertina3", @"array":arrayTemplateColors3}},
                           
                           @{@"Virginia" : @{@"image":@"copertina7", @"array":arrayTemplateColors7}},
                           
                           @{@"Agatha" : @{@"image":@"copertina9", @"array":arrayTemplateColors9}},
                           
                           @{@"George" : @{@"image":@"copertina11", @"array":arrayTemplateColors11}},
                           
                           @{@"Gabriel" : @{@"image":@"copertina10", @"array":arrayTemplateColors10}},
                           
                           @{@"Mark" : @{@"image":@"copertina12", @"array":arrayTemplateColors12}}
                  ];

        [self initTemplates];
    }
    return self;
}

#pragma mark - Init button templates
-(void)initTemplates
{
    _indexColor=0;
    
    for (NSInteger i = 0 ; i < [_dataTemplates count]; ++i) {
        PFTemplateBtn *template = [self createButtonWithIndex:i];
        if(i==0){
            [template.titleLabel setFont:fontMerriweatherHeavyItalic(11)];
        }
        template.tag=i+1;
        [_scrollViewTemplates addSubview:template];
        [_scrollViewTemplates setContentSize:CGSizeMake(getRightView(template), self.frame.size.height)];
    }
}

- (PFTemplateBtn *)createButtonWithIndex:(NSInteger)index
{
    NSString *strTitle=@"";
    NSString *strImgTemplate=@"";
    for(id key in [_dataTemplates objectAtIndex:index]){
        strTitle=[NSString stringWithFormat:@"%@", key];
        strImgTemplate=[NSString stringWithFormat:@"%@", [[[_dataTemplates objectAtIndex:index] objectForKey:key] objectForKey:@"image"]];
    }

    PFTemplateBtn *btnLocal=[[PFTemplateBtn alloc] initWithFrame:CGRectMake(index*95, 0, 95, 140) andTitle:strTitle andStrImg:strImgTemplate];
    [btnLocal addTarget:self action:@selector(targetTemplateBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    if(index==0){
        _viewSel=[[UIView alloc] initWithFrame:CGRectMake(0, btnLocal.frame.size.height-6, btnLocal.frame.size.width-1, 6)];
        _viewSel.backgroundColor=rgb2Color(143, 201, 207);
        _viewSel.tag=index+1;
        [btnLocal addSubview:_viewSel];
    }

    btnLocal.tag=index;

    return btnLocal;
}


#pragma mark - Target template button
-(void)targetTemplateBtn:(PFTemplateBtn *)sender
{
    PFTemplateBtn *templateBtn = (PFTemplateBtn *)[_scrollViewTemplates viewWithTag:_viewSel.tag];
    if([templateBtn respondsToSelector:@selector(titleLabel)]){
        [templateBtn.titleLabel setFont:fontMerriweatherItalic(11)];
    }

    [_viewSel removeFromSuperview];
    _viewSel.alpha=0.0;
    _viewSel.tag=sender.tag;
    [sender addSubview:_viewSel];
    [UIView animateWithDuration:0.2 animations:^{
        _viewSel.alpha=1.0;
    }];
    
   [sender.titleLabel setFont:fontMerriweatherHeavyItalic(11)];


    CGPoint modulo = [sender.superview convertPoint:sender.frame.origin toView:nil];
    
    if(modulo.x>=kWidth/2){
        [_scrollViewTemplates scrollRectToVisible:CGRectMake(sender.frame.origin.x-160, 0, _scrollViewTemplates.frame.size.width, _scrollViewTemplates.frame.size.height) animated:YES];
    }else{
        [_scrollViewTemplates scrollRectToVisible:CGRectMake(sender.frame.origin.x-120, 0, _scrollViewTemplates.frame.size.width, _scrollViewTemplates.frame.size.height) animated:YES];
    }
    
    //here you should call a delegate method for the main viewcontroller to change the image
}

@end