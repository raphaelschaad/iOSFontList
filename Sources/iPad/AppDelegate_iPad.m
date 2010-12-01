//
//  AppDelegate_iPad.m
//  iOSFontList
//
//  Created by Raphael Schaad on 01.12.10.
//  Copyright 2010 illuBits. All rights reserved.
//


#import "AppDelegate_iPad.h"

#import "FontListViewController.h"


@implementation AppDelegate_iPad

#pragma mark -
#pragma mark Accessors

@synthesize window;
@synthesize fontListViewController;


#pragma mark -
#pragma mark Life Cycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	self.fontListViewController = nil;
    self.window = nil;
	
	[super dealloc];
}


@end
