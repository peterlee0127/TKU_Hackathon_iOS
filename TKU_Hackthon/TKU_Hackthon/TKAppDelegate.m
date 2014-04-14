//
//  TKAppDelegate.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TKAppDelegate.h"
#import "TK_PlistModel.h"
#import "TK_BLEModel.h"
#import "TK_WebSocket.h"

#import "TK_LoginViewController.h"
#import "TK_UserCourseViewController.h"
#import "TK_CommentViewController.h"
#import "TK_CurrentLocationViewController.h"
#import "TK_ReqVoteViewController.h"
#import "TK_OnlineViewController.h"
#import "TK_ActAsBeaconViewController.h"
#import "TK_VoteViewController.h"

@implementation TKAppDelegate
{
    TK_PlistModel *plistModel;
    TK_WebSocket *webSocket;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setNavigtionAppearAndKVO];
    
    self.window =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    plistModel = [TK_PlistModel shareInstance];
    if( [plistModel loadUserCourse].count>0  || [plistModel UserIsAdmin])
    {
        // already login
        [self showRevalViewController];
    }
    else
    {
        [self showLoginViewController];
    }
    webSocket =[TK_WebSocket shareInstance];
    [TK_BLEModel shareInstance];
    
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showVoteViewController:) name:kstart_Vote object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endVoteViewController:) name:kend_vote object:nil];
    
}
-(void) changeViewController :(NSNotification *) noti
{
    NSNumber * number = [noti object];
    NSUInteger index = [number integerValue];
    if([plistModel UserIsAdmin])
    {
    switch (index) {
        case 0:
        {
            TK_CommentViewController *frontVC=[[TK_CommentViewController alloc] initWithNibName:@"TK_CommentViewController" bundle:nil];
            self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
            break;
        }
        case 1:
        {
            TK_CurrentLocationViewController *frontVC=[[TK_CurrentLocationViewController alloc] initWithNibName:@"TK_CurrentLocationViewController" bundle:nil];
        
            self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
            break;
        }
        case 2:
        {
            TK_OnlineViewController *front =[[TK_OnlineViewController alloc] initWithNibName:@"TK_OnlineViewController" bundle:nil];
            self.navVC =[[UINavigationController alloc] initWithRootViewController:front];
            break;
        }
        case 3:
        {
            TK_ReqVoteViewController *reqVC =[[TK_ReqVoteViewController alloc] initWithNibName:@"TK_ReqVoteViewController" bundle:nil];
            self.navVC =[[UINavigationController alloc] initWithRootViewController:reqVC];
            break;
        }
        case 4:
        {
            // ble
            TK_ActAsBeaconViewController *front =[[TK_ActAsBeaconViewController alloc] initWithNibName:@"TK_ActAsBeaconViewController" bundle:nil];
            self.navVC =[[UINavigationController alloc] initWithRootViewController:front];
        
            break;
        }
        case 5:
        {
        
            [self showLoginViewController];
            return;
            break;
        }
        default:
            break;
    }
    }
    else
    {
            switch (index) {
                case 0:
                {
                    TK_UserCourseViewController *frontVC=[[TK_UserCourseViewController alloc] initWithNibName:@"TK_UserCourseViewController" bundle:nil];
                
                    self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
                    break;
                }
                case 1:
                {
//                    [self checkUserIsInClass];
                    TK_CommentViewController *frontVC=[[TK_CommentViewController alloc] initWithNibName:@"TK_CommentViewController" bundle:nil];
                    self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
                    break;
                }
                case 2:
                {
                    TK_CurrentLocationViewController *frontVC=[[TK_CurrentLocationViewController alloc] initWithNibName:@"TK_CurrentLocationViewController" bundle:nil];
                
                    self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
                    break;
                }
                case 3:
                {
                    [self showLoginViewController];
                    return;
                }
                default:
                    break;
            }
    }
    
    [self.revealViewController setFrontViewController:self.navVC];
    [self.revealViewController setMinimumWidth:160 maximumWidth:170 forViewController:self.menuViewController];
    [self showMenu];
}
-(void) checkUserIsInClass
{
    if(!webSocket.socketIO.isConnected)
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"你不在 指定的教室喔 無法連線" message:@"請到教室" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alert show];
    
        return;
    }
}
-(void) showRevalViewController
{
    self.menuViewController =[[TK_MenuViewController alloc] initWithNibName:@"TK_MenuViewController" bundle:nil];
    
    if ([plistModel UserIsAdmin])
    {
        TK_CommentViewController *frontVC =  [[TK_CommentViewController alloc] initWithNibName:@"TK_CommentViewController" bundle:nil];
     self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
    }
    else
    {
        TK_UserCourseViewController *frontVC=[[TK_UserCourseViewController alloc] initWithNibName:@"TK_UserCourseViewController" bundle:nil];
        self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
    }

    
    self.revealViewController =[PKRevealController revealControllerWithFrontViewController:self.navVC leftViewController:self.menuViewController];
    
    
    self.window.rootViewController = self.revealViewController;
 
}
-(void) showLoginViewController
{
    plistModel.plistDict = [[NSMutableDictionary alloc] init];
    TK_LoginViewController *loginVC =[[TK_LoginViewController alloc] initWithNibName:@"TK_LoginViewController" bundle:nil];
    self.navVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController =self.navVC;
}
-(void) showMenu
{
    if(self.revealViewController.state == PKRevealControllerShowsFrontViewController)
        [self.revealViewController showViewController:self.revealViewController.leftViewController];
    else
        [self.revealViewController showViewController:self.revealViewController.frontViewController];
    
}
-(void) showVoteViewController: (NSNotification *) noti
{
    plistModel = [TK_PlistModel shareInstance];
    if(![([plistModel loadUserInfo][kstu_id]) isEqualToString:@""])
    {
        if([plistModel UserIsAdmin])
            return;
        TK_VoteViewController *frontVC =[[TK_VoteViewController alloc] initWithNibName:@"TK_VoteViewController" bundle:nil];
        frontVC.dict = (NSDictionary *)[noti object];
        self.navVC =[[UINavigationController alloc] initWithRootViewController:frontVC];
        self.window.rootViewController =self.navVC;
    }
    
}
- (void) endVoteViewController : (NSNotification *) noti
{
    plistModel = [TK_PlistModel shareInstance];
    if(![([plistModel loadUserInfo][kstu_id]) isEqualToString:@""])
    {
        if([plistModel UserIsAdmin])
            return;
        [self showRevalViewController];
    }
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
