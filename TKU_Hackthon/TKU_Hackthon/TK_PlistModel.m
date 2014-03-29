//
//  TK_PlistModel.m
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import "TK_PlistModel.h"

@implementation TK_PlistModel
{
    NSString *filePath;
}
+(instancetype) shareInstance
{
    static TK_PlistModel *shareInstance_ =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance_ =[[TK_PlistModel alloc] init];
    });

    return shareInstance_;
}
-(id) init
{
    self = [super init];
    if(self)
    {
        [self createPlist];
    }
    return self;
}
-(void) createPlist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    filePath = [documentsDirectory stringByAppendingString:@"/setting.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath: filePath])
    {
            self.plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
            // load from plist
    }
    else
    {
            self.plistDict = [[NSMutableDictionary alloc] init];    // create
            [self saveToPlist];
    }
}
-(void) saveUserInfo:(NSString *) stu_id andPass:(NSString *) password
{
    if([stu_id isEqualToString:@"admin@admin"])
        self.plistDict[kUserIsAdmin]= @"YES";
    
    self.plistDict[kstu_id] = stu_id;
    self.plistDict[kpassword] = password;
    
    [self saveToPlist];
}
-(NSDictionary *) loadUserInfo
{
    return self.plistDict;
}
-(BOOL) UserIsAdmin
{
    if([self.plistDict[kstu_id] isEqualToString:@"admin@admin"] && [self.plistDict[kpassword] isEqualToString:@"admin"])
        return YES;
    else
        return NO;
}

-(void) saveUserCourse :(NSArray *) courseArray
{
    self.plistDict[kUserCourse] = courseArray;
     [self saveToPlist];
}
-(NSArray *) loadUserCourse
{
    return self.plistDict[kUserCourse];
}

-(void) saveToPlist
{
    dispatch_async(dispatch_get_main_queue(), ^{
    if([self.plistDict writeToFile:filePath atomically:NO])
        NSLog(@"save success");
    });
}



@end
