//
//  NSString+Helpers.h
//  paytabs-iOS
//
//  Created by Humayun Sohail on 10/11/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

#pragma mark - Public Methods
- (BOOL)isValidAddressString;
- (BOOL)isValidPhoneNumberString;
- (BOOL)isValidCreditCardExpiryDate;
- (BOOL)isValidCreditCardHolderName;

- (NSString *)getCreditCardExpiryDate;
- (NSString *)getCreditCardholderFirstName;
- (NSString *)getCreditCardholderLastName;

- (NSString *)urlencodedString;
- (NSString *)strippedHTMLString;
@end
