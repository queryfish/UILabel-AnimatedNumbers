//
//  NSObject+AutoJSONSerialization.m
//  FredoAlarm
//
//  Created by kfir on 13-7-27.
//  Copyright (c) 2013年 Wu Xueming. All rights reserved.
//

#import "NSObject+AutoJSONSerialization.h"
#import <objc/runtime.h>

@implementation NSObject (AutoJSONSerialization)

-(NSDictionary *)autoDict
{
    Class clazz = [self class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:propertyArray.count];
    for(NSString* k in propertyArray)
    {
        id v = [self valueForKey:k];
        [dict setValue:v?v:[NSNull null] forKey:k];
    }
    return dict;
}

-(NSDictionary *)autoDictNoNull
{
    Class clazz = [self class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:propertyArray.count];
    for(NSString* k in propertyArray){
        id v = [self valueForKey:k];
        if(v){
            [dict setValue:v forKey:k];
        }
    }
    return dict;
}

-(id)elementalize
{
    __typeof (&*self) __weak weakself = self;
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    else if ([self isKindOfClass:[NSArray class]]) {
        NSArray* array = (NSArray*)weakself;
        NSMutableArray* result = [NSMutableArray new];
        for (id e in array) {
            [result addObject:[e elementalize]];
        }
        return result;
    }
    else if([self isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dict = (NSDictionary*)weakself;
        NSMutableDictionary* result = [NSMutableDictionary new];
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if([obj isKindOfClass:[NSObject class]])
                [result setValue:[obj elementalize] forKey:key];
        }];
        return result;
    }
    else if([self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSString class]])
    {
        return self;
    }
    else
    {
        return [[self autoDict] elementalize];
    }
}

-(NSDictionary *)autoDictFromPropertyList:(NSArray *)plist
{
    NSLog(@"dicts : %@",[self dictionaryWithValuesForKeys:plist]);
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:plist.count];
    for(NSString* k in plist){
        id v = [self valueForKey:k];
        if(v){
            [dict setValue:v forKey:k];
        }
    }
    return dict;
}

/*
-(void)dumpInfo:(Subject*)subj
{
    Class clazz = [Subject class];
    u_int count;
    
    Ivar* ivars = class_copyIvarList(clazz, &count);
    NSMutableArray* ivarArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* ivarName = ivar_getName(ivars[i]);
        [ivarArray addObject:[NSString  stringWithCString:ivarName encoding:NSUTF8StringEncoding]];
    }
    free(ivars);
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    Method* methods = class_copyMethodList(clazz, &count);
    NSMutableArray* methodArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        SEL selector = method_getName(methods[i]);
        const char* methodName = sel_getName(selector);
        [methodArray addObject:[NSString  stringWithCString:methodName encoding:NSUTF8StringEncoding]];
    }
    free(methods);
    
    NSDictionary* classDump = [NSDictionary dictionaryWithObjectsAndKeys:
                               ivarArray, @"ivars",
                               propertyArray, @"properties",
                               methodArray, @"methods",
                               nil];
    NSLog(@"dicts : %@",[subj dictionaryWithValuesForKeys:propertyArray]);
    NSLog(@"dicts to JSON : %@", [[subj dictionaryWithValuesForKeys:propertyArray] JSONString]);
    //    NSLog(@"%@", classDump);
}
*/
@end
