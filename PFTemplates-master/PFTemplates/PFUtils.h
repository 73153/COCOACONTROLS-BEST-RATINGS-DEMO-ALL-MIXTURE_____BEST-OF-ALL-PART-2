//
//  TLUtils.h
//  PFTemplates
//
//  Created by Paolo Furlan on 08/09/14.
//  Copyright (c) 2014 Paolo Furlan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PFUtils : NSObject

+(PFUtils *)sharedInstance;

-(BOOL)isConnectedInternet;

-(UIColor *)colorWithHexString:(NSString *)hexString;

-(UIImage *)imageWithImage:(UIImage*)sourceImage scaledToWidth:(float)i_width;

-(UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

@end