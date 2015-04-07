//
//  UIColor+Helper.m

//
//  Created by Reejo Samuel on 8/2/13.
//  Copyright (c) 2013 Reejo Samuel | m[at]reejosamuel.com All rights reserved.
//

#import "UIColor+Helper.h"

@implementation UIColor (Helper)

+(UIColor *)colorWithHex:(int)hex {
    
    int r = (hex >> 16) & 255;
    int g = (hex >> 8) & 255;
    int b = hex & 255;
    
    float rf = (float)r / 255.0f;
    float gf = (float)g / 255.0f;
    float bf = (float)b / 255.0f;
    
    return [UIColor colorWithRed:rf green:gf blue:bf alpha:1.0];
}

@end
