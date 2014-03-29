//
//  TK_WebSocket.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_WebSocket.h"
#import "TK_PlistModel.h"
#import "TK_APIModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <JSMessage.h>

@implementation TK_WebSocket
{
    TK_PlistModel *plistModel;
    
    NSMutableArray *rangeArray;
    NSString *userInRoom;
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendChatMessage:) name:kUserSendChat object:nil];
        rangeArray =[[NSMutableArray alloc] init];
        userInRoom = @"NO";
        self.messageArray=[[NSMutableArray alloc] initWithObjects:
                           [[JSMessage alloc] initWithText:@"歡迎使用 提問系統  右上角 可以選擇發送對象" sender:@"system" date:[NSDate distantPast]],
                           nil];
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
    if([dict[@"distance"] floatValue] < -0.5)
    {
        userInRoom = @"NO";
        [self.socketIO disconnect];
    }
    else
    {
        userInRoom =dict[@"room"];
        if(!self.socketIO.isConnected)
        {
            [self connectToServer];
            MPMusicPlayerController *player =[[MPMusicPlayerController alloc] init];
//            player.volume=0.0;
        
    
        }
    }
//    NSLog(@"%@",userInRoom);
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
    TK_APIModel *api =[TK_APIModel shareInstance];
    NSString *class =api.classArray[0][@"_id"];
    NSDictionary *addmeDict = [NSDictionary dictionaryWithObjectsAndKeys:[plistModel loadUserInfo][kstu_id],@"stu_id",
                                                                        class,@"class_id"
                               ,nil];
    [self.socketIO sendEvent:@"addme" withData:addmeDict];
    
      [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketIsConnect object:[NSNumber numberWithBool:YES]];
}
- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketIsConnect object:[NSNumber numberWithBool:NO]];
}
- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    if([packet.name isEqualToString:@"addmeRes"])
    {
        NSData *data = [packet.data dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        if([(NSString *)(json[@"args"][0][@"status"])  isEqualToString:@"YES"] )
            NSLog(@"success");
    }
    else if([packet.name isEqualToString:@"ListenChat"])
    {
        NSData *data = [packet.data dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"listenChat:%@",json);
    }
}
- (void) socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet
{

}
- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{

}

-(void) sendChatMessage:(NSNotification *) noti
{
    NSDictionary *temp =(NSDictionary * ) [noti object];

    NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:
                            temp[ktarget],@"target",
                             temp[kmessage],@"message",
                            temp[kstu_id],@"stu_id", nil];
    [self.socketIO sendEvent:@"chat" withData:dict];
    
    JSMessage *message =[[JSMessage alloc] initWithText:temp[kmessage] sender:temp[kstu_id] date:[NSDate distantPast]];
    [self.messageArray addObject:message];
}



@end
