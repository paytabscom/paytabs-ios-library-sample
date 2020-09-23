//
//  PTFWResponseSecretKeyValidation.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/12/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Mantle/Mantle.h>

FOUNDATION_EXTERN const struct PTFWResponseSecretKeyValidationKeys {
    __unsafe_unretained NSString * __nonnull result;
    __unsafe_unretained NSString * __nonnull responseCode;
} PTFWResponseSecretKeyValidationKeys;

@interface PTFWResponseSecretKeyValidation : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy, nullable, readonly) NSString *result;
@property (nonatomic, copy, nullable, readonly) NSString *responseCode;

@end
