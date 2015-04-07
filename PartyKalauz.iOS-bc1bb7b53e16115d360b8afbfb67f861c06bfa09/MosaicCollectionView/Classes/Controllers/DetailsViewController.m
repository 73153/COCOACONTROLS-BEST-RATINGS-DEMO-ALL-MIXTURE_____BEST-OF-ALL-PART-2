//
//  DetailsViewController.m
//  MosaicCollectionView
//
//  Created by Zsombor Fuszenecker on 15/01/2015.
//  Copyright (c) 2015 Betzerra. All rights reserved.
//

#import "DetailsViewController.h"
#import "Mapbox.h"
#import "MapViewController.h"

#define kMapboxMapID @"zsbee.l3kp64po"

@interface DetailsViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor blackColor];
    self.webView.delegate = self;
    [self loadWebpage:self.fbLink];
    [_spinner startAnimating];
    //Create and add the Activity Indicator to splashView
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadWebpage:(NSString *) withURL
{
    NSURL *url = [NSURL URLWithString:withURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

-(void)webViewDidFinishLoad:(UIWebView *)wv
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_spinner removeFromSuperview];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"details_showMap"])
    {
        MapViewController *mapVC = (MapViewController*)segue.destinationViewController;
        mapVC.longitude = self.longitude;
        mapVC.latitude = self.latitude;
        mapVC.barName = self.barName;
        mapVC.comingFromDetails = YES;
    }
}


@end
