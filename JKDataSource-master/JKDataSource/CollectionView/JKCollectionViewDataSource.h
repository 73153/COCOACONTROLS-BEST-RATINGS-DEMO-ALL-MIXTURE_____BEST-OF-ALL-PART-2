//
//  JKCollectionViewDataSource.h
//  JKDataSourceDemo
//
//  Created by Joseph Ridenour on 9/20/13.
//  Copyright (c) 2013 Joseph Ridenour. All rights reserved.
//

#import "JKDataSource.h"

typedef NSString *(^JKDSCCellIDHandler)(id item,NSIndexPath *indexPath);
typedef void(^JKDSCCellConfigureHandler)(UICollectionViewCell*cell,id item,NSIndexPath*indexPath);

@interface JKCollectionViewDataSource : JKDataSource <UICollectionViewDataSource,UICollectionViewDelegate>


/**
 *  The tableView you want us to take care of for you
 **/
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

/**
 *  Set these if you want to pass through the raw tableview datasource/delegate methods.
 *  @note you should set these OR the block methods.  Not both
 **/
@property (nonatomic, weak) IBOutlet id <UICollectionViewDataSource> proxyDatasource;
@property (nonatomic, weak) IBOutlet id <UICollectionViewDelegate> proxyDelegate;


/**
 *  Return the cell id for the given item/indexpath
 *  Otherwise we will just use the datasouce class name as the cell id
 **/
@property (nonatomic, copy) JKDSCCellIDHandler cellIDHandler;
/**
 *  Passes the cell, raw item from tableData (or filteredData), and the indexPath for that item
 **/
@property (nonatomic, copy) JKDSCCellConfigureHandler cellConfigurationHandler;


/** @name Overrides **/

/**
 *  This gets called for every row.  If the `cellConfigurationHandler` is set
 *  Then it will use that for customization.  Otherwise it will set the cell.textLabel.text
 *  to whatever string is given
 **/
- (void)customizeCell:(UICollectionViewCell *)cell
             withItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath;
@end
