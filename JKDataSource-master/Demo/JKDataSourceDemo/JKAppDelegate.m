//
//  JKAppDelegate.m
//  JKDataSourceDemo
//
//  Created by Joseph Ridenour on 6/29/13.
//  Copyright (c) 2013 Joseph Ridenour. All rights reserved.
//

#import "JKAppDelegate.h"
#import "JKDataSource.h"

#import <JKDataSource/JKTableViewDataSource.h>
#import <JKDataSource/JKCollectionViewDataSource.h>

@interface JKAppDelegate()<UITableViewDelegate>@end
@implementation JKAppDelegate
{
    JKDataSource *_datasource;
    JKDataSource *_collectionDataSource;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    tvc.tableView.dataSource =
    tvc.tableView.delegate = [self _mainMenuDataSource];
    [(JKTableViewDataSource *)[self _mainMenuDataSource] setTableView:tvc.tableView];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:tvc];
    
    [(JKTableViewDataSource *)[self _mainMenuDataSource] setCellSelectionHandler:^(UITableViewCell*cell,id item,NSIndexPath *ip) {
        
        if(ip.row >= 2) {
            JKCollectionViewDataSource *c = [self _collectionDataSourceBasic];
            UICollectionViewController *cvc = [[UICollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
            cvc.collectionView.dataSource =
            cvc.collectionView.delegate = c;
            c.collectionView = cvc.collectionView;
            
            UISearchBar *sb = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
            cvc.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sb];
            c.filterSearchBar = sb;
            sb.delegate = c;
            c.allowsFiltering = YES;
            
            [(UINavigationController *)self.window.rootViewController pushViewController:cvc animated:YES];
        } else {
            JKTableViewDataSource *d=ip.row==0?[self _dataSourceForBasicTable]:[self _dataSourceForBasicTableWithFiltering];
            UITableViewController *t = [[UITableViewController alloc] init];
            t.tableView.delegate = t.tableView.dataSource = d;
            d.tableView = t.tableView;
            [(UINavigationController *)self.window.rootViewController pushViewController:t animated:YES];
        }
        
    }];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSArray *)tmpRows
{
    NSMutableArray *a = [NSMutableArray array];
    srand([[NSDate date] timeIntervalSince1970]);
    int r = arc4random() % 1000;
    for(int i = r; i < r+100; i++)
    { [a addObject:@(i).stringValue]; }
    return a;
}

- (JKDataSource *)_mainMenuDataSource
{
    static JKTableViewDataSource *d = nil;
    if(d) return d;
    d = [[JKTableViewDataSource alloc] init];
    // Tmp data which is just an array of strings
    d.data = @[
                    @"Basic Table DataSource",
                    @"Basic Table DataSource W/ filtering",
                    @"Basic Collection DataSource"
                    ];
    d.allowsFiltering = NO;
    d.proxyDelegate = self;
    return d;
}

- (JKDataSource *)_dataSourceForBasicTable
{
    static JKTableViewDataSource *d = nil;
    if(d) return d;
    d = [[JKTableViewDataSource alloc] init];
    // Tmp data which is just an array of strings
    d.data = @[
                    [self tmpRows],
                    [self tmpRows],
                    [self tmpRows],
                    [self tmpRows]
                    ];
    d.proxyDelegate = self;
    d.allowsFiltering = NO;
    return d;
}

- (JKDataSource *)_dataSourceForBasicTableWithFiltering
{
    static JKTableViewDataSource *d = nil;
    if(d) return d;
    d = [[JKTableViewDataSource alloc] init];
    // Tmp data which is just an array of strings
    d.data = @[
                    [self tmpRows],
                    [self tmpRows],
                    [self tmpRows],
                    [self tmpRows]
                    ];
    d.proxyDelegate = self;
    d.allowsFiltering = YES;
    return d;
}

- (JKDataSource *)_collectionDataSourceBasic
{
    static JKCollectionViewDataSource *d = nil;
    if(d) return d;
    d = [[JKCollectionViewDataSource alloc] init];
    d.data = @[
               [self tmpRows],
               [self tmpRows],
               [self tmpRows],
               [self tmpRows]
               ];
    return d;
}

@end
