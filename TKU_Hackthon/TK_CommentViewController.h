//
//  TK_CommentViewController.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JSMessagesViewController.h>

@interface TK_CommentViewController : JSMessagesViewController <JSMessagesViewDataSource,JSMessagesViewDelegate>


@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSDictionary *avatars;


@end
