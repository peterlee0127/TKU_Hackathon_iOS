//
//  TK_BLEModel.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_BLEModel.h"

@implementation TK_BLEModel
{
    TK_APIModel *apiModel;
    NSMutableArray *rangeArray;
    NSUInteger count;
}
+(instancetype) shareInstance
{
    static TK_BLEModel *shareInstace_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstace_ = [[TK_BLEModel alloc] init];
    });
    return shareInstace_;
}
-(id) init
{
    self = [super init];
    if(self)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate=self;
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        self.beaconArray =[[NSMutableArray alloc] init];
        rangeArray = [[NSMutableArray alloc] init];
        apiModel = [TK_APIModel shareInstance];
        apiModel.delegate=self;
        [apiModel downloadBeaconInf];
        [apiModel downloadClassInf];
        count=0;
    }
    return self;
}
-(void) addBeacon:(CLBeaconRegion *) beaconRegion
{
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.beaconArray addObject:beaconRegion];
}
-(NSArray *) allBeacon
{
    return self.beaconArray;
}
-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    
}
-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    /*
     CLProximityUnknown,
     CLProximityImmediate,
     CLProximityNear,
     CLProximityFar
     */
    [beacons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CLBeacon *beacon =(CLBeacon * )obj;
        if(beacon.accuracy< 15.5)
        {
        
//                NSLog(@"%f region:%@",beacon.accuracy,region.identifier);
                NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:
                                     region.identifier,@"room",
                                     [NSString stringWithFormat:@"%f",beacon.accuracy],@"distance"
                                     , nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:kUserIsInClass object:dict];
     
        }
        else
        {
        
        }
    }];
}
-(void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"range beacon fail %@",region.identifier);
}

#pragma mark - TK_API Delegate

-(void)beaconInf:(NSArray *)data
{
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        NSDictionary *dict = (NSDictionary *)obj;
        NSUUID *uuid =[[NSUUID alloc] initWithUUIDString:dict[@"beacon_id"]];
        
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:[dict[@"major"] integerValue] minor:[dict[@"minor"] integerValue] identifier:dict[@"class_room"]];
        
        [self addBeacon:region];
    }];
}
-(void) classInf:(NSArray *)data
{

}

@end
