//
//  MapViewController.h
//  Party Kalauz
//
//  Created by Zsombor Fuszenecker on 01/02/15.
//  Copyright (c) 2015 Zsombor Fuszenecker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mapbox.h"

@interface MapViewController : UIViewController <RMMapViewDelegate>{
    
}

@property (assign) NSArray* allEvents;
@property (assign) float longitude;
@property (assign) float latitude;
@property (assign) NSString* barName;
@property (assign) BOOL comingFromDetails;
    
@end
