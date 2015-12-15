//
//  YYAppHelper.m
//  Appsence
//
//  Created by Yoppy Yunhasnawa on 8/20/13.
//  Copyright (c) 2013 Yunhasnawa. All rights reserved.
//

#import "YYAppHelper.h"
#import "NSNumber+YYHelper.h"
#import "NSString+YYHelper.h"

@interface YYAppHelper ()

+ (NSString*) roundUpFractionTemp:(NSString*) temp;

@end

@implementation YYAppHelper

+ (void) setIconBadgeNumber:(NSInteger) newNumber
{
    NSInteger numberOfBadges = [[UIApplication sharedApplication] applicationIconBadgeNumber];
    
    numberOfBadges = newNumber;
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:numberOfBadges];
}

+ (BOOL) isIOS7OrLater
{
    return floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1;
}

+ (NSInteger) minutesFromStringHour:(NSString*) hourString separator:(NSString*) separator
{
    if([hourString isEqualToString:@""])
    {
        return -1;
    }
    
    NSArray* components = [hourString componentsSeparatedByString:separator];
    
    NSString* strHour   = [components objectAtIndex:0];
    NSString* strMinute = [components objectAtIndex:1];
    
    NSNumber* hour   = [NSNumber numberWithString:strHour];
    NSNumber* minute = [NSNumber numberWithString:strMinute];
    
    NSInteger total = ([hour integerValue] * 60) + [minute integerValue];
    
    return total;
}

+ (NSDecimalNumber*) decimalNumber:(NSDecimalNumber*) number restrictFractionalDigitsCount:(NSInteger) count
{
    NSString* stringValue = [YYAppHelper stringDecimalNumber:number restrictFractionalDigitsCount:count];
    
    return [NSDecimalNumber decimalNumberWithString:stringValue];
}

+ (NSString*) stringDecimalNumber:(NSDecimalNumber*) number restrictFractionalDigitsCount:(NSInteger) count
{
    NSString* toString = [number stringValue];
    
    BOOL commaExist = [toString rangeOfString:@"."].location != NSNotFound;
    
    NSString* decimalString = [number stringValue];
    
    if(commaExist)
    {
        NSArray* splits = [toString componentsSeparatedByString:@"."];
        
        if([splits count] > 1)
        {
            NSString* fraction = [splits objectAtIndex:1];
            
            if(![fraction isEqualToString:@""])
            {
                if([fraction length] > count)
                {
                    if([fraction length] >= count + 1)
                    {
                        NSString* fractionTemp = [fraction substringToIndex:count + 1]; // ini kalau digitnya dua jadi .003 harusnya .00, ini buat ngecek belakangnya.
                        
                        fraction = [YYAppHelper roundUpFractionTemp:fractionTemp];
                    }
                    
                    fraction = [fraction substringToIndex:count];
                }
                else
                {
                    // Add 0 if less than count;
                    NSInteger substract = count - [fraction length];
                    
                    for(NSInteger i = 0; i < substract; i++)
                    {
                        fraction = [fraction stringByAppendingString:@"0"];
                    }
                }
                
                NSString* mainNumber = [splits objectAtIndex:0];
                
                decimalString = [NSString stringWithFormat:@"%@.%@", mainNumber, fraction];
            }
        }
    }
    else
    {
        NSString* zero = @".";
        
        for(int i = 0; i < count; i++)
        {
            zero = [zero stringByAppendingString:@"0"];
        }
        
        decimalString = [decimalString stringByAppendingString:zero];
    }
    
    return decimalString;
}

+ (NSString*) stringCurrencyWitDecimalNumber:(NSDecimalNumber*) decimalNumber
{
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    return [formatter stringFromNumber:decimalNumber];
}

#pragma mark - Private helper

+ (NSString*) roundUpFractionTemp:(NSString*) temp
{
    NSInteger index = [temp length] - 1;
    
    char last = [temp characterAtIndex:index];
    
    NSString* lastString = [NSString stringWithFormat:@"%c", last];
    
    BOOL isNotZero = ![lastString isEqualToString:@"0"];
    
    if(isNotZero)
    {
        NSString* slice = [temp substringToIndex:[temp length] - 1];
        
        NSDecimalNumber* sliceDecimal = [NSDecimalNumber decimalNumberWithString:slice];
        
        if([sliceDecimal doubleValue] <= 0.f)
        {
            NSInteger lastIndex = [slice length] - 1;
            
            temp = [slice stringByReplacingCharacterAtIndex:lastIndex withString:@"1"];
        }
        else
        {
            NSNumber* number = [NSNumber numberWithString:temp];
            
            NSInteger toInt = [number integerValue];
            
            toInt += 10;
            
            temp = [NSString stringWithFormat:@"%ld", (long)toInt];
        }
    }
    
    return temp;
}

+ (NSString *)documentPathForFileName:(NSString *)file type:(NSString *)type
{
    NSString* docPath = [YYAppHelper documentPath];
    
    NSString* fileName = [NSString stringWithFormat:@"%@.%@", file, type, nil];
    
    NSString* filePath = [docPath stringByAppendingPathComponent:fileName];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:filePath])
    {
        NSString* sourcePath = [[NSBundle mainBundle] pathForResource:file ofType:type];
        
        if([fileManager fileExistsAtPath:sourcePath])
        {
            [fileManager copyItemAtPath:sourcePath toPath:docPath error:nil];
        }
    }
    
    return filePath;
}

+ (NSString*) documentPath
{
    NSArray* searches = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* docPath = [searches lastObject];
    
    return docPath;
}

+ (NSURL*) applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - C style functions

CGRect CGRectResizeFitWidth(CGRect rect, CGFloat newWidth)
{
    CGFloat originWidth  = rect.size.width;
    CGFloat originHeight = rect.size.height;
    
    CGFloat ratio = newWidth / originWidth;
    
    CGFloat newHeight = ratio * originHeight;
    
    return CGRectMake(rect.origin.x, rect.origin.y, newWidth, newHeight);
}

void CGRectLog(CGRect rect)
{
    NSLog(@"{x:%f, y:%f, width:%f, height:%f}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
}

@end