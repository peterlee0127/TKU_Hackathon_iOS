//
//  TK_WebSocket.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_WebSocket.h"

@implementation TK_WebSocket


+(instancetype) shareInstance
{
    static TK_WebSocket *shareInstace_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstace_ = [[TK_WebSocket alloc] init];
    });
    return shareInstace_;
}
-(void) connectToServer
{
    self.socketIO =[[SocketIO alloc] initWithDelegate:self];
    [self.socketIO connectToHost:defaultSever onPort:defaultPort];
}



@end
