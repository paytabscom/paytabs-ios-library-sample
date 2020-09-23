//
//  PTFWResponseTransactionPMIGSAuth.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/26/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

FOUNDATION_EXTERN const struct PTFWResponseTransactionMIGSAuthKeys {
    __unsafe_unretained NSString * __nonnull vpcAccessCode;
    __unsafe_unretained NSString * __nonnull vpcAmount;
    __unsafe_unretained NSString * __nonnull vpcCardExpiryDate;
    __unsafe_unretained NSString * __nonnull vpcCardNumber;
    __unsafe_unretained NSString * __nonnull vpcCardSecurityCode;
    __unsafe_unretained NSString * __nonnull vpcCommand;
    __unsafe_unretained NSString * __nonnull vpcCurrency;
    __unsafe_unretained NSString * __nonnull vpcMarchantTransactionReference;
    __unsafe_unretained NSString * __nonnull vpcMerchantID;
    __unsafe_unretained NSString * __nonnull vpcOrderInfo;
    __unsafe_unretained NSString * __nonnull vpcReturnURL;
    __unsafe_unretained NSString * __nonnull vpcVersion;
    __unsafe_unretained NSString * __nonnull vpcCardType;
    __unsafe_unretained NSString * __nonnull vpcGateway;
} PTFWResponseTransactionMIGSAuthKeys;

@interface PTFWResponseTransactionMIGSAuth : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, nullable, readonly) NSString *vpcAccessCode;
@property (nonatomic, copy, nullable, readonly) NSString *vpcAmount;
@property (nonatomic, copy, nullable, readonly) NSString *vpcCardExpiryDate;
@property (nonatomic, copy, nullable, readonly) NSString *vpcCardNumber;
@property (nonatomic, copy, nullable, readonly) NSString *vpcCardSecurityCode;
@property (nonatomic, copy, nullable, readonly) NSString *vpcCommand;
@property (nonatomic, copy, nullable, readonly) NSString *vpcCurrency;
@property (nonatomic, copy, nullable, readonly) NSString *vpcMarchantTransactionReference;
@property (nonatomic, copy, nullable, readonly) NSString *vpcMerchantID;
@property (nonatomic, copy, nullable, readonly) NSString *vpcOrderInfo;
@property (nonatomic, copy, nullable, readonly) NSString *vpcReturnURL;
@property (nonatomic, copy, nullable, readonly) NSString *vpcVersion;
@property (nonatomic, copy, nullable, readonly) NSString *vpcCardType;
@property (nonatomic, copy, nullable, readonly) NSString *vpcGateway;


@end
