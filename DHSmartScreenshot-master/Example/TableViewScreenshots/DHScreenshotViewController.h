//
//  DHScreenshotViewController.h
//  TableViewScreenshots
//
//  Created by Hernandez Alvarez, David on 11/28/13.
//  Copyright (c) 2013 David Hernandez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHScreenshotViewController : UIViewController

@property (strong, nonatomic) UIImage *screenshot;

- (IBAction)shareButtonPressed:(id)sender;

@end
