//
//  TKAppDelegate.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TKAppDelegate.h"
#import "TK_PlistModel.h"

#import "TK_LoginViewController.h"
#import "TK_UserCourseViewController.h"
#import "TK_CommentViewController.h"

@implementation TKAppDelegate
{
    TK_PlistModel *plistModel;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self setNavigtionAppearAndKVO];
    
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    plistModel = [TK_PlistModel shareInstance];
    if([plistModel loadUserCourse].count>0)
    {
        // already login
        [self showRevalViewController];
    }
    else
    {
        
        TK_LoginViewController *loginVC =[[TK_LoginViewController alloc] initWithNibName:@"TK_LoginViewController" bundle:nil];
        self.navVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController =self.navVC;
    }
    
    
 
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
-(void) setNavigtionAppearAndKVO
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.365 green:0.314 blue:0.294 alpha:1.000]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showRevalViewController) name:@"kLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMenu) name:@"kShowMenuViewController" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeViewController:) name:@"kchangeViewController" object:nil];
}
-(void) changeViewController :(NSNotification *) noti
{
    NSNumber * number = [noti object];
    NSUInteger index = [number integerValue];
    switch (index) {
        case 0:
        {
            TK_UserCourseViewController *frontVC=[[TK_UserCourseViewController alloc] initWithNibName:@"TK_UserCourseViewController" bundle:nil];
        
            self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
            break;
        }
        case 1:
        {
            TK_CommentViewController *frontVC=[[TK_CommentViewController alloc] initWithNibName:@"TK_CommentViewController" bundle:nil];
        
            self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
            break;
        }
        case 2:
        {
            break;
        }
        default:
            break;
    }
    
    
    [self.revealViewController setFrontViewController:self.navVC];
    [self.revealViewController setMinimumWidth:160 maximumWidth:170 forViewController:self.menuViewController];
    [self showMenu];
}
-(void) showRevalViewController
{
    self.menuViewController =[[TK_MenuViewController alloc] initWithNibName:@"TK_MenuViewController" bundle:nil];
    
    TK_UserCourseViewController *frontVC=[[TK_UserCourseViewController alloc] initWithNibName:@"TK_UserCourseViewController" bundle:nil];
    
    self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
    
    self.revealViewController =[PKRevealController revealControllerWithFrontViewController:self.navVC leftViewController:self.menuViewController];
    
    
    self.window.rootViewController = self.revealViewController;
 
}
-(void) showMenu
{
    if(self.revealViewController.state == PKRevealControllerShowsFrontViewController)
        [self.revealViewController showViewController:self.revealViewController.leftViewController];
    else
        [self.revealViewController showViewController:self.revealViewController.frontViewController];
    
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
