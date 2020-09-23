//
//  PTFWResponseTransactionPMIGSAuth.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/29/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

FOUNDATION_EXTERN const struct PTFWResponseTokenizationKeys {
    __unsafe_unretained NSString * __nonnull tokenizedCustomerEmail;
    __unsafe_unretained NSString * __nonnull tokenizedCustomerPassword;
    __unsafe_unretained NSString * __nonnull paytabsToken;
} PTFWResponseTokenizationKeys;

@interface PTFWResponseTokenization : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, nullable, readonly) NSString *tokenizedCustomerEmail;
@property (nonatomic, copy, nullable, readonly) NSString *tokenizedCustomerPassword;
@property (nonatomic, copy, nullable, readonly) NSString *paytabsToken;

@end
