//
//  TK_VoteViewController.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/30/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_TopViewController.h"

@interface TK_VoteViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIButton *AButton;
@property (nonatomic,strong) IBOutlet UIButton *BButton;
@property (nonatomic,strong) IBOutlet UIButton *CButton;
@property (nonatomic,strong) IBOutlet UIButton *DButton;

@property (nonatomic,strong) IBOutlet UIButton *doneButton;
@property (nonatomic,strong) IBOutlet UILabel *chooseLabel;

@property (nonatomic,strong) NSDictionary *dict;

@end
