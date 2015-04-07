//
//  MapViewController.m
//  Party Kalauz
//
//  Created by Zsombor Fuszenecker on 01/02/15.
//  Copyright (c) 2015 Zsombor Fuszenecker. All rights reserved.
//

#import "MapViewController.h"
#import "Mapbox.h"
#import <Parse/Parse.h>
#define kMapboxMapID @"zsbee.l3kp64po"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RMMapView *mapView = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:[[RMMapboxSource alloc] initWithMapID:kMapboxMapID]];
    mapView.delegate = self;
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mapView.clusteringEnabled = NO;
    mapView.clusterAreaSize = CGSizeMake(25, 25);
    if(self.comingFromDetails)
    {
        mapView.zoom = 15;
        mapView.centerCoordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    
        RMAnnotation *annotation = [[RMAnnotation alloc] initWithMapView:mapView
                                                          coordinate:CLLocationCoordinate2DMake(self.latitude,self.longitude)
                                                            andTitle:self.barName];
        [mapView addAnnotation:annotation];
    }
    else
    {
        // Coming from Results View
        mapView.zoom = 10;
        // Center Budapest
        mapView.centerCoordinate = CLLocationCoordinate2DMake(47.4950043, 19.0516772);

        
        
        NSMutableArray* alreadyShown = [[NSMutableArray alloc] init];
        
        for (PFObject *event in self.allEvents) {
            PFGeoPoint *coord = [event objectForKey:@"event_coordinates"];
            float longitude = [coord longitude];

            if(longitude != 0 && ![alreadyShown containsObject:[event objectForKey:@"event_location"]])
            {
                float longitude = [coord longitude];
                float latitude = [coord latitude];
                NSString* barName = [event objectForKey:@"event_location"];
                [alreadyShown addObject:barName];

                RMAnnotation *annotation = [[RMAnnotation alloc] initWithMapView:mapView
                                                                  coordinate:CLLocationCoordinate2DMake(latitude,longitude)
                                                                    andTitle:barName];
                [mapView addAnnotation:annotation];
            }
        }
        

    }
    
    [self.view addSubview:mapView];
}

-(void)mapView:(RMMapView *)mapView didSelectAnnotation:(RMAnnotation *)annotation
{
    NSLog(@"selected");
}

-(RMMapLayer *)mapView:(RMMapView *)mapView layerForAnnotation:(RMAnnotation *)annotation
{
    if (annotation.isUserLocationAnnotation)
        return nil;
    
    RMMarker *layer = nil;
    
//    if (annotation.isClusterAnnotation)
//    {
//        layer = [[RMMarker alloc] initWithUIImage:[UIImage imageNamed:@"circle.png"]];
//        
//        layer.opacity = 0.85;
//        
//        layer.bounds = CGRectMake(0, 0, 30, 30);
//        
//        [(RMMarker *)layer setTextForegroundColor:[UIColor blackColor]];
//        
//        [(RMMarker *)layer changeLabelUsingText:[NSString stringWithFormat:@"%lu", (unsigned long)[annotation.clusteredAnnotations count]]];
//
//    }
//    else
//    {
        RMMarker *marker = [[RMMarker alloc] initWithMapboxMarkerImage:@"bar" tintColor:[UIColor whiteColor] size:RMMarkerMapboxImageSizeLarge];
        marker.canShowCallout = YES;
        
        return marker;
//    }
    
    return layer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
