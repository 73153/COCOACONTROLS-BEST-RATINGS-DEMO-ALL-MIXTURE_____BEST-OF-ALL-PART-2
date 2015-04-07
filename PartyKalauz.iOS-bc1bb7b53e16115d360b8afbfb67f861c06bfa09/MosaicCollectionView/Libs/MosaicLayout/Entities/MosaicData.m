//
//  MosaicData.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/17/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "MosaicData.h"
#import "Mapbox.h"
#import <Parse/Parse.h>

@implementation MosaicData
@synthesize title, imageFilename;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        
        self.fbLink = [NSString stringWithFormat:@"http://facebook.com/%@", [aDict objectForKey:@"id"]];
        self.attending = [aDict objectForKey:@"name"];
        self.imageFilename = [[aDict objectForKey:@"cover"] objectForKey:@"source"];
        self.title = [aDict objectForKey:@"location"];
        self.longitude = [[[aDict objectForKey:@"venue"] objectForKey:@"longitude"] floatValue];
        self.latitude = [[[aDict objectForKey:@"venue"] objectForKey:@"latitude"] floatValue];
        self.firstTimeShown = YES;
    }
    return self;
}

-(id)initWithPFObject:(PFObject *)object{
    self = [self init];
    if (self){
        
        self.fbLink = [NSString stringWithFormat:@"http://facebook.com/%@", [object objectForKey:@"event_id"]];
        self.attending = [object objectForKey:@"attending_count"];
        self.imageFilename = [object objectForKey:@"event_image"];
        self.title = [object objectForKey:@"event_location"];
        PFGeoPoint *coord = [object objectForKey:@"event_coordinates"];
        self.longitude = [coord longitude];
        self.latitude = [coord latitude];
        self.firstTimeShown = YES;
    }
    return self;
}

-(NSString *)description{
    NSString *retVal = [NSString stringWithFormat:@"%@ %@", [super description], self.title];
    return retVal;
}

@end
