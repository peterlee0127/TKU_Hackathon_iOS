//
//  TK_BLEModel.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TK_BLEModel : NSObject <CLLocationManagerDelegate>


@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableArray *beaconArray;


+(instancetype) shareInstance;
-(void) addBeacon:(CLBeacon *) beacon;
-(NSArray *) allBeacon;


@end
