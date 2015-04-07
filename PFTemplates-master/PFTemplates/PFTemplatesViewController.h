//
//  TLTemplatesViewController.h
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFOptionButtonsView.h"

#import "PFScrollTemplatesView.h"
#import "PFColorTemplateView.h"

@protocol PFTemplatesCropDelegate <NSObject>

-(void)cropTemplate:(UIImage *)image andRectCrop:(CGRect)frame;

@end

@interface PFTemplatesViewController : UIViewController

@property (nonatomic, weak) id <PFTemplatesCropDelegate> delegate;

@property (nonatomic, strong) PFOptionButtonsView *optionButtonsView;
@property (nonatomic, strong) PFScrollTemplatesView *scrollTemplatesView;
@property (nonatomic, strong) PFColorTemplateView *colorTemplateView;

@property (nonatomic, strong) UIImage *imgCover;

-(void)loadGraphics;

@end