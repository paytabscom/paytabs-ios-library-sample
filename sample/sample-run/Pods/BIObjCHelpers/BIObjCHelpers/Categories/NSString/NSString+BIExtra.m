//
//  NSString+BIExtra.m
//  BIObjCHelpersExample
//
//  Created by Bogdan Iusco on 18/06/15.
//  Copyright (c) 2015 Bogdan Iusco. All rights reserved.
//

#import "NSString+BIExtra.h"

@implementation NSString (BIExtra)

+ (nonnull instancetype)randomString {
    NSUInteger length = arc4random() % 10 + 1;
    return [[self class] randomStringOfLength:length];
}

+ (nonnull instancetype)randomStringOfLength:(NSUInteger)length {
    static NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return [NSString stringWithString:s];
}

- (BOOL)isValidEmail {
    // From http://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

@end
