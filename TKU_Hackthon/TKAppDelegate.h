//
//  TKAppDelegate.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PKRevealController.h>
#import "TK_MenuViewController.h"

@interface TKAppDelegate : UIResponder <UIApplicationDelegate,PKRevealing>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic,strong) PKRevealController *revealViewController;
@property (nonatomic,strong) TK_MenuViewController *menuViewController;
@property (nonatomic,strong) UINavigationController *navVC;

@end
