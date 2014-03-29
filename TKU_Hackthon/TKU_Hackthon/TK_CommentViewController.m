//
//  TK_CommentViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_CommentViewController.h"
#import <JSMessage.h>

@interface TK_CommentViewController ()

@end

@implementation TK_CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSource=self;
    self.delegate=self;
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    self.title = @"提問";
    
    self.messageInputView.textView.placeHolder = @"Your placeholder text";
    
    self.sender = @"Username of sender";
    
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSMessage alloc] initWithText:@"歡迎使用 提問系統  右上角 可以選擇發送對象" sender:@"user" date:[NSDate distantPast]],
                     nil];
    
    
    

    self.avatars = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [JSAvatarImageFactory avatarImageNamed:@"avatar-placeholder" croppedToCircle:YES], @"user",
                    nil];
    
    UIBarButtonItem *rightButton= [[UIBarButtonItem alloc] initWithTitle:@"to All" style:UIBarButtonItemStylePlain target:self action:@selector(changeTarget:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    // Do any additional setup after loading the view from its nib.
}
-(void) showMenu
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowMenuViewController object:nil];
    
}

-(void) changeTarget :(UIBarButtonItem *) sender
{
    if([sender.title isEqualToString:@"to All"])
        sender.title = @"Teacher";
    else
        sender.title = @"to All";
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

#pragma mark - Messages view delegate: REQUIRED

- (void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date
{
    if ((self.messages.count - 1) % 2) {
        [JSMessageSoundEffect playMessageSentSound];
    }
    else {
            // for demo purposes only, mimicing received messages
        [JSMessageSoundEffect playMessageReceivedSound];
        sender = arc4random_uniform(10) % 2 ? @"user" : @"other";
    }
    
    [self.messages addObject:[[JSMessage alloc] initWithText:text sender:sender date:date]];
    
    [self finishSend];
    [self scrollToBottomAnimated:YES];
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row % 3) ? JSBubbleMessageTypeIncoming : JSBubbleMessageTypeOutgoing;
}

- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 3) {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                          color:[UIColor js_bubbleLightGrayColor]];
    }
    
    return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                      color:[UIColor js_bubbleBlueColor]];
}

- (JSMessageInputViewStyle)inputViewStyle
{
    return JSMessageInputViewStyleFlat;
}

#pragma mark - Messages view delegate: OPTIONAL

- (BOOL)shouldDisplayTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 3 == 0) {
        return YES;
    }
    return NO;
}

    //
    //  *** Implement to customize cell further
    //
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if ([cell messageType] == JSBubbleMessageTypeOutgoing) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
        
        if ([cell.bubbleView.textView respondsToSelector:@selector(linkTextAttributes)]) {
            NSMutableDictionary *attrs = [cell.bubbleView.textView.linkTextAttributes mutableCopy];
            [attrs setValue:[UIColor blueColor] forKey:UITextAttributeTextColor];
            
            cell.bubbleView.textView.linkTextAttributes = attrs;
        }
    }
    
    if (cell.timestampLabel) {
        cell.timestampLabel.textColor = [UIColor lightGrayColor];
        cell.timestampLabel.shadowOffset = CGSizeZero;
    }
    
    if (cell.subtitleLabel) {
        cell.subtitleLabel.textColor = [UIColor lightGrayColor];
    }
    
#if TARGET_IPHONE_SIMULATOR
    cell.bubbleView.textView.dataDetectorTypes = UIDataDetectorTypeNone;
#else
    cell.bubbleView.textView.dataDetectorTypes = UIDataDetectorTypeAll;
#endif
}

    //  *** Implement to use a custom send button
    //
    //  The button's frame is set automatically for you
    //
    //  - (UIButton *)sendButtonForInputView
    //

    //  *** Implement to prevent auto-scrolling when message is added
    //
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}

    // *** Implemnt to enable/disable pan/tap todismiss keyboard
    //
- (BOOL)allowsPanToDismissKeyboard
{
    return YES;
}

#pragma mark - Messages view data source: REQUIRED

- (JSMessage *)messageForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.row];
}

- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath sender:(NSString *)sender
{
    UIImage *image = [self.avatars objectForKey:sender];
    return [[UIImageView alloc] initWithImage:image];
}
@end