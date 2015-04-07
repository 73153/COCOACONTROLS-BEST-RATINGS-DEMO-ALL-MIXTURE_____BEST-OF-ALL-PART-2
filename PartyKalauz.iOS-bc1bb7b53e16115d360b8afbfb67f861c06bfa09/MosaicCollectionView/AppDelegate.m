//
//  AppDelegate.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/16/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "AppDelegate.h"
#import "Mapbox.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse enableLocalDatastore];

    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [[RMConfiguration sharedInstance] setAccessToken:@"pk.eyJ1IjoienNiZWUiLCJhIjoidjJ2TlBPcyJ9.FTk5urwqWgSH-DYDGDpbTw"];
    
    
    [Parse setApplicationId:@"l0CkJMluS2GJjp8ETH4h5c96AODSPMIaJV6aHWUy"
                  clientKey:@"cSQYwQv7goaKinyXwX5EWC94rZZSHIXawkxqC3Uh"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{


}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
