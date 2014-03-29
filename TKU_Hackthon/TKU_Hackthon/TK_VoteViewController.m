//
//  TK_VoteViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/30/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_VoteViewController.h"
#import "TK_WebSocket.h"
#import "TK_PlistModel.h"

@interface TK_VoteViewController ()
{
    TK_WebSocket *websocket;
    TK_PlistModel *plistModel;
    NSString *ans;
}
@end

@implementation TK_VoteViewController

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
    ans = @"";
    websocket = [TK_WebSocket shareInstance];
    plistModel = [TK_PlistModel shareInstance];
    [self.doneButton addTarget:self action:@selector(sendDone) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction) chooseA:(id)sender
{
    self.chooseLabel.text = [NSString stringWithFormat:@"你選擇了:A"];
    ans = @"A";
}
-(IBAction) chooseB:(id)sender
{
    self.chooseLabel.text = [NSString stringWithFormat:@"你選擇了:B"];
     ans = @"B";
}
-(IBAction) chooseC:(id)sender
{
    self.chooseLabel.text = [NSString stringWithFormat:@"你選擇了:C"];
     ans = @"C";
}
-(IBAction) chooseD:(id)sender
{
    self.chooseLabel.text = [NSString stringWithFormat:@"你選擇了:D"];
     ans = @"D";
}
-(void) viewWillAppear:(BOOL)animated
{
    self.title = [NSString stringWithFormat:@"目前題號:%@",self.dict[@"name"]];
}
- (void) sendDone
{
        if(websocket.socketIO.isConnected)
        {
            if([ans isEqualToString:@""])
                return;
        
        
            NSString *stu_id=[plistModel loadUserInfo][kstu_id];
            NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:
                                stu_id,@"stu_id",
                                 ans,@"answer", nil];
            [websocket.socketIO sendEvent:@"Voting" withData:dict];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"endVoteViewController" object:nil];
        }
}


@end
