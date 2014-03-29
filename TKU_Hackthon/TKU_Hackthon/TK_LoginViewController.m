//
//  TK_LoginViewController.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_LoginViewController.h"

@interface TK_LoginViewController ()

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
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view from its nib.
}

-(void) login
{
    if([self.accountTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""])
        return;
    
    TKU_CourseSearch *courseSearch =[TKU_CourseSearch shareInstance];
    [courseSearch searchCourse:self.accountTextField.text  WithPassword:self.passwordTextField.text block:^(NSArray *data, NSError *error) {
       if(error)
        {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"登入錯誤" message:@"請檢查學號/密碼是否有錯誤" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
            [alert show];
            return ;
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
