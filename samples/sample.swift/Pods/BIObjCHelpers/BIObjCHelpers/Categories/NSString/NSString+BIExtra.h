//
//  NSString+BIExtra.h
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 18/06/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BIExtra)

+ (nonnull instancetype)randomString;
+ (nonnull instancetype)randomStringOfLength:(NSUInteger)length;

- (BOOL)isValidEmail;

@end
