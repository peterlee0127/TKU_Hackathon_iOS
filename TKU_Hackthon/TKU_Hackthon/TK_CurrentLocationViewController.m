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
    NSString *userInRoom ;
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
    self.title =@"你現在的位置";
    
    count =0;
    userInRoom =@"NO";
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sayLocation)];
    tap.numberOfTapsRequired=1;
    locationLabel.userInteractionEnabled=YES;
    [locationLabel addGestureRecognizer:tap];


    // Do any additional setup after loading the view from its nib.
}
-(void) sayLocation
{
    if([userInRoom isEqualToString:@"NO"])
        return;

    
    MPMusicPlayerController *player =[[MPMusicPlayerController alloc] init];
    if(player.volume<0.3)
        player.volume=0.4;
    
   
    AVSpeechSynthesizer *syn=[[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utt=[AVSpeechUtterance speechUtteranceWithString:[NSString stringWithFormat:@"你現在在%@",userInRoom]];
    [utt setRate:0.15];
    [syn speakUtterance:utt];
}
-(void) userLocation: (NSNotification *) noti
{
    NSDictionary *dict =(NSDictionary *)[noti object];
    if([dict[@"distance"] floatValue] < -0.1)
    {
        userInRoom =@"未知位置";
        locationLabel.text =[NSString stringWithFormat:@"%@",userInRoom];
        return;
    }
     userInRoom =dict[@"room"];
    locationLabel.text =[NSString stringWithFormat:@"你現在在:%@",userInRoom];

}

@end
