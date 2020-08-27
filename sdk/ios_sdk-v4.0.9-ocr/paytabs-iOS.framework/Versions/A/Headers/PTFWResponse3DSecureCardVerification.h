//
//  PTFWResponse3DSecureCardVerification.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/24/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

FOUNDATION_EXTERN const struct PTFWResponse3DSecureCardVerificationKeys {
    __unsafe_unretained NSString * __nonnull result;
    __unsafe_unretained NSString * __nonnull responseCode;
    __unsafe_unretained NSString * __nonnull transactionID;
} PTFWResponse3DSecureCardVerificationKeys;

@interface PTFWResponse3DSecureCardVerification : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, nullable, readonly) NSString *result;
@property (nonatomic, copy, nullable, readonly) NSString *responseCode;
@property (nonatomic, copy, nullable, readonly) NSNumber *transactionID;

@end
