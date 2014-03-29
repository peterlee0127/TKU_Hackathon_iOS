//
//  TK_WebSocket.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"
#import "SocketIOPacket.h"

@interface TK_WebSocket : NSObject <SocketIODelegate>


@property (nonatomic,strong) SocketIO *socketIO;
@property (nonatomic,strong) NSMutableArray *messageArray;



+(instancetype) shareInstance;
-(void) connectToServer;



@end
