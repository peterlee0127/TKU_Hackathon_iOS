//
//  TK_ActAsBeaconViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_ActAsBeaconViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

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
    
    // Do any additional setup after loading the view from its nib.
}
-(void) startActAsBeacon
{
        // We must construct a CLBeaconRegion that represents the payload we want the device to beacon.
    NSDictionary *peripheralData = nil;
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:[major shortValue] minor:[minor shortValue] identifier:BeaconIdentifier];
    peripheralData = [region peripheralDataWithMeasuredPower:[NSNumber numberWithDouble:-59]];
    
        // The region's peripheral data contains the CoreBluetooth-specific data we need to advertise.
    if(peripheralData)        {
        [peripheralManager startAdvertising:peripheralData];
    }


}


@end
