//
//  NSString+YYHelper.h
//  Appsence
//
//  Created by Yoppy Yunhasnawa on 8/12/13.
//  Copyright (c) 2013 Yunhasnawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYHelper)

- (NSString*) stringFromIndex:(NSUInteger) start toIndex:(NSUInteger) end;
- (NSString*) uppercaseFirst;
- (NSString*) YYYYMMDDStringFromDateString:(NSString*) dateString;
- (NSUInteger) indexOfString:(NSString*) string;
- (NSString*) stringByReplacingCharacterAtIndex:(NSInteger)index withString:(NSString *)string;

@end
