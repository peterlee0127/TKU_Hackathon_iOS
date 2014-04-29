//
//  TK_Vote_GraphViewController.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_TopViewController.h"

@interface TK_Vote_GraphViewController : TK_TopViewController <UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *tableArray;


@end

