//
//  PTFWResponsePrepareTransaction.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/12/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

@class PTFWResponseTokenization;

FOUNDATION_EXTERN const struct PTFWResponsePrepareTransactionKeys {
    // Common Keys
    __unsafe_unretained NSString * __nonnull result;
    __unsafe_unretained NSString * __nonnull responseCode;
    __unsafe_unretained NSString * __nonnull transactionID;
    __unsafe_unretained NSString * __nonnull statementReference;
    __unsafe_unretained NSString * __nonnull traceCode;
    // 3DS Keys
    __unsafe_unretained NSString * __nonnull redirectUrl;
    __unsafe_unretained NSString * __nonnull returnUrl;

    // Tokenization
    __unsafe_unretained NSString * __nonnull tokenization;
} PTFWResponsePrepareTransactionKeys;

@interface PTFWResponsePrepareTransaction : MTLModel<MTLJSONSerializing>

// Common Properties
@property (nonatomic, copy, nullable, readwrite) NSString *result;
@property (nonatomic, copy, nullable, readonly) NSNumber *responseCode;
@property (nonatomic, copy, nullable, readonly) NSNumber *transactionID;
@property (nonatomic, copy, nullable, readwrite) NSString *statementReference;
@property (nonatomic, copy, nullable, readwrite) NSString *traceCode;

// 3DS Properties
@property (nonatomic, copy, nullable, readonly) NSString *redirectUrl;
@property (nonatomic, copy, nullable, readonly) NSString *returnUrl;

// Tokenization
@property (nonatomic, copy, nullable, readonly) PTFWResponseTokenization *tokenization;

@end
