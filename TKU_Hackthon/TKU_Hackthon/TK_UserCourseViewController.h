//
//  TK_FrontViewController.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TK_TopViewController.h"

@interface TK_UserCourseViewController : TK_TopViewController <UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) NSArray *courseArray;

@end
