//
//  TK_ActAsBeaconViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_ActAsBeaconViewController.h"


@interface TK_ActAsBeaconViewController ()
{
    UIView *bigCircleView;
    UIView *midiumCircleView;
    UIView *smallCircleView;
    
    CBPeripheralManager *peripheralManager;
    NSUUID *uuid;
    NSNumber *major;
    NSNumber *minor;
    NSString *BeaconIdentifier;
}
@end

@implementation TK_ActAsBeaconViewController

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
    self.title =@"模擬Beacon訊號";
    
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
    
    [self circleAnimation];
    
    
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, [UIScreen mainScreen].bounds.size.height-140, 240, 60)];
    label.font = [UIFont fontWithName:defaultFont size:22];
    label.text = @"Monitoring G315";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    // Do any additional setup after loading the view from its nib.
}
-(void) viewWillDisappear:(BOOL)animated
{
    [peripheralManager stopAdvertising];
}
- (void ) circleAnimation
{
    [UIView animateWithDuration:0.6 animations:^{
        midiumCircleView.alpha=0.5;
        smallCircleView.alpha=0.2;
        bigCircleView.alpha=0.9;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
              smallCircleView.alpha=0.9;
            bigCircleView.alpha = 0.2;
            midiumCircleView.alpha=0.9;
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                midiumCircleView.alpha=0.2;
            } completion:^(BOOL finished) {
                   [self circleAnimation];
            }];
            
         
        }];
    }];

}
-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    if(peripheral.state==CBPeripheralManagerStatePoweredOn)
        [self startActAsBeacon];
    
}
-(void) startActAsBeacon
{
  
 
    
    [peripheralManager stopAdvertising];
        // We must construct a CLBeaconRegion that represents the payload we want the device to beacon.
    NSDictionary *peripheralData = nil;
    
    /*
     "beacon_id":"1618E6B0-7912-4A22-8464-7042987A7F58",
     "class_room":"E405",
     "major":"0",
     "minor":"0"
     */

    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"92FEC112-0AFB-43B0-8B80-14192A537E86"] major:0 minor:2 identifier:@"G315"];
    peripheralData = [region peripheralDataWithMeasuredPower:[NSNumber numberWithDouble:-59]];
    
        // The region's peripheral data contains the CoreBluetooth-specific data we need to advertise.
    if(peripheralData)
    {
        [peripheralManager startAdvertising:peripheralData];
    }


}


@end
