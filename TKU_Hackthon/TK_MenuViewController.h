//
//  TK_MenuViewController.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TK_TopViewController.h"

@interface TK_MenuViewController : TK_TopViewController  <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *menuArray;
@property (nonatomic,strong) NSArray *menuImageArray;

@end
