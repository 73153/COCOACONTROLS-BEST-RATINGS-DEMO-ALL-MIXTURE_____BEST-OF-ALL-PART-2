//
//  TLColorTemplateView.h
//  PFTemplates
//
//  Created by Paolo Furlan on 20/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFColorDelegate <NSObject>

-(void)colorSelected:(UIColor *)color;

@end

@interface PFColorTemplateView : UIView

- (id)initWithFrame:(CGRect)frame andArrayColors:(NSArray *)arrayColors;

@property (nonatomic, weak) id <PFColorDelegate> delegate;

-(void)setColors:(NSArray *)arrayColors andIndex:(int)index;

@end