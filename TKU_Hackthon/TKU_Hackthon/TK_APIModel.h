//
//  TK_APIModel.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TK_APIDelegate ;

@interface TK_APIModel : NSObject


@property (nonatomic,strong) NSArray *beaconArray;
@property (nonatomic,strong) NSArray *classArray;
@property (nonatomic,weak) id <TK_APIDelegate> delegate;

+(instancetype) shareInstance;
- (void) downloadBeaconInf;
-(void) downloadClassInf;


@end

@protocol TK_APIDelegate

-(void) beaconInf:(NSArray *) data;
-(void) classInf :(NSArray *) data;

@end