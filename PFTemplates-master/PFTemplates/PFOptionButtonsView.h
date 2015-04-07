//
//  TLOptionButtonsView.h
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PFOptionTemplateBtn.h"


@interface PFOptionButtonsView : UIView

@property (nonatomic, strong) PFOptionTemplateBtn *optionTemplateBtn;
@property (nonatomic, strong) PFOptionTemplateBtn *optionColorBtn;
@property (nonatomic, strong) PFOptionTemplateBtn *optionCropBtn;

@property (nonatomic, strong) PFImageView *imgArrowSelectOption;

@end