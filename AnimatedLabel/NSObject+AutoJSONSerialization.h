//
//  NSObject+AutoJSONSerialization.h
//  FredoAlarm
//
//  Created by kfir on 13-7-27.
//  Copyright (c) 2013年 Wu Xueming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AutoJSONSerialization)
-(NSDictionary*) autoDict;
-(NSDictionary*) autoDictNoNull;
-(NSDictionary*) autoDictFromPropertyList:(NSArray*)l;
-(id)elementalize;
@end
