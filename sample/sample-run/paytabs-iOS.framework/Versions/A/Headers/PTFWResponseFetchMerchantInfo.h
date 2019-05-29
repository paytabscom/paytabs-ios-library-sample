//
//  PTFWResponseFetchMerchantInfo.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/15/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

FOUNDATION_EXTERN const struct PTFWResponseFetchMerchantInfoKeys {
    __unsafe_unretained NSString * __nonnull result;
    __unsafe_unretained NSString * __nonnull responseCode;
    __unsafe_unretained NSString * __nonnull merchantLogo;
    __unsafe_unretained NSString * __nonnull merchantTitle;
    __unsafe_unretained NSString * __nonnull merchantPhone;
    __unsafe_unretained NSString * __nonnull merchantCurrency;
    __unsafe_unretained NSString * __nonnull transactionCurrency;
    __unsafe_unretained NSString * __nonnull transactionAmount;
    __unsafe_unretained NSString * __nonnull transactionExchangeRate;
    __unsafe_unretained NSString * __nonnull maximumAmount;
    __unsafe_unretained NSString * __nonnull minimumAmount;
    __unsafe_unretained NSString * __nonnull profileTitle;
    __unsafe_unretained NSString * __nonnull deviceFPSessionID;
    __unsafe_unretained NSString * __nonnull deviceFPOrganizationID;
    __unsafe_unretained NSString * __nonnull paymentTimeout;
    __unsafe_unretained NSString * __nonnull secretKey;
    __unsafe_unretained NSString * __nonnull merchantEmail;
} PTFWResponseFetchMerchantInfoKeys;

@interface PTFWResponseFetchMerchantInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, nullable, readonly) NSString *result;
@property (nonatomic, copy, nullable, readonly) NSString *responseCode;
@property (nonatomic, copy, nullable, readonly) NSString *merchantLogo;
@property (nonatomic, copy, nullable, readonly) NSString *merchantTitle;
@property (nonatomic, copy, nullable, readonly) NSString *merchantPhone;
@property (nonatomic, copy, nullable, readonly) NSString *merchantCurrency;
@property (nonatomic, copy, nullable, readonly) NSString *transactionCurrency;
@property (nonatomic, copy, nullable, readonly) NSNumber *transactionAmount;
@property (nonatomic, copy, nullable, readonly) NSNumber *transactionExchangeRate;
@property (nonatomic, copy, nullable, readonly) NSString *maximumAmount;
@property (nonatomic, copy, nullable, readonly) NSString *minimumAmount;
@property (nonatomic, copy, nullable, readonly) NSString *profileTitle;
@property (nonatomic, copy, nullable, readonly) NSString *deviceFPSessionID;
@property (nonatomic, copy, nullable, readonly) NSString *deviceFPOrganizationID;
@property (nonatomic, copy, nullable, readonly) NSString *paymentTimeout;
@property (nonatomic, copy, nullable, readonly) NSString *secretKey;
@property (nonatomic, copy, nullable, readonly) NSString *merchantEmail;

@end
