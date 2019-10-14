//
//  PTFWResponsePrepareTransaction.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/12/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

@class PTFWResponseTransactionVISAAuth;
@class PTFWResponseTransactionMIGSAuth;
@class PTFWResponseTransactionMPGSAuth;
@class PTFWResponseTokenization;

FOUNDATION_EXTERN const struct PTFWResponsePrepareTransactionKeys {
    // Common Keys
    __unsafe_unretained NSString * __nonnull result;
    __unsafe_unretained NSString * __nonnull responseCode;
    __unsafe_unretained NSString * __nonnull transactionID;
    __unsafe_unretained NSString * __nonnull merchantID;

    // VISA Keys
    __unsafe_unretained NSString * __nonnull decision;
    __unsafe_unretained NSString * __nonnull localTransactionID;
    __unsafe_unretained NSString * __nonnull merchantReferenceCode;
    __unsafe_unretained NSString * __nonnull reasonCode;
    __unsafe_unretained NSString * __nonnull requestID;
    __unsafe_unretained NSString * __nonnull requestToken;
    __unsafe_unretained NSString * __nonnull tokenized;
    __unsafe_unretained NSString * __nonnull payerAuthReply;
    
    // MIGS Keys
    __unsafe_unretained NSString * __nonnull migsLocale;
    __unsafe_unretained NSString * __nonnull migsTransactionURL;
    __unsafe_unretained NSString * __nonnull migsSecureHash;
    __unsafe_unretained NSString * __nonnull migsIsExpress;
    __unsafe_unretained NSString * __nonnull migsAuthReply;
    
    // MPGS Keys
    __unsafe_unretained NSString * __nonnull mpgsIsExpress;
    __unsafe_unretained NSString * __nonnull mpgsResponseData3D;

    // Tokenization
    __unsafe_unretained NSString * __nonnull tokenization;
} PTFWResponsePrepareTransactionKeys;

@interface PTFWResponsePrepareTransaction : MTLModel<MTLJSONSerializing>

// Common Properties
@property (nonatomic, copy, nullable, readwrite) NSString *result;
@property (nonatomic, copy, nullable, readonly) NSNumber *responseCode;
@property (nonatomic, copy, nullable, readonly) NSNumber *transactionID;
@property (nonatomic, copy, nullable, readonly) NSString *merchantID;

// VISA Properties
@property (nonatomic, copy, nullable, readonly) NSString *decision;
@property (nonatomic, copy, nullable, readonly) NSNumber *localTransactionID;
@property (nonatomic, copy, nullable, readonly) NSString *merchantReferenceCode;
@property (nonatomic, copy, nullable, readonly) NSNumber *reasonCode;
@property (nonatomic, copy, nullable, readonly) NSString *requestID;
@property (nonatomic, copy, nullable, readonly) NSString *requestToken;
@property (nonatomic, copy, nullable, readonly) NSString *tokenized;
@property (nonatomic, copy, nullable, readonly) PTFWResponseTransactionVISAAuth *payerAuthReply;

// MIGS Properties
@property (nonatomic, copy, nullable, readonly) NSString *migsLocale;
@property (nonatomic, copy, nullable, readonly) NSString *migsTransactionURL;
@property (nonatomic, copy, nullable, readonly) NSString *migsSecureHash;
@property (nonatomic, copy, nullable, readonly) NSNumber *migsIsExpress;
@property (nonatomic, copy, nullable, readonly) PTFWResponseTransactionMIGSAuth *migsAuthReply;

// MOGS Properties
@property (nonatomic, copy, nullable, readonly) NSNumber *mpgsIsExpress;
@property (nonatomic, copy, nullable, readonly) PTFWResponseTransactionMPGSAuth *mpgsResponseData3D;

// Tokenization
@property (nonatomic, copy, nullable, readonly) PTFWResponseTokenization *tokenization;

@end
