//
//  TK_APIModel.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_APIModel.h"
#import <AFNetworking.h>

@implementation TK_APIModel


+(instancetype) shareInstance
{
    static TK_APIModel *shareInstance_ =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance_ = [[TK_APIModel alloc] init];
    });
    return shareInstance_;
}
- (void) downloadBeaconInf
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSString *url=[NSString stringWithFormat:@"http://%@:%@/api/beacon",defaultSever,defaultPort];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        self.beaconArray=(NSMutableArray *)responseObject;
        
        [self.delegate beaconInf:self.beaconArray];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
        NSLog(@"error:%@",error);
    }];
    
    /*
     NSDictionary *parameters = @{@"place": @"MOS"};
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.beaconArray=(NSMutableArray *)responseObject;
        [self.delegate beaconInf:self.beaconArray];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
     */

}


@end
