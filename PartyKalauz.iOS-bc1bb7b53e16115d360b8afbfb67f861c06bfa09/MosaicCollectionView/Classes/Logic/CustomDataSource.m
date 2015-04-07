//
//  CustomDelegate.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/16/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "CustomDataSource.h"
#import "MosaicData.h"
#import "MosaicCell.h"
#import <Parse/Parse.h>

@interface CustomDataSource()
    -(void)loadFromDisk;
@end

@implementation CustomDataSource

NSMutableData *webData;
NSURLConnection *connection;

#pragma mark - Private
-(void)loadFromDisk{
    _elements = [[NSMutableArray alloc] init];
    
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *parsedElements = [NSJSONSerialization JSONObjectWithData:elementsData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&anError];
    
    for (NSDictionary *aModuleDict in parsedElements){
        MosaicData *aMosaicModule = [[MosaicData alloc] initWithDictionary:aModuleDict];
        [_elements addObject:aMosaicModule];
    }
}

-(void) getDefaultResults
{
    [_elements removeAllObjects];
    [self.delegate resetCollectionView];

    PFQuery *query = [PFQuery queryWithClassName:@"Events"];
    [query whereKey:@"event_date" lessThanOrEqualTo:[NSDate date]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
//    NSURL *url = [NSURL URLWithString:[@"https://graph.facebook.com/v2.2/corvinteto/events/?fields=name,description,venue,start_time,cover,owner,location&access_token=210646005785286|8ggTWYqtHq1pRHu_BplIpbiWbDY" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    
//    connection = [NSURLConnection connectionWithRequest:req delegate:self];
//    
//    if(connection)
//    {
//        webData = [[NSMutableData alloc] init];
//    }
}

#pragma Connection delegates
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", [error localizedDescription]);
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allData = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSArray *rows = [allData objectForKey:@"data"];
    for (NSDictionary *eventDict in [[rows reverseObjectEnumerator] allObjects]) {
        MosaicData *aMosaicModule = [[MosaicData alloc] initWithDictionary:eventDict];
        [_elements addObject:aMosaicModule];
    }
    [self.delegate processCompletedWith:allData];

}

#pragma mark - Public

-(id)init{
    self = [super init];
    if (self){
        _elements = [[NSMutableArray alloc] init];

    }
    return self;
}

-(void)searchFor:(NSString *)date
{
    
    [_elements removeAllObjects];
    [self.delegate resetCollectionView];

    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    query.limit = 100;
    [query whereKey:@"event_date" greaterThanOrEqualTo:[NSDate date]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                MosaicData *aMosaicModule = [[MosaicData alloc] initWithPFObject:object];
                [_elements addObject:aMosaicModule];
            }
            [self.delegate processCompletedWith:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    //
//    NSString *urlString = @"https://graph.facebook.com/v2.2/corvinteto/events/?fields=name,description,venue,start_time,cover,owner,location&access_token=210646005785286|8ggTWYqtHq1pRHu_BplIpbiWbDY";
//    NSURL *url = [NSURL URLWithString:urlString];
//
//    NSURLRequest *req = [NSURLRequest requestWithURL:url];
//    
//    connection = [NSURLConnection connectionWithRequest:req delegate:self];
//    
//    if(connection)
//    {
//        webData = [[NSMutableData alloc] init];
//    }

}

-(void)searchForDate:(NSDate *) date
{
    
    [_elements removeAllObjects];
    [self.delegate resetCollectionView];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    query.limit = 100;
    [query whereKey:@"event_date" greaterThan:date];
    // NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    [query whereKey:@"event_date" lessThan:[date dateByAddingTimeInterval:60*60*24*1]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                MosaicData *aMosaicModule = [[MosaicData alloc] initWithPFObject:object];
                [_elements addObject:aMosaicModule];
            }
            [self.delegate processCompletedWith:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    //
    //    NSString *urlString = @"https://graph.facebook.com/v2.2/corvinteto/events/?fields=name,description,venue,start_time,cover,owner,location&access_token=210646005785286|8ggTWYqtHq1pRHu_BplIpbiWbDY";
    //    NSURL *url = [NSURL URLWithString:urlString];
    //
    //    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    //
    //    connection = [NSURLConnection connectionWithRequest:req delegate:self];
    //
    //    if(connection)
    //    {
    //        webData = [[NSMutableData alloc] init];
    //    }
    
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Nem fut le soha valamiert...
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_elements count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate putFilterButtonBack];
    static NSString *cellIdentifier = @"cell";
    MosaicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if([_elements count])
    {
        MosaicData *data = [_elements objectAtIndex:indexPath.row];
        cell.mosaicData = data;
    }
    float randomWhite = (arc4random() % 40 + 10) / 255.0;
    cell.backgroundColor = [UIColor colorWithWhite:randomWhite alpha:1];
    return cell;
}

@end
