//
//  TK_UserCourseCollectionViewCell.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TK_UserCourseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) IBOutlet UILabel *courseNameLabel;

@property (nonatomic,strong) IBOutlet UILabel *dayLabel1;
@property (nonatomic,strong) IBOutlet UILabel *dayLabel2;


@property (nonatomic,strong) IBOutlet UILabel *timeLabel1;
@property (nonatomic,strong) IBOutlet UILabel *timeLabel2;


@property (nonatomic,strong) IBOutlet UILabel *roomLabel1;
@property (nonatomic,strong) IBOutlet UILabel *roomLabel2;


@end
