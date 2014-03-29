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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(force_change:) name:kforceChangeCome object:nil];
    
        rangeArray =[[NSMutableArray alloc] init];
        userInRoom = @"NO";
        self.messageArray=[[NSMutableArray alloc] initWithObjects:
                           [[JSMessage alloc] initWithText:@"歡迎使用 提問系統  右上角 可以選擇發送對象" sender:@"system" date:[NSDate date]],
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
    if([dict[@"distance"] floatValue] < -0.1 || [dict[@"distance"] floatValue ] > 3)
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
            NSLog(@"addme success");
    }
    else if([packet.name isEqualToString:@"listen_chat"])
    {
        NSData *data = [packet.data dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    
        NSDictionary *dict =json[@"args"][0];
    
        if(![plistModel UserIsAdmin])
        {
            if([dict[ktarget] isEqualToString:@"Teacher"])
            return;
        }
    
    
        JSMessage *message =[[JSMessage alloc] initWithText:dict[kmessage] sender:dict[kstu_id] date:[NSDate date]];
        [self.messageArray addObject:message];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMessage" object:nil];
    }
    else if([packet.name isEqualToString:@"start_vote"])
    {
        NSData *data = [packet.data dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    
        NSDictionary *dict =json[@"args"][0];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:kstart_Vote object:dict];
    
    }
    else if([packet.name isEqualToString:@"end_vote"])
    {
        NSData *data = [packet.data dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        
        NSDictionary *dict =json[@"args"][0];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kend_vote object:dict];
        
    }
    else if([packet.name isEqualToString:@"vote_result"])
    {
        NSData *data = [packet.data dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        
        NSDictionary *dict =json[@"args"][0];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kend_vote object:dict];
        
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
    
    JSMessage *message =[[JSMessage alloc] initWithText:temp[kmessage] sender:temp[kstu_id] date:[NSDate date]];
    [self.messageArray addObject:message];
}
-(void) force_change :(NSNotification * ) noti
{
    NSDictionary *dict =[noti object];
    
    [self.socketIO sendEvent:@"force_change_Come" withData:dict];
}

#pragma mark - kVote

/*
 static NSString *const kReqVote = @"kReqVote";
 static NSString *const kstart_Vote @"kstart_Vote";
 static NSString *const kvoting = @"kvoting";
 static NSString *const kvoting_res = @"kvoting_res";
 static NSString *const kend_vote = @"kend_vote";
 
 */


@end
