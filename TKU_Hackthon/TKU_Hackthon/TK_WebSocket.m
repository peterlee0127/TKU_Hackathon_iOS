//
//  TK_WebSocket.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_WebSocket.h"
#import "TK_PlistModel.h"

@implementation TK_WebSocket
{
    TK_PlistModel *plistModel;
    NSMutableArray *rangeArray;
}
+(instancetype) shareInstance
{
    static TK_WebSocket *shareInstace_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstace_ = [[TK_WebSocket alloc] init];
    });
    return shareInstace_;
}
-(id) init
{
    self = [ super init];
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLocation:) name:kUserIsInClass object:nil];
        rangeArray =[[NSMutableArray alloc] init];
    }
    return self;
}
-(void) connectToServer
{
    self.socketIO =[[SocketIO alloc] initWithDelegate:self];
    [self.socketIO connectToHost:defaultSever onPort:[defaultPort integerValue]];
    plistModel = [TK_PlistModel shareInstance];
   
}
-(void) userLocation: (NSNotification *) noti
{
    NSDictionary *dict =(NSDictionary *)[noti object];
    
    NSLog(@"%@",dict);
    /*
    if(rangeArray.count==0)
       [rangeArray addObject:dict];
    
    [rangeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *temp = (NSDictionary *) obj;
        if([dict[@"room"] isEqualToString:temp[@"room"]])
        {
            [rangeArray removeObjectAtIndex:idx];
            [rangeArray addObject:dict];
        }
        else
            [rangeArray addObject:dict];
    }];
    

    __block NSDictionary *minum = rangeArray[0];
    [rangeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *temp =(NSDictionary *) obj;
        if([minum[@"distance"] floatValue] > [temp[@"distance"] floatValue])
            minum = temp;
    }];
    NSLog(@"%@",minum);
     */
}
- (void) socketIODidConnect:(SocketIO *)socket
{
    
    NSDictionary *addmeDict = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"stu_id",
                                                                        @"",@"class_id"
                               ,nil];
    [self.socketIO sendEvent:@"addme" withData:addmeDict];
}
- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    
}
- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{

}
- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet
{

}
- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{

}



@end
