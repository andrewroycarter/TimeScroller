//
//  PSAppDelegate.m
//  ACTimeScrollerDemo
//
//  Created by Andrew Carter on 4/28/13.
//  Copyright (c) 2013 Pinch Studios. All rights reserved.
//

#import "PSAppDelegate.h"

#import "PSRootViewController.h"

@implementation PSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    PSRootViewController *rootViewController = [[PSRootViewController alloc] initWithStyle:UITableViewStylePlain];
    [[self window] setRootViewController:rootViewController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
