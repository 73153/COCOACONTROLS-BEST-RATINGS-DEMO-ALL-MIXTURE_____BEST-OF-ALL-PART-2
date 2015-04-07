//
//  CustomDelegate.h
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/16/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CustomDataSourceProtocolDelegate <NSObject>
@required
    -(void) processCompletedWith:(NSArray*)results;
    -(void) processCompleted;
    -(void) putFilterButtonBack;
    -(void) resetCollectionView;
@end

@interface CustomDataSource : NSObject <UICollectionViewDataSource,UICollectionViewDelegate,NSURLConnectionDataDelegate>{
    

}

-(void) searchFor:(NSString *) date;
-(void)searchForDate:(NSDate *) date;

@property (readonly) NSMutableArray *elements;
@property (nonatomic, strong) id <CustomDataSourceProtocolDelegate> delegate;

@end