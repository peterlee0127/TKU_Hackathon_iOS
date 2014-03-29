//
//  TK_FrontViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_UserCourseViewController.h"
#import "TK_PlistModel.h"
#import "TK_UserCourseCollectionViewCell.h"
#import "TK_WebSocket.h"

@interface TK_UserCourseViewController ()

@end

@implementation TK_UserCourseViewController
{
    TK_WebSocket *websocket;
}
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
    self.title =@"學生課表";
    
    TK_PlistModel *plist = [TK_PlistModel shareInstance];
    websocket =[TK_WebSocket shareInstance];
    
    self.courseArray = [plist loadUserCourse];
    
    
    self.collectionView =[[UICollectionView alloc] initWithFrame:self.collectionView.frame collectionViewLayout:self.flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TK_UserCourseCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UserCourseCollectionViewCell"];
    
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
 
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return self.courseArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TK_UserCourseCollectionViewCell *cell =[self.collectionView dequeueReusableCellWithReuseIdentifier:@"UserCourseCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dict =self.courseArray[indexPath.row];
    cell.courseNameLabel.text = dict[@"name"];
    cell.timeLabel1.text = dict[@"time1"];
    cell.dayLabel1.text = dict[@"day1"];
    cell.roomLabel1.text = dict[@"room1"];
    
    
    if([dict[@"twotime"] isEqualToString:@"YES"])
    {
        cell.timeLabel2.text = dict[@"time2"];
        cell.dayLabel2.text = dict[@"day2"];
        cell.roomLabel2.text = dict[@"room2"];
    }
    
    return cell;
}



@end
