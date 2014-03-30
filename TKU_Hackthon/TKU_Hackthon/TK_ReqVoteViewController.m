//
//  TK_ReqVoteViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_ReqVoteViewController.h"
#import "TK_Vote_GraphViewController.h"
#import "TK_WebSocket.h"
#import "TK_APIModel.h"
@interface TK_ReqVoteViewController ()
{
    IBOutlet UIButton  *newVoteButton;
    IBOutlet UIButton  *voteGraphButton;
    TK_WebSocket *webSocket ;
}
@end

@implementation TK_ReqVoteViewController

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
    webSocket = [TK_WebSocket shareInstance];
    self.title =@"投票管理";
    [newVoteButton addTarget:self action:@selector(startNewVote) forControlEvents:UIControlEventTouchDown];
    [voteGraphButton addTarget:self action:@selector(showVoteGraph) forControlEvents:UIControlEventTouchDown];
    
    // Do any additional setup after loading the view from its nib.
}
- (void) startNewVote
{
    
    if(webSocket.socketIO.isConnected)
    {
        TK_APIModel *api =[TK_APIModel shareInstance];
        NSString *class =api.classArray[0][@"_id"];
        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:class,@"class_id", nil];
        [webSocket.socketIO sendEvent:@"vote_req" withData:dict];
    
    
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"已發起投票" message:@"按下結束鍵結束投票" delegate:self cancelButtonTitle:@"結束" otherButtonTitles:nil, nil];
        [alert show];
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(webSocket.socketIO.isConnected)
    {
        TK_APIModel *api =[TK_APIModel shareInstance];
        NSString *class =api.classArray[0][@"_id"];
        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:class,@"class_id", nil];
        [webSocket.socketIO sendEvent:@"end_vote" withData:dict];
        
    
    }
}
- (void) showVoteGraph
{
    TK_Vote_GraphViewController *graphVC =[[TK_Vote_GraphViewController alloc] initWithNibName:@"TK_Vote_GraphViewController" bundle:nil];
    [self.navigationController pushViewController:graphVC animated:YES];
}

@end
