//
//  ViewController.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 4/21/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "CustomViewController.h"
#import "MosaicLayout.h"
#import "MosaicData.h"
#import "CustomDataSource.h"
#import "DetailsViewController.h"
#import "MosaicCell.h"
#import "FilterViewController.h"
#import "ILTranslucentView.h"
#import "MapViewController.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import "CalendarViewController.h"

#define kDoubleColumnProbability 0

NSArray* filteredResults;

@interface CustomViewController () <CustomDataSourceProtocolDelegate>
- (IBAction)refreshButton:(id)sender;
@end

@implementation CustomViewController

bool filtering = NO;
CGPoint oldPosition;
bool firstStart = YES;

-(void) dateSelected:(NSDate *) date
{
    [(CustomDataSource *)_collectionView.dataSource searchForDate:date];
}

-(void) putFilterButtonBack
{
    if(filtering)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5f];
        _filterMaterialButton.center = oldPosition;
        _filterMaterialButton.transform=CGAffineTransformMakeRotation(0);
        [UIView commitAnimations];
        oldPosition = CGPointZero;
        filtering = NO;
        //[_filterView removeFromSuperview];
    }
}

-(void) processCompletedWith:(NSArray *)results
{
    filteredResults = results;
    [activityIndicator removeFromSuperview];
    [_collectionView reloadData];
}

-(void) processCompleted
{
    [activityIndicator removeFromSuperview];
    [_collectionView reloadData];
}

-(void) resetCollectionView
{
    [_collectionView reloadData];
}

