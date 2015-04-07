//
//  JKTableViewDataSource.h
//  JKDataSourceDemo
//
//  Created by Joseph Ridenour on 9/17/13.
//  Copyright (c) 2013 Joseph Ridenour. All rights reserved.
//

#import "JKDataSource.h"

typedef NSString *(^JKDSTCellIDHandler)(id item,NSIndexPath *indexPath);
typedef void(^JKDSTCellConfigureHandler)(UITableViewCell*cell,id item,NSIndexPath*indexPath);
typedef void(^JKDSTCellSelectionHandler)(UITableViewCell*cell,id item,NSIndexPath*indexPath);

@interface JKTableViewDataSource : JKDataSource <UITableViewDataSource,UITableViewDelegate>


/**
 *  The tableView you want us to take care of for you
 **/
@property (nonatomic, strong) IBOutlet UITableView *tableView;

/**
 *  Set these if you want to pass through the raw tableview datasource/delegate methods.
 *  @note you should set these OR the block methods.  Not both
 **/
@property (nonatomic, weak) IBOutlet id <UITableViewDataSource> proxyDatasource;
@property (nonatomic, weak) IBOutlet id <UITableViewDelegate> proxyDelegate;


/**
 *  Return the cell id for the given item/indexpath
 *  Otherwise we will just use the datasouce class name as the cell id
 **/
@property (nonatomic, copy) JKDSTCellIDHandler cellIDHandler;
/**
 *  Passes the cell, raw item from tableData (or filteredData), and the indexPath for that item
 **/
@property (nonatomic, copy) JKDSTCellConfigureHandler cellConfigurationHandler;

/**
 *  Called for tableView:didSelectRowAtIndexPath:
 **/
@property (nonatomic, copy) JKDSTCellSelectionHandler cellSelectionHandler;


/** @name Overrides **/

/**
 *  This gets called for every row.  If the `cellConfigurationHandler` is set
 *  Then it will use that for customization.  Otherwise it will set the cell.textLabel.text
 *  to whatever string is given
 **/
- (void)customizeCell:(UITableViewCell *)cell
             withItem:(id)item
          atIndexPath:(NSIndexPath *)indexPath;
@end
