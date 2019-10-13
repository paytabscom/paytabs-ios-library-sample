//
//  NSDate+BIAttributedString.h
//  BIObjCHelpersExample
//
//  Created by Mihai Chifor on 7/15/15.
//  Copyright © 2015 Bogdan Iusco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BIAttributedString)

//default format : 2015, July 14th 9:31am (yyyy, MMMM d* h:mm*)

- (nonnull NSAttributedString *)yearStringWithAttributes:(NSDictionary * __nonnull)attributes;
- (nonnull NSAttributedString *)monthStringWithAttributes:(NSDictionary * __nonnull)attributes;
- (nonnull NSAttributedString *)dayStringWithAttributes:(NSDictionary * __nonnull)attributes;
- (nonnull NSAttributedString *)hourStringWithAttributes:(NSDictionary * __nonnull)attributes;

//custom format
- (nonnull NSAttributedString *)yearStringWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format;
- (nonnull NSAttributedString *)monthStringWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format;
- (nonnull NSAttributedString *)dayStringWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format;
- (nonnull NSAttributedString *)hourStringWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format;

- (nonnull NSAttributedString *)calendarComponentsWithAttributes:(NSDictionary * __nonnull)attributes format:(NSString * __nonnull)format;

//suffixes
- (nonnull NSAttributedString *)daySuffixWithAttributes:(NSDictionary * __nonnull)attributes;
- (nonnull NSAttributedString *)hourSuffixWithAttributes:(NSDictionary * __nonnull)attributes;

@end
