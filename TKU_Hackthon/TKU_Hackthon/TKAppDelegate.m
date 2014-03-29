//
//  TKAppDelegate.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TKAppDelegate.h"
#import "TK_FrontViewController.h"

@implementation TKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.365 green:0.314 blue:0.294 alpha:1.000]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMenu) name:@"kShowMenuViewController" object:nil];
    
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
   self.menuViewController =[[TK_MenuViewController alloc] initWithNibName:@"TK_MenuViewController" bundle:nil];
    
    TK_FrontViewController *frontVC=[[TK_FrontViewController alloc] initWithNibName:@"TK_FrontViewController" bundle:nil];
    
    self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
    
    
    self.revealViewController =[PKRevealController revealControllerWithFrontViewController:self.navVC leftViewController:self.menuViewController];
    

    self.window.rootViewController = self.revealViewController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
-(void) changeViewController :(NSNotification *) noti
{

    
    
    
}
-(void) showMenu
{
    [self.revealViewController showViewController:self.menuViewController];


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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
