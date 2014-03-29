//
//  TK_PlistModel.h
//  TKU_Hackthon
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TK_PlistModel : NSObject

@property (nonatomic,strong) NSMutableDictionary *plistDict;


+(instancetype) shareInstance;
-(void) saveUserInfo:(NSString *) stu_id andPass:(NSString *) password;
-(NSDictionary *) loadUserInfo;



@end
