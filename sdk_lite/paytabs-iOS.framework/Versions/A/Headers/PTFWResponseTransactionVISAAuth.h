//
//  PTFWResponseTransactionVISAAuth.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/23/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

FOUNDATION_EXTERN const struct PTFWResponseTransactionVISAAuthKeys {
    __unsafe_unretained NSString * __nonnull acsURL;
    __unsafe_unretained NSString * __nonnull authenticationPath;
    __unsafe_unretained NSString * __nonnull paRequest;
    __unsafe_unretained NSString * __nonnull proofXML;
    __unsafe_unretained NSString * __nonnull proxyPAN;
    __unsafe_unretained NSString * __nonnull reasonCode;
    __unsafe_unretained NSString * __nonnull veresEnrolled;
    __unsafe_unretained NSString * __nonnull xID;
} PTFWResponseTransactionVISAAuthKeys;

@interface PTFWResponseTransactionVISAAuth : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, nullable, readonly) NSString *acsURL;
@property (nonatomic, copy, nullable, readonly) NSString *authenticationPath;
@property (nonatomic, copy, nullable, readonly) NSString *paRequest;
@property (nonatomic, copy, nullable, readonly) NSString *proofXML;
@property (nonatomic, copy, nullable, readonly) NSString *proxyPAN;
@property (nonatomic, copy, nullable, readonly) NSNumber *reasonCode;
@property (nonatomic, copy, nullable, readonly) NSString *veresEnrolled;
@property (nonatomic, copy, nullable, readonly) NSString *xID;

@end
