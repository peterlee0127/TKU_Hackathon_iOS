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
    filePath = [documentsDirectory stringByAppendingString:@"setting.plist"];
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
}
-(NSDictionary *) loadUserInfo
{
    return self.plistDict;
}
-(void) saveToPlist
{
    [self.plistDict writeToFile:filePath atomically:NO];
}



@end
