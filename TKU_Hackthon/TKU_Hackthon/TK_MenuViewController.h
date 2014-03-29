//
//  TK_MenuViewController.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TK_MenuViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *menuArray;
@property (nonatomic,strong) NSArray *menuImageArray;

@end
