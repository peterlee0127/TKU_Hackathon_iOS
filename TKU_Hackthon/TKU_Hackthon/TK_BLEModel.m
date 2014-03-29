//
//  TK_BLEModel.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_BLEModel.h"

@implementation TK_BLEModel

+(instancetype) shareInstance
{
    static TK_BLEModel *shareInstace_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstace_ = [[TK_BLEModel alloc] init];
    });
    return shareInstace_;
}


@end
