//
//  PLHUDView.m
//
//
//  Created by Peterlee on 1/14/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "PLHUDView.h"
#import <QuartzCore/QuartzCore.h>

#pragma mark - PLHUD DurationSetting
static float const PLHUDShowDuration=0.2;
static float const PLHudHideDuration=0.4;

@implementation PLHUDView
{
    UIButton *doneButton;
    UIActivityIndicatorView *progressView;
}
+(void) setMotionEffectToHUD:(UIView *) view
{
    if([[UIDevice currentDevice].systemVersion integerValue]>=7)
        {
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-14);
        verticalMotionEffect.maximumRelativeValue = @(14);
        
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-14);
        horizontalMotionEffect.maximumRelativeValue = @(14);
        
        UIInterpolatingMotionEffect *shadowEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"layer.shadowOffset" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        shadowEffect.minimumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(-14, 8)];
        shadowEffect.maximumRelativeValue = [NSValue valueWithCGSize:CGSizeMake(14, 8)];
        
        UIMotionEffectGroup *group = [UIMotionEffectGroup new];
        group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect,shadowEffect];
        [view addMotionEffect:group];
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
        // Initialization code
        self.alpha=0; //default HUD alpha
        self.backgroundColor=[UIColor clearColor];
        self.frame=[[UIScreen mainScreen] bounds];
        
        self.backView=[[UIView alloc] initWithFrame:self.frame];
        self.backView.backgroundColor=[UIColor blackColor];
        [self.backView setAlpha:0.2];
        [self addSubview:self.backView];
        
        self.hudView=[[UIView alloc] init];
        self.hudView.backgroundColor=[UIColor whiteColor];
        [self.hudView.layer setCornerRadius:10];
        [self.hudView.layer setMasksToBounds:YES];
        [self addSubview:self.hudView];
        
        self.mainLabel=[[UILabel alloc] init];
        self.mainLabel.backgroundColor=[UIColor clearColor];
        self.mainLabel.textAlignment=NSTextAlignmentCenter;
        self.mainLabel.font=[UIFont systemFontOfSize:15];
        [self.hudView addSubview:self.mainLabel];
        
    }
    return self;
}
#pragma mark - Set HUD Type
-(id)initHUDWithType:(NSUInteger) HUDType
{
    self=[super init];
    if(!self)
        return nil;
        
    [self setHUDType:HUDType];
    
    return self;
}

-(void) setHUDType:(NSUInteger)HUDType
{
    switch (HUDType) {
        case HUDActivityIndicatorType:
        {
            self.mainLabel.frame=CGRectMake(5, 90,150, 40);
            self.hudView.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width/2-80,[[UIScreen mainScreen] bounds].size.height/2-80,160,140);
            progressView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            progressView.frame=CGRectMake(30, 20, 100, 80);
            progressView.color=[UIColor blackColor];
            [self.hudView addSubview:progressView];
            [progressView startAnimating];
            break;
        }
        case HUDImageType:
        {
            self.mainLabel.frame=CGRectMake(5, 90,150, 40);
            self.hudView.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width/2-80,[[UIScreen mainScreen] bounds].size.height/2-80,160,140);
            self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake((self.hudView.frame.size.width-52)/2, self.hudView.frame.size.width/3-20,52 , 52)];
            [self.hudView addSubview:self.imageView];
            break;
        }
        case HUDCustomeType:
        {
            self.hudView.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width/2-110,[[UIScreen mainScreen] bounds].size.height/2-110,220,200);
        
            self.mainLabel.frame=CGRectMake(5, 4, 210, 40);
            self.mainLabel.textAlignment=NSTextAlignmentCenter;
 
        
            self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake((self.hudView.frame.size.width-40)/2, self.hudView.frame.size.height-10-60,40 , 40)];
            [self.hudView addSubview:self.imageView];
            break;
        }
    }
    
    doneButton=[[UIButton alloc] initWithFrame:CGRectMake( self.hudView.frame.size.width/2-30 ,self.hudView.frame.size.height-25 , 60, 20)];
    doneButton.backgroundColor=[UIColor clearColor];
    doneButton.alpha=0;
    [doneButton addTarget:self action:@selector(hideHUD) forControlEvents:UIControlEventTouchDown];
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.hudView addSubview:doneButton];
    
    
    self.mainLabel.adjustsFontSizeToFitWidth = YES;
    self.mainLabel.minimumFontSize=8;
    self.mainLabel.numberOfLines=1;
}

#pragma mark - Set Image
-(void) setHUDImage:(UIImage *)image
{
    [self.imageView setImage:image];
}
#pragma mark - Set Title
-(void) setHUDTitle:(NSString *) title
{
    self.mainLabel.text=title;
}

#pragma mark - HUD addSubView
-(void) addViewToHUD:(UIView *) contentView
{
    contentView.frame=CGRectMake(self.hudView.frame.size.width/2-contentView.frame.size.width/2, self.mainLabel.frame.size.height+5, contentView.frame.size.width, contentView.frame.size.height);
    [self.hudView addSubview:contentView];
    
}

#pragma mark - HUD Action with Duration
-(void) showHUDwithDuration
{
    [UIView animateWithDuration:PLHUDShowDuration animations:^{
         self.alpha=self.HUDAlpha;
    } completion:^(BOOL finished) {
        [self hide];
    }];
}
-(void) hide
{
    [UIView animateWithDuration:PLHudHideDuration delay:self.duration options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        self.alpha=0;
     
    } completion:^(BOOL finished) {
        if(_hudCompleteHandler)
        {
            _hudCompleteHandler();
        }
        [progressView stopAnimating];
    }];
}

#pragma mark - HUD Action without Duration
-(void) showHUDwithDoneButton
{
    doneButton.alpha=1;
    [UIView animateWithDuration:PLHUDShowDuration animations:^{
        self.alpha=self.HUDAlpha;
    }];
}
-(void) showHUD
{
    [UIView animateWithDuration:PLHUDShowDuration animations:^{
        self.alpha=self.HUDAlpha;
    } ];
}
-(void) hideHUD
{
  
    [UIView animateWithDuration:PLHudHideDuration animations:^{
        self.alpha=0;

    } completion:^(BOOL finished) {
        if(_hudCompleteHandler)
        {
            _hudCompleteHandler();
        }
        doneButton.alpha=0;
        [progressView stopAnimating];
    }];
}

#pragma mark - HUD Complete Block
-(void) hudCompleteHandler:(hudComplete) hudHandle
{
    _hudCompleteHandler=hudHandle;
}


@end
