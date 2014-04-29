//
//  TK_Vote_GraphViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_Vote_GraphViewController.h"
#import <AFNetworking.h>
#import "TK_Vote_GraphTableViewCell.h"
#import "TK_APIModel.h"

@interface TK_Vote_GraphViewController ()
{
    TK_APIModel *apiModel;
}
@end

@implementation TK_Vote_GraphViewController

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
    self.title =@"投票結果";
    
    apiModel = [TK_APIModel shareInstance];
    [self downloadVote];
    
    self.tableView =[[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"TK_Vote_GraphTableViewCell" bundle:nil] forCellReuseIdentifier:@"GraphCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view from its nib.
}
-(void) downloadVote
{
    NSString *classID=apiModel.classArray[0][@"_id"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //http://localhost:3000/api/vote_result_list/5336b36e6855eef86dba89e9/
    NSString *url=[NSString stringWithFormat:@"http://%@:%@/api/vote_result_list/%@",defaultSever,defaultPort,classID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.tableArray =(NSArray *) responseObject;
        self.tableArray=[[self.tableArray reverseObjectEnumerator] allObjects];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error:%@",error);
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TK_Vote_GraphTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"GraphCell"];
    NSDictionary *dict =self.tableArray[indexPath.row];
    
    cell.ansLabel.text = dict[@"order"];
    cell.ALable.text = [NSString stringWithFormat:@"%@",dict[@"a"]];
    cell.BLable.text = [NSString stringWithFormat:@"%@",dict[@"b"]];
    cell.CLable.text = [NSString stringWithFormat:@"%@",dict[@"c"]];
    cell.DLable.text = [NSString stringWithFormat:@"%@",dict[@"d"]];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 160.0f;
}

@end
