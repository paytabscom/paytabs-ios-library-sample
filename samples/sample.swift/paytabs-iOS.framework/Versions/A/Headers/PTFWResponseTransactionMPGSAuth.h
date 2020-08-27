//
//  PTFWResponseTransactionVISAAuth.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/23/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

FOUNDATION_EXTERN const struct PTFWResponseTransactionMPGSAuthKeys {
    __unsafe_unretained NSString * __nonnull acsURL;
    __unsafe_unretained NSString * __nonnull termURL;
    __unsafe_unretained NSString * __nonnull paRequest;
    __unsafe_unretained NSString * __nonnull xID;
} PTFWResponseTransactionMPGSAuthKeys;

@interface PTFWResponseTransactionMPGSAuth : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, nullable, readonly) NSString *acsURL;
@property (nonatomic, copy, nullable, readonly) NSString *termURL;
@property (nonatomic, copy, nullable, readonly) NSString *paRequest;
@property (nonatomic, copy, nullable, readonly) NSString *xID;

@end
