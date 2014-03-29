//
//  TK_CurrentLocationViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_CurrentLocationViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>

@interface TK_CurrentLocationViewController ()
{
    NSUInteger count ;
    UIView *bigCircleView;
    UIView *midiumCircleView;
    UIView *smallCircleView;
    IBOutlet UILabel *locationLabel;
}
@end

@implementation TK_CurrentLocationViewController

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
    count =0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLocation:) name:kUserIsInClass object:nil];
    
    
     bigCircleView = [[UIView alloc] initWithFrame:CGRectMake(0,20,320,320)];
    bigCircleView.alpha = 0.5;
    bigCircleView.layer.cornerRadius = bigCircleView.frame.size.width/2;
    bigCircleView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bigCircleView];
    
    midiumCircleView = [[UIView alloc] initWithFrame:CGRectMake(40, 40, 240, 240)];
    midiumCircleView.alpha=0.5;
    midiumCircleView.layer.cornerRadius = midiumCircleView.frame.size.width/2;
    midiumCircleView.backgroundColor =[UIColor yellowColor];
    [self.view addSubview:midiumCircleView];
    
    smallCircleView =[[UIView alloc] initWithFrame:CGRectMake(80, 40, 160, 160)];
    smallCircleView.alpha=0.5f;
    smallCircleView.layer.cornerRadius = smallCircleView.frame.size.width/2;
    smallCircleView.backgroundColor =[UIColor greenColor];
    [self.view addSubview:smallCircleView];
    
    
    locationLabel.textAlignment = NSTextAlignmentCenter;
  
    // Do any additional setup after loading the view from its nib.
}
-(void) userLocation: (NSNotification *) noti
{
    NSDictionary *dict =(NSDictionary *)[noti object];
    dispatch_async(dispatch_get_main_queue(), ^{
        locationLabel.text =[NSString stringWithFormat:@"你現在在:%@",dict[@"room"]];
    });
    if(count ==2)
    {
    
        if([dict[@"distance"] floatValue] < -0.5)
        {

        }
        else
        {
            MPMusicPlayerController *player =[[MPMusicPlayerController alloc] init];
//            if(player.volume<0.3)
//                player.volume=0.4;
        
            NSString *userInRoom =dict[@"room"];
        
            AVSpeechSynthesizer *syn=[[AVSpeechSynthesizer alloc] init];
            AVSpeechUtterance *utt=[AVSpeechUtterance speechUtteranceWithString:[NSString stringWithFormat:@"你現在在%@",userInRoom]];
            [utt setRate:0.15];
//            [syn speakUtterance:utt];
        
        
        }
        count=0;
    }
    else
        count++;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
