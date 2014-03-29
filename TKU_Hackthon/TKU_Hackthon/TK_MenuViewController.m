//
//  TK_MenuViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_MenuViewController.h"
#import "TK_MenuTableViewCell.h"
#import <PKRevealController.h>
#import "TK_PlistModel.h"

@interface TK_MenuViewController ()
{
    TK_PlistModel *plistModel;
}
@end

@implementation TK_MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    plistModel =[TK_PlistModel shareInstance];
    if([plistModel UserIsAdmin])
    {
        self.menuArray =[NSArray arrayWithObjects:@"我的課表",@"意見",@"1",@"發送訊號",@"登出", nil];
        
        self.menuImageArray = [NSArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    }
    else
    {
        self.menuArray =[NSArray arrayWithObjects:@"我的課表",@"意見",@"1",@"3",@"登出", nil];
    
        self.menuImageArray = [NSArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    }
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height-30) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"TK_MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.revealController setMinimumWidth:160 maximumWidth:170 forViewController:self];
    
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view from its nib.
}
#pragma  mark - UITableView DataSource 

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TK_MenuTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    cell.menuLabel.text =self.menuArray[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}
#pragma mark - UITableView Delegate



@end
