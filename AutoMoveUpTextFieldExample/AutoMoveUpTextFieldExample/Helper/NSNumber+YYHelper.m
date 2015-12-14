//
//  NSNumber+YYHelper.m
//  Appsence
//
//  Created by Yoppy Yunhasnawa on 8/20/13.
//  Copyright (c) 2013 Yunhasnawa. All rights reserved.
//

#import "NSNumber+YYHelper.h"

@implementation NSNumber (YYHelper)

+ (NSNumber*) numberWithString:(NSString *)string
{
    BOOL pointExist = [string rangeOfString:@"."].location != NSNotFound;
    
    if(pointExist)
    {
        return [NSNumber numberWithString:string pointSign:@"."];
    }
    else
    {
        return [NSNumber numberWithNoPointSignString:string];
    }
}

+ (NSNumber*) numberWithString:(NSString*) string pointSign:(NSString*) point
{
    NSArray* splits = [string componentsSeparatedByString:point];
    
    NSString* mainNum = [splits objectAtIndex:0];
    NSString* fracNum = [splits objectAtIndex:1];
    
    NSNumber* mainNumber = [NSNumber numberWithNoPointSignString:mainNum];
    NSNumber* fracNumber = [NSNumber numberWithNoPointSignString:fracNum];
    
    double fracDouble = [fracNumber doubleValue];
    
    NSInteger divider = pow(10, [fracNum length]);
    
    fracDouble /= divider;
    
    double mainDouble = [mainNumber doubleValue];
    
    double join = mainDouble + fracDouble;
    
    return [NSNumber numberWithDouble:join];
}

+ (NSNumber*) numberWithNoPointSignString:(NSString*) string
{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber* number = [formatter numberFromString:string];
    
    return number;
}

@end
