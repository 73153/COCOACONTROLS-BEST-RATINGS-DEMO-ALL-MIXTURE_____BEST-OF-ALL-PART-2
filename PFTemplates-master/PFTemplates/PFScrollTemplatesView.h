//
//  TLScrollTemplatesView.h
//  PFTemplates
//
//  Created by Paolo Furlan on 16/10/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PFScrollTemplatesDelegate <NSObject>

-(void)templateCreated:(UIImage *)imgTemplate andNumber:(NSInteger)numberTemplate andColor:(UIColor *)colorTemplate;

@end


@interface PFScrollTemplatesView : UIView

@property (nonatomic, weak) id<PFScrollTemplatesDelegate> delegate;

@property (nonatomic, strong) PFScrollView *scrollViewTemplates;

@property (nonatomic, strong) NSArray *dataTemplates;

@property (nonatomic, strong) UIView *viewSel;

@property (nonatomic, strong) UIImage *imgCover;

@property int indexColor;

@end