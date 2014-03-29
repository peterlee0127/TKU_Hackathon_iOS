//
//  TKU_CourseSearch.h
//  TKU_CourseSearch
//
//  Created by Peterlee on 3/29/14.
//  Copyright (c) 2014 Peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SearchCourseCompleteHandler)(NSArray *data,NSError *error);


@interface TKU_CourseSearch : NSObject


+(instancetype) shareInstance;
-(void) searchCourse:(NSString *) stuid WithPassword:(NSString *) password block:(SearchCourseCompleteHandler) completeblock;



@end
