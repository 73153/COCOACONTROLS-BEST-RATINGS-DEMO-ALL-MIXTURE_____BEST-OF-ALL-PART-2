//
//  JKDataSource.m
//  JKDataSourceDemo
//
//  Created by Joseph Ridenour on 6/29/13.
//  Copyright (c) 2013 Joseph Ridenour. All rights reserved.
//

#import "JKDataSource.h"
#import "JKDataSource_Private.h"

@interface JKDataSource ()
@property (nonatomic, strong) NSArray *tmpData;
@end



@implementation JKDataSource
@synthesize filterSearchBar = _filterSearchBar;


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{ return [self init]; }

- (void)encodeWithCoder:(NSCoder *)aCoder
{}


#pragma mark - Init

- (void)commonInit
{
    self.allowsFiltering = YES;
}

- (id)init
{
    if((self = [super init]))
    { [self commonInit]; }
    return self;
}


#pragma mark - Forwarding Methods

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if([super respondsToSelector:aSelector]) return YES;
    
    for(NSObject *o in [self availableForwardingResponders])
    { if([o respondsToSelector:aSelector]) return YES; }
    
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)sel
{
    for(NSObject *o in [self availableForwardingResponders])
    { if([o respondsToSelector:sel]) return o; }
    
    return nil;
}

- (NSMethodSignature*) methodSignatureForSelector:(SEL)selector
{
    // Check if car can handle the message
    NSMethodSignature* signature = [super
                                    methodSignatureForSelector:selector];
    
    // If not, can the car info string handle the message?
    if(!signature)
    {
        for(NSObject *o in [self availableForwardingResponders])
        { if((signature = [o methodSignatureForSelector:selector])) return signature; }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    SEL selector = [invocation selector];
    
    for(NSObject *o in [self availableForwardingResponders])
    {
        if([o respondsToSelector:selector])
        { return [invocation invokeWithTarget:o]; }
    }
}


#pragma mark - Overrides

- (NSArray *)availableForwardingResponders {}

- (NSArray *)currentData
{
    if([self filteredData])
        return [self filteredData];
    return self.data;
}

- (NSArray *)filteredData
{ return self.tmpData; }


#pragma mark - Helpers

- (BOOL)hasSections
{
    NSArray *curData = [self currentData];
    if(curData &&
       curData.count > 0 &&
       [curData[0] isKindOfClass:[NSArray class]])
    { return YES; }
    
    return NO;
}


#pragma mark - Search Filtering

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    self.tmpData = nil;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.tmpData = [self.data copy];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *searchPortion = [NSString stringWithFormat:@"^.*%@.*", searchText];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", searchPortion];
    if([self hasSections])
    {
        NSMutableArray *t = [NSMutableArray array];
        for(NSArray *a in self.data)
        {
            [t addObject:[a filteredArrayUsingPredicate:pred]];
        }
        self.tmpData = t;
    } else {
        self.tmpData = [self.data filteredArrayUsingPredicate:pred];
    }
}

@end
