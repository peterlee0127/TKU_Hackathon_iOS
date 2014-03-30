//
//  TK_OnlineViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_OnlineViewController.h"
#import "TK_APIModel.h"
#import "TK_OnlineTableViewCell.h"
#import "TK_WebSocket.h"

@interface TK_OnlineViewController ()
{
    TK_APIModel *apiModel;
    TK_WebSocket *socket;
}
@end

@implementation TK_OnlineViewController

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
    self.title =@"目前在線名單";
     apiModel =[TK_APIModel shareInstance];
    socket = [TK_WebSocket shareInstance];
  
    [self downloadOnlinceStudent];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-50) style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"TK_OnlineTableViewCell" bundle:nil] forCellReuseIdentifier:@"OnlineCell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *right =[[UIBarButtonItem alloc] initWithTitle:@"重新整理" style:UIBarButtonItemStylePlain target:self action:@selector(downloadOnlinceStudent)];
    self.navigationItem.rightBarButtonItem = right;
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(downloadOnlinceStudent) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view from its nib.
}
-(void) downloadOnlinceStudent
{
    NSString *classID=apiModel.classArray[0][@"_id"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //api/class/5336b36e6855eef86dba89e9/student_list
    NSString *url=[NSString stringWithFormat:@"http://%@:%@/api/class/%@/student_list",defaultSever,defaultPort,classID];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tableArray = (NSArray *)responseObject;
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TK_OnlineTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"OnlineCell"];
    NSDictionary *dict =self.tableArray[indexPath.row];
    
    cell.nameLabel.text =dict[@"name"];
    cell.stu_idLabel.text = dict[@"stu_id"];
    if(![dict[@"come"] boolValue])
        cell.come.text = @"未到";
    else
        cell.come.text = @"到";
    
    if([dict[@"lock"]integerValue] !=1)
        [cell.isLock setHidden:YES];
        
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      NSDictionary *dict =self.tableArray[indexPath.row];
        NSString *classID =apiModel.classArray[0][@"_id"];
    
    NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                              classID,@"class_id",
                              dict[kstu_id],@"stu_id"  ,nil];
    
    if(socket.socketIO.isConnected)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:kforceChangeCome object:temp];
        [self performSelector:@selector(downloadOnlinceStudent) withObject:nil afterDelay:1];
    }
}


@end
