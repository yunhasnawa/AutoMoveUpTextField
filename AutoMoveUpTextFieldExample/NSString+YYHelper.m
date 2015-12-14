//
//  NSString+YYHelper.m
//  Appsence
//
//  Created by Yoppy Yunhasnawa on 8/12/13.
//  Copyright (c) 2013 Yunhasnawa. All rights reserved.
//

#import "NSString+YYHelper.h"

@implementation NSString (YYHelper)

- (NSString*) stringFromIndex:(NSUInteger)start toIndex:(NSUInteger)end
{
    NSString* copy = @"";
    
    NSUInteger count = [self length];
    
    for(NSUInteger i = start; i <= end; i++)
    {
        if(i < count)
        {
            if((NSInteger)i < 0)
            {
                continue;
            }
            
            unichar c = [self characterAtIndex:i];
        
            copy = [copy stringByAppendingFormat:@"%c", c];
        }
        else
        {
            break;
        }
    }
    
    return copy;
}

- (NSString*) uppercaseFirst
{
    NSString* firstUp = [[self substringToIndex:1] uppercaseString];
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstUp];
}

- (NSString*) YYYYMMDDStringFromDateString:(NSString *)dateString
{
    NSArray* explode = [dateString componentsSeparatedByString:@" "];
    
    NSString* ymd = [explode objectAtIndex:0];
    
    NSString* result = [ymd stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return result;
}

- (NSUInteger) indexOfString:(NSString*) string
{
    NSRange searchRange = [self rangeOfString:string];
    
    return searchRange.location;
}

- (NSString*) stringByReplacingCharacterAtIndex:(NSInteger)index withString:(NSString *)string
{
    NSRange range;
    range.length = 1;
    range.location = index;
    
    return [self stringByReplacingCharactersInRange:range withString:string];
}

@end
