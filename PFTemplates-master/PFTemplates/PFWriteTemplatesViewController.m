//
//  TLWriteTemplatesViewController.m
//  PFTemplates
//
//  Created by Paolo Furlan on 14/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import "PFWriteTemplatesViewController.h"

#import "PFTemplatesViewController.h"

#import "VPImageCropperViewController.h"

#import "PFColorTemplateView.h"

#import "PFImageView.h"
#import "PFScrollView.h"

@interface PFWriteTemplatesViewController () <VPImageCropperDelegate, UIAlertViewDelegate, PFScrollTemplatesDelegate>
{
    PFImageView *imageViewTemplate;
    
    PFTemplatesViewController *templatesView;

    NSInteger templateNumber;
    UIColor *templateColor;
    
    UIImage *imgCropped;
}

@end

@implementation PFWriteTemplatesViewController


-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItem];
    [self loadGraphics];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor= [UIColor colorWithRed:255.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark Set navigation item
-(void)setNavigationItem
{
    //back button in the navigation bar
    PFBackBtn *backBtn=[[PFBackBtn alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonsL = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = buttonsL;
    
    //title in the navigation bar
    PFTitleLbl *lblTitle=[[PFTitleLbl alloc] initWithFrame:CGRectMake(0, 0, 140, 44)];
    lblTitle.text=NSLocalizedString(@"TEMPLATE", nil);
    self.navigationItem.titleView=lblTitle;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Load graphics
-(void)loadGraphics
{
    imgCropped=nil;
    self.view.backgroundColor=[UIColor whiteColor];
    
    //set the image of the template
    if(kHeight>480){
        imageViewTemplate=[[PFImageView alloc] initWithFrame:CGRectMake(kWidth/2-85, 20, 170, 255)];
    }else{
        imageViewTemplate=[[PFImageView alloc] initWithFrame:CGRectMake(kWidth/2-60, 20, 120, 180)];
    }
    [imageViewTemplate setImage:[UIImage imageNamed:@"copertina1"]];
    [self.view addSubview:imageViewTemplate];

    
    //set the templates view at the bottom
    templatesView=[[PFTemplatesViewController alloc] init];
    templatesView.view.frame=CGRectMake(0, kHeight-264, kWidth, 264);
    templatesView.imgCover=_imgChosen;
    [templatesView loadGraphics];
    templatesView.scrollTemplatesView.delegate=self;
    [self.view addSubview:templatesView.view];
    
    templateNumber=0;
    templateColor=rgb2Color(255, 255, 255);
}

#pragma mark - Template delegate
-(void)templateCreated:(UIImage *)imgTemplate andNumber:(NSInteger)numberTemplate andColor:(UIColor *)colorTemplate
{
    templateNumber=numberTemplate;
    templateColor=colorTemplate;
    
    [imageViewTemplate setImage:imgTemplate];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [imageViewTemplate.layer addAnimation:transition forKey:nil];
}

-(void)colorSelected:(UIColor *)color
{
    templateColor=color;
}


#pragma mark - VPImageCropperDelegate+
-(void)cropTemplate:(UIImage *)image andRectCrop:(CGRect)frame
{
    VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:image cropFrame:frame limitScaleRatio:10.0];
    imgCropperVC.delegate = self;
    [self presentViewController:imgCropperVC animated:YES completion:nil];
}

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    imgCropped=editedImage;

    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [imageViewTemplate setImage:imgCropped];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.3f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [imageViewTemplate.layer addAnimation:transition forKey:nil];
    }];
}


- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:nil];
}


-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end