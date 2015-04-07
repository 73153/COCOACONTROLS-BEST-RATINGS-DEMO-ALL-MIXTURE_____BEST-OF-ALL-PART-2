//
//  JKTableViewDataSource.m
//  JKDataSourceDemo
//
//  Created by Joseph Ridenour on 9/17/13.
//  Copyright (c) 2013 Joseph Ridenour. All rights reserved.
//

#import "JKTableViewDataSource.h"
#import "JKDataSource_Private.h"

@implementation JKTableViewDataSource

#pragma mark - Customize

- (void)customizeCell:(UITableViewCell *)cell
             withItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    if(self.cellConfigurationHandler)
    { self.cellConfigurationHandler(cell,item,indexPath); }
    else
    { cell.textLabel.text = item; }
}


#pragma mark - Message Forwarding

- (NSArray *)availableForwardingResponders
{
    if(!_proxyDelegate && !_proxyDatasource) return nil;
    NSMutableArray *a = [NSMutableArray array];
    if(_proxyDatasource) [a addObject:_proxyDatasource];
    if(_proxyDelegate) [a addObject:_proxyDelegate];
    return a;
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self hasSections])
    { return [[self currentData] count]; }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([self hasSections])
    {
        return [NSString stringWithFormat:@"Section %i", section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self hasSections] ?
    [[self currentData][section] count] :
    [self currentData].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    NSArray *data = [self currentData];
    id curItem = [self hasSections] ? data[indexPath.section][indexPath.row] : data[indexPath.row];
    if(self.cellIDHandler)
    { cellID = self.cellIDHandler(curItem,indexPath); }
    else
    { cellID = NSStringFromClass([self class]); }
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID];
    }
    
    [self customizeCell:cell withItem:curItem atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *data = [self currentData];
    id curItem = [self hasSections] ? data[indexPath.section][indexPath.row] : data[indexPath.row];
    if(self.cellSelectionHandler)
    { self.cellSelectionHandler([tableView cellForRowAtIndexPath:indexPath],curItem,indexPath); }
}

#pragma mark - Setters

- (void)setTableView:(UITableView *)tableView
{
    _tableView = tableView;
    if(!_filterSearchBar && self.canFilter)
    {
        tableView.tableHeaderView = [self filterSearchBar];
        [_tableView reloadData];
    }
}


#pragma mark - Lazy Loads

- (UISearchBar *)filterSearchBar
{
    if(!_filterSearchBar && self.canFilter)
    {
        UISearchBar *s = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 44)];
        s.showsCancelButton = YES;
        s.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        s.placeholder = @"Search...";
        s.delegate = self;
        _filterSearchBar = s;
    }
    return _filterSearchBar;
}


#pragma mark - Search Methods

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [super searchBarShouldEndEditing:searchBar];
    [self.tableView reloadData];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidBeginEditing:searchBar];
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [super searchBar:searchBar textDidChange:searchText];
    [self.tableView reloadData];
}
@end
