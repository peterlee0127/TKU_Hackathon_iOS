//
//  TK_LoginViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_LoginViewController.h"
#import "TK_PlistModel.h"
#import "PLHUDView.h"

@interface TK_LoginViewController ()
{
    TK_PlistModel *plistModel;
}
@end

@implementation TK_LoginViewController

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
    plistModel =[TK_PlistModel shareInstance];
    NSDictionary *userDict =[plistModel loadUserInfo];
    self.accountTextField.text=userDict[kstu_id];
    self.passwordTextField.text = userDict[kpassword];
    
    
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view from its nib.
}

-(void) login
{
    if([self.accountTextField.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"學號/管理帳號 不能空白喔" message:@"請填入" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if([self.passwordTextField.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"密碼 不能空白喔" message:@"請填入" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    

    [plistModel saveUserInfo:self.accountTextField.text andPass:self.passwordTextField.text];
    PLHUDView *hud =[[PLHUDView alloc]initHUDWithType:HUDActivityIndicatorType];
    [hud setHUDTitle:@"登入中"];
    hud.HUDAlpha=0.7;
    [hud showHUD];
    [self.view addSubview:hud];
    
    TKU_CourseSearch *courseSearch =[TKU_CourseSearch shareInstance];
    [courseSearch searchCourse:self.accountTextField.text  WithPassword:self.passwordTextField.text block:^(NSArray *data) {
       
        
       if(data.count==0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideHUD];
                UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登入錯誤" message:@"請檢查學號/密碼是否有錯誤" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
                [alert show];
            });
            
            return ;
        }
        if(data.count>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideHUD];
                [plistModel  saveUserCourse:data];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginSuccess" object:nil];
            });

        }
        
       
        
        NSLog(@"data:%@",data);
        
    }];

}
-(IBAction) closeKeyboard :(id) sender
{
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

@end
