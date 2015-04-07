//
//  JKDataSource.h
//  JKDataSourceDemo
//
//  Created by Joseph Ridenour on 6/29/13.
//  Copyright (c) 2013 Joseph Ridenour. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This class is intended to make tableView datasource/delegate
 *  binding to data more abstract.
 *
 *  This class is meant to be overriden to add your own custom datasources
 **/


/**
 *  Block Defines
 **/
typedef NSArray *(^JKDataSourceDelegateDataFilterHandler)(NSString *filterText);

@interface JKDataSource : NSObject
<NSCoding,UISearchBarDelegate>
{
    UISearchBar *_filterSearchBar;
}

/**
 *  The actual tableData.
 *  This should be an array of arrays if you want to handle sections
 *
 *  The list can contain whatever you want. However, it will only put text on the cell
 *  if you give it strings.
 **/
@property (nonatomic, strong) NSArray *data;




/** @name Filtering **/

/**
 *  If you use data filtering and you would not like the searchbar to be the
 *  header of the table you can set that here.  Or we will set it for you
 **/
@property (nonatomic, strong) IBOutlet UISearchBar *filterSearchBar;

/**
 *  Determines if we show a searchbar as the header of the tableview
 *  and allow the user to filter the data
 *
 *  Defaults: YES
 **/
@property (nonatomic, assign, getter = canFilter) BOOL allowsFiltering;

/**
 *  Set this if you want to handle the dataFiltering yourself.
 *  
 *  So whenever text is entered in the search bar this will get called
 *  and the table will be filtered with the return array
 **/
@property (nonatomic, copy) JKDataSourceDelegateDataFilterHandler dataFilterHandler;



/** @name Overrides **/

/**
 *  All of these methods should be overwridden in any subclasses.
 *
 **/

- (NSArray *)filteredData;      // This gets used only when filtering
- (NSArray *)currentData;       // Either filtered search data or self.tableData
- (BOOL)hasSections;            // Helper to determine if currentData is sectioned or not


/**
 *  Override these in your to do custom filtering
 *  Otherwise we can only assume that the tableData given is an 
 *  array of strings
 **/
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;
@end
