//
//  YYAppHelper.h
//  Appsence
//
//  Created by Yoppy Yunhasnawa on 8/20/13.
//  Copyright (c) 2013 Yunhasnawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYAppHelper : NSObject

+ (BOOL) isIOS7OrLater;
+ (NSInteger) minutesFromStringHour:(NSString*) hourString separator:(NSString*) separator;
+ (NSDecimalNumber*) decimalNumber:(NSDecimalNumber*) number restrictFractionalDigitsCount:(NSInteger) count;
+ (NSString*) stringCurrencyWitDecimalNumber:(NSDecimalNumber*) decimalNumber;
+ (NSString*) stringDecimalNumber:(NSDecimalNumber*) number restrictFractionalDigitsCount:(NSInteger) count;
+ (NSString*) documentPathForFileName:(NSString *)file type:(NSString *)type;
+ (NSString*) documentPath;
+ (void) setIconBadgeNumber:(NSInteger) newNumber;
+ (NSURL *) applicationDocumentsDirectory;

CGRect CGRectResizeFitWidth(CGRect rect, CGFloat width);

@end
