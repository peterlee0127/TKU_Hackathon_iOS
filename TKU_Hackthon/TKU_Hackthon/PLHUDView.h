//
//  PLHUDView.h
//
//
//  Created by Peterlee on 1/14/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>


enum hudType {
    HUDImageType=0,
    HUDActivityIndicatorType=1,
    HUDCustomeType=2
};

typedef void (^hudComplete)(void);

@interface PLHUDView : UIView


@property (nonatomic,strong) UILabel *mainLabel;
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UIView *hudView;
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,assign) NSUInteger HUDType;
@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,assign) CGFloat HUDAlpha;


@property (nonatomic,copy) hudComplete hudCompleteHandler;


#pragma mark - Init
-(id)initHUDWithType:(NSUInteger) HUDType;

#pragma mark - Setting
-(void) setHUDImage:(UIImage *)image;
-(void) setHUDTitle:(NSString *) title;

#pragma mark - Add View to HUD

-(void) addViewToHUD:(UIView *) contentView;


#pragma mark - HUD Action
-(void) showHUDwithDuration;

-(void) showHUDwithDoneButton;
-(void) showHUD;
-(void) hideHUD;


#pragma mark - HUD Complete Block
-(void) hudCompleteHandler:(hudComplete) hudHandle;

+(void) setMotionEffectToHUD:(UIView *) view;

@end
