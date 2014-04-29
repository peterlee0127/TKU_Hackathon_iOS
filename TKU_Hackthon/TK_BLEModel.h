//
//  TK_BLEModel.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TK_APIModel.h"

@interface TK_BLEModel : NSObject <CLLocationManagerDelegate,TK_APIDelegate>


@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableArray *beaconArray;


+(instancetype) shareInstance;
-(void) addBeacon:(CLBeaconRegion *) beaconRegion;
-(NSArray *) allBeacon;


@end