- (IBAction)refreshButton:(id)sender{
    if(activityIndicator)
        [activityIndicator removeFromSuperview];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    activityIndicator.hidesWhenStopped = NO;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    [(CustomDataSource *)_collectionView.dataSource searchFor:@"2015-01-17"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetailSegue"])
    {
        [self putFilterButtonBack];

        DetailsViewController *detailVC = (DetailsViewController *)segue.destinationViewController;
        MosaicCell *selectedCell = (MosaicCell *)sender;
        detailVC.fbLink = selectedCell.mosaicData.fbLink;
        detailVC.longitude = selectedCell.mosaicData.longitude;
        detailVC.latitude = selectedCell.mosaicData.latitude;
        detailVC.barName = selectedCell.mosaicData.title;
    }
    else if ([segue.identifier isEqualToString:@"results_showMap"])
    {
        if([segue.identifier isEqualToString:@"results_showMap"])
        {
            MapViewController *mapVC = (MapViewController*)segue.destinationViewController;
            mapVC.comingFromDetails = NO;
            mapVC.allEvents = filteredResults;
        }
    }
    else if ([segue.identifier isEqualToString:@"showCalendar"])
    {
        CalendarViewController* calendarVC = (CalendarViewController *) segue.destinationViewController;
        calendarVC.delegate = self;
    }
}

#pragma mark - Public

- (void) viewDidAppear:(BOOL)animated
{
    if(firstStart)
    {
        [super viewDidAppear:YES];
        [Parse setApplicationId:@"l0CkJMluS2GJjp8ETH4h5c96AODSPMIaJV6aHWUy"
                  clientKey:@"cSQYwQv7goaKinyXwX5EWC94rZZSHIXawkxqC3Uh"];
        // Do a search for today
        NSDate* todaysDate = [[NSDate alloc] init];
    
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
    
        NSString *stringFromDate = [formatter stringFromDate:todaysDate];
        
        [(CustomDataSource *)_collectionView.dataSource searchFor:stringFromDate];
        
        firstStart = NO;
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"layutsubviews");
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.alpha = 1.0;
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    activityIndicator.hidesWhenStopped = NO;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    
    _filterView = [[ILTranslucentView alloc] initWithFrame:CGRectMake(10, self.view.center.y - 20, self.view.frame.size.width-20, self.view.frame.size.height/2 - 50)];
    _filterView.layer.cornerRadius = 10;
    _filterView.layer.masksToBounds = YES;
   
    [(CustomDataSource *)_collectionView.dataSource setDelegate:self];
    [(MosaicLayout *)_collectionView.collectionViewLayout setDelegate:self];
    
    // Filter Button Shadow
    _filterMaterialButton.layer.cornerRadius = 8.0f;
    
    _filterMaterialButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _filterMaterialButton.layer.shadowOpacity = 0.8;
    _filterMaterialButton.layer.shadowRadius = 8;
    _filterMaterialButton.layer.shadowOffset = CGSizeMake(0, 0);
    [_filterMaterialButton addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Map Button Shadow
    _mapMaterialButton.layer.cornerRadius = 8.0f;
    
    _mapMaterialButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _mapMaterialButton.layer.shadowOpacity = 0.8;
    _mapMaterialButton.layer.shadowRadius = 8;
    _mapMaterialButton.layer.shadowOffset = CGSizeMake(0, 0);
    [_mapMaterialButton addTarget:self action:@selector(mapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)mapButtonPressed:(id)sender
{
    
}

-(void)filterButtonPressed:(id)sender
{
    // Do a search for today
    NSDate* todaysDate = [[NSDate alloc] init];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *stringFromDate = [formatter stringFromDate:todaysDate];
    
    [(CustomDataSource *)_collectionView.dataSource searchFor:stringFromDate];
    
    if(oldPosition.x == 0 && oldPosition.y == 0)
    {
        oldPosition = CGPointMake(_filterMaterialButton.center.x, _filterMaterialButton.center.y);
        CGPoint newPosition = CGPointMake( self.view.frame.size.width - 45,
                                      self.view.frame.size.height/2 - 70);
        filtering = YES;

        [UIView animateWithDuration:.2f
                              delay:0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             //_filterMaterialButton.transform=CGAffineTransformMakeRotation(M_PI / -4);
                             _filterMaterialButton.center = newPosition;
                         }
                         completion:^(BOOL finished){
                             if(filtering)
                             {
                                 // show Filter View
                                 //[self.view addSubview:_filterView];
//                                 _filterView.translucentAlpha = 0.95;
//                                 _filterView.translucentStyle = UIBarStyleBlackTranslucent;
//                                 _filterView.translucentTintColor = [UIColor blackColor];
//                                 _filterView.backgroundColor = [UIColor clearColor];
                                 
                             }
                         }];
        CGPoint offset = _collectionView.contentOffset;
        [_collectionView setContentOffset:offset animated:NO];
        
        
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.2f];
        _filterMaterialButton.center = oldPosition;
        _filterMaterialButton.transform=CGAffineTransformMakeRotation(0);
        [UIView commitAnimations];
        oldPosition = CGPointZero;
        filtering = NO;
        
        // Remove Filter View
        //[_filterView removeFromSuperview];

    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
   // [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    MosaicLayout *layout = (MosaicLayout *)_collectionView.collectionViewLayout;
    [layout invalidateLayout];
}



#pragma mark - MosaicLayoutDelegate

-(float)collectionView:(UICollectionView *)collectionView relativeHeightForItemAtIndexPath:(NSIndexPath *)indexPath{

    //  Base relative height for simple layout type. This is 1.0 (height equals to width)
    float retVal = 1.0;
    
    NSMutableArray *elements = [(CustomDataSource *)_collectionView.dataSource elements];
    MosaicData *aMosaicModule = [elements objectAtIndex:indexPath.row];
    
    if (aMosaicModule.relativeHeight != 0){

        //  If the relative height was set before, return it
        retVal = aMosaicModule.relativeHeight;
        
    }else{
        
        BOOL isDoubleColumn = [self collectionView:collectionView isDoubleColumnAtIndexPath:indexPath];
        if (isDoubleColumn){
            //  Base relative height for double layout type. This is 0.75 (height equals to 75% width)
            retVal = 0.75;
        }
        
        /*  Relative height random modifier. The max height of relative height is 25% more than
         *  the base relative height */
        
        float extraRandomHeight = arc4random() % 25;
        retVal = retVal + (extraRandomHeight / 100);
        
        /*  Persist the relative height on MosaicData so the value will be the same every time
         *  the mosaic layout invalidates */
        
        aMosaicModule.relativeHeight = retVal;
    }
    
    return retVal;
}

-(BOOL)collectionView:(UICollectionView *)collectionView isDoubleColumnAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *elements = [(CustomDataSource *)_collectionView.dataSource elements];
    MosaicData *aMosaicModule = [elements objectAtIndex:indexPath.row];
    
    if (aMosaicModule.layoutType == kMosaicLayoutTypeUndefined){
        
        /*  First layout. We have to decide if the MosaicData should be
         *  double column (if possible) or not. */
        
        NSUInteger random = arc4random() % 100;
        //if (random < kDoubleColumnProbability){
           // aMosaicModule.layoutType = kMosaicLayoutTypeDouble;
        //}else{
            aMosaicModule.layoutType = kMosaicLayoutTypeSingle;
        //}
    }
    
    BOOL retVal = aMosaicModule.layoutType == kMosaicLayoutTypeDouble;
    
    return retVal;
    
}

-(NSUInteger)numberOfColumnsInCollectionView:(UICollectionView *)collectionView{
    
    UIInterfaceOrientation anOrientation = self.interfaceOrientation;
    
    //  Set the quantity of columns according of the device and interface orientation
    NSUInteger retVal = 0;
    if (UIInterfaceOrientationIsLandscape(anOrientation)){
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            retVal = kColumnsiPadLandscape;
        }else{
            retVal = kColumnsiPhoneLandscape;
        }
        
    }else{
        
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
            retVal = kColumnsiPadPortrait;
        }else{
            retVal = kColumnsiPhonePortrait;
        }
    }
        
    return retVal;
}

@end
