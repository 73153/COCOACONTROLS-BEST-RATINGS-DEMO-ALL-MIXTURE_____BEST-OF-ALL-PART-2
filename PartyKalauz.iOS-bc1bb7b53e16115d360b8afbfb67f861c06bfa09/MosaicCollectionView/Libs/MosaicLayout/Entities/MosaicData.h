//
//  MosaicData.h
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/17/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

typedef enum {
    kMosaicLayoutTypeUndefined,
    kMosaicLayoutTypeSingle,
    kMosaicLayoutTypeDouble
} MosaicLayoutType;

@interface MosaicData : NSObject

-(id)initWithDictionary:(NSDictionary *)aDict;
-(id)initWithPFObject:(PFObject *)object;

@property (strong) NSString *imageFilename;
@property (strong) NSString *title;
@property (strong) NSString *fbLink;
@property (strong) NSString *attending;
@property (assign) float longitude;
@property (assign) float latitude;
@property (assign) BOOL firstTimeShown;
@property (assign) MosaicLayoutType layoutType;
@property (assign) float relativeHeight;
@end
