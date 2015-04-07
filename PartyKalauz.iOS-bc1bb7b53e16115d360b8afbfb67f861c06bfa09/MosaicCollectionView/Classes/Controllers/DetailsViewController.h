//
//  DetailsViewController.h
//  MosaicCollectionView
//
//  Created by Zsombor Fuszenecker on 15/01/2015.
//  Copyright (c) 2015 Betzerra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mapbox.h"

@interface DetailsViewController : UIViewController <UIWebViewDelegate, RMMapViewDelegate>{
}
@property (nonatomic) NSString *fbLink;
@property (assign) float longitude;
@property (assign) float latitude;
@property (assign) NSString* barName;

@end
