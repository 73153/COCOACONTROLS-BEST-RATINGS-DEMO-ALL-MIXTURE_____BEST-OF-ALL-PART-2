//
//  TLTemplatesViewController.m
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFTemplatesViewController.h"

@interface PFTemplatesViewController ()

@end

@implementation PFTemplatesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Load graphics
-(void)loadGraphics
{
    UIView *viewRiga=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2)];
    viewRiga.backgroundColor=colorGray245;
    [self.view addSubview:viewRiga];

    _optionButtonsView=[[PFOptionButtonsView alloc] initWithFrame:CGRectMake(0, getBottomView(viewRiga), self.view.frame.size.width, 60)];
    [_optionButtonsView.optionTemplateBtn addTarget:self action:@selector(templates) forControlEvents:UIControlEventTouchUpInside];
    [_optionButtonsView.optionColorBtn addTarget:self action:@selector(colors) forControlEvents:UIControlEventTouchUpInside];
    [_optionButtonsView.optionCropBtn addTarget:self action:@selector(crop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_optionButtonsView];
    
    _scrollTemplatesView=[[PFScrollTemplatesView alloc] initWithFrame:CGRectMake(0, getBottomView(_optionButtonsView), self.view.frame.size.width, self.view.frame.size.height-getBottomView(_optionButtonsView))];
    _scrollTemplatesView.imgCover=_imgCover;
    [self.view addSubview:_scrollTemplatesView];
    
    for(id key in [_scrollTemplatesView.dataTemplates objectAtIndex:_scrollTemplatesView.viewSel.tag]){
        NSArray *arrayColors=[[[_scrollTemplatesView.dataTemplates objectAtIndex:_scrollTemplatesView.viewSel.tag] objectForKey:key] objectForKey:@"array"];
        
        _colorTemplateView=[[PFColorTemplateView alloc] initWithFrame:CGRectMake(0, getBottomView(_optionButtonsView), self.view.frame.size.width, self.view.frame.size.height-getBottomView(_optionButtonsView)) andArrayColors:arrayColors];
        [self.view addSubview:_colorTemplateView];
        _colorTemplateView.alpha=0.0;
    }
}

#pragma mark - Tap on templates button
-(void)templates
{
    [self changeAnimatedArrow:_optionButtonsView.optionTemplateBtn.frame.size.width/2];
    
    [_optionButtonsView.optionTemplateBtn.imgBtn setImage:[UIImage imageNamed:@"iconTemplateSelect"]];
    [_optionButtonsView.optionColorBtn.imgBtn setImage:[UIImage imageNamed:@"iconColor"]];
    [_optionButtonsView.optionCropBtn.imgBtn setImage:[UIImage imageNamed:@"iconCrop"]];
    
    [UIView animateWithDuration:0.1 animations:^{
        _scrollTemplatesView.alpha=1.0;
        _colorTemplateView.alpha=0.0;
    }];
}

#pragma mark - Tap on color button
-(void)colors
{
    [self changeAnimatedArrow:_optionButtonsView.optionColorBtn.frame.origin.x+_optionButtonsView.optionColorBtn.frame.size.width/2];

    [_optionButtonsView.optionTemplateBtn.imgBtn setImage:[UIImage imageNamed:@"iconTemplate"]];
    [_optionButtonsView.optionColorBtn.imgBtn setImage:[UIImage imageNamed:@"iconColorSelect"]];
    [_optionButtonsView.optionCropBtn.imgBtn setImage:[UIImage imageNamed:@"iconCrop"]];
    
    [self loadTemplateColors];
    [UIView animateWithDuration:0.1 animations:^{
        _scrollTemplatesView.alpha=0.0;
        _colorTemplateView.alpha=1.0;
    }];
}

#pragma mark - Tap on crop button
-(void)crop
{
    [self changeAnimatedArrow:_optionButtonsView.optionCropBtn.frame.origin.x+_optionButtonsView.optionCropBtn.frame.size.width/2];

    [_optionButtonsView.optionTemplateBtn.imgBtn setImage:[UIImage imageNamed:@"iconTemplate"]];
    [_optionButtonsView.optionColorBtn.imgBtn setImage:[UIImage imageNamed:@"iconColor"]];
    [_optionButtonsView.optionCropBtn.imgBtn setImage:[UIImage imageNamed:@"iconCropSelect"]];
    
    [self loadCrop];
}


//animate the arrow when the button is tapped
-(void)changeAnimatedArrow:(float)x{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame=_optionButtonsView.imgArrowSelectOption.frame;
        frame.origin.x=x-_optionButtonsView.imgArrowSelectOption.frame.size.width/2;
        _optionButtonsView.imgArrowSelectOption.frame=frame;
    }];
}

#pragma mark - Load graphics colors template
-(void)loadTemplateColors
{
    for(id key in [_scrollTemplatesView.dataTemplates objectAtIndex:_scrollTemplatesView.viewSel.tag]){
        NSArray *arrayColors=[[[_scrollTemplatesView.dataTemplates objectAtIndex:_scrollTemplatesView.viewSel.tag] objectForKey:key] objectForKey:@"array"];

        [_colorTemplateView setColors:arrayColors andIndex:_scrollTemplatesView.indexColor];
        _colorTemplateView.alpha=0.0;
    }
}


-(void)loadCrop
{
    //set the ratio of the crop section
    float ratio=0;
    int tag=(int)(_scrollTemplatesView.viewSel.tag);
    
    if(tag==0){
        ratio=0.67;
    }else if (tag==1){
        ratio=0.67;
    }else if (tag==2){
        ratio=1.0;
    }else if (tag==3){
        ratio=1.08108;
    }else if (tag==4){
        ratio=0.67;
    }else if (tag==5){
        ratio=1.38211;
    }else if (tag==6){
        ratio=0.81269;
    }else if (tag==7){
        ratio=1.08108;
    }else if (tag==8){
        ratio=1.08108;
    }else if (tag==9){
        ratio=1.53846;
    }else if (tag==10){
        ratio=0.81967;
    }else if (tag==11){
        ratio=1.0;
    }
    
    
    float ratioImgCaricata=_imgCover.size.width/_imgCover.size.height;
    
    UIImage *img=[[PFUtils sharedInstance] imageWithImage:_imgCover scaledToWidth:320.0];
    float w=img.size.width;
    float h=img.size.height;
    
    
    float widthRatio=0;
    float heightRatio=0;
    
    if (ratioImgCaricata > ratio) {
        widthRatio =   (h * ratio);
        heightRatio = h;
    } else {
        widthRatio = w;
        heightRatio = (w / ratio);
    }
    
    float widthCrop;
    float heightCrop;
    if(kHeight>500){
        widthCrop=300;
        heightCrop=(300*heightRatio)/widthRatio;
    }else{
        widthCrop=250;
        heightCrop=(250*heightRatio)/widthRatio;
    }
    
    
    [_delegate cropTemplate:_imgCover andRectCrop:CGRectMake(self.view.frame.size.width/2-widthCrop/2, 80, widthCrop, heightCrop)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end