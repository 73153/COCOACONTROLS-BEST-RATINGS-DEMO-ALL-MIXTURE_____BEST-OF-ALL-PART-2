//
//  JKCollectionViewDataSource.m
//  JKDataSourceDemo
//
//  Created by Joseph Ridenour on 9/20/13.
//  Copyright (c) 2013 Joseph Ridenour. All rights reserved.
//

#import "JKCollectionViewDataSource.h"

@implementation JKCollectionViewDataSource


#pragma mark - Customize

- (void)customizeCell:(UICollectionViewCell *)cell
             withItem:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor redColor];
    if(self.cellConfigurationHandler)
    { self.cellConfigurationHandler(cell,item,indexPath); }
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if([self hasSections])
    { return [[self currentData] count]; }
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *rview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderID" forIndexPath:indexPath];
    UILabel *l = (UILabel *)[rview viewWithTag:10203];
    if(!rview)
    {
        rview = [[UICollectionReusableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(collectionView.bounds), 44)];
        rview.backgroundColor = [UIColor greenColor];
        l = [UILabel new];
        l.frame = rview.bounds;
        l.tag = 10203;
        l.backgroundColor = [UIColor whiteColor];
        [rview addSubview:l];
    }
    l.text = [self hasSections]?[NSString stringWithFormat:@"Section %i", indexPath.section]:@"";
    return rview;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self hasSections] ?
    [[self currentData][section] count] :
    [self currentData].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = nil;
    NSArray *data = [self currentData];
    id curItem = [self hasSections] ? data[indexPath.section][indexPath.row] : data[indexPath.row];
    if(self.cellIDHandler)
    { cellID = self.cellIDHandler(curItem,indexPath); }
    else
    { cellID = NSStringFromClass([self class]); }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    }
    
    [self customizeCell:cell withItem:curItem atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Setters

- (void)setCollectionView:(UICollectionView *)collectionView
{
    _collectionView = collectionView;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([self class])];
    [collectionView reloadData];
}


#pragma mark - Lazy Loads

- (UISearchBar *)filterSearchBar
{
    if(!_filterSearchBar && self.canFilter)
    {
        UISearchBar *s = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, _collectionView.bounds.size.width, 44)];
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
    [self.collectionView reloadData];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidBeginEditing:searchBar];
    [self.collectionView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [super searchBar:searchBar textDidChange:searchText];
    [self.collectionView reloadData];
}



@end
