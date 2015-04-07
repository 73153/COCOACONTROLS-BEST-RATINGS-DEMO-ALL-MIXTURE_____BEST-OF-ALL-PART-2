//
//  TLOptionTemplateBtn.h
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFOptionTemplateBtn : UIButton

@property (nonatomic, strong) UIImageView *imgBtn;

- (id)initWithFrame:(CGRect)frame andImg:(UIImage *)img;

@end