//
//  TK_ReqVoteViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_ReqVoteViewController.h"
#import "TK_VotingViewController.h"
#import "TK_Vote_GraphViewController.h"

@interface TK_ReqVoteViewController ()
{
    IBOutlet UIButton  *newVoteButton;
    IBOutlet UIButton  *voteGraphButton;
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
    self.title =@"投票管理";
    [newVoteButton addTarget:self action:@selector(startNewVote) forControlEvents:UIControlEventTouchDown];
    [voteGraphButton addTarget:self action:@selector(showVoteGraph) forControlEvents:UIControlEventTouchDown];
    
    // Do any additional setup after loading the view from its nib.
}
- (void) startNewVote
{
    TK_VotingViewController *startVoting =[[TK_VotingViewController alloc] initWithNibName:@"TK_VotingViewController" bundle:nil];
    [self.navigationController pushViewController:startVoting animated:YES];
    
}
- (void) showVoteGraph
{
    TK_Vote_GraphViewController *graphVC =[[TK_Vote_GraphViewController alloc] initWithNibName:@"TK_Vote_GraphViewController" bundle:nil];
    [self.navigationController pushViewController:graphVC animated:YES];
}

@end
