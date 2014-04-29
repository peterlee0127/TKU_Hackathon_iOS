//
//  TK_ActAsBeaconViewController.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_TopViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

@interface TK_ActAsBeaconViewController : TK_TopViewController <CBPeripheralManagerDelegate>

@end
