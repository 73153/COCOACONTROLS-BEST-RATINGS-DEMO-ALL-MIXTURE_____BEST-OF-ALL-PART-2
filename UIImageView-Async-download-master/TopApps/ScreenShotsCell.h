//
//  ScreenShotsCell.h
//  Top Apps
//
//  Created by Vinodh  on 27/12/14.
//  Copyright (c) 2014 Daston~Rhadnojnainva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class App;
@interface ScreenShotsCell : UITableViewCell
@property (nonatomic, weak) UIViewController *parentViewController;
- (void)configureCellForApp:(App *)app;
@end
