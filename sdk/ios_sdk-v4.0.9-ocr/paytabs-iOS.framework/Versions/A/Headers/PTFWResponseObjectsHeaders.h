//
//  PTFWResponseObjectsHeaders.h
//  paytabs-iOS
//
//  Created by Humayun Sohail on 10/12/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#ifndef PTFWResponseObjectsHeaders_h
#define PTFWResponseObjectsHeaders_h

#pragma mark - Secret Key Validation
#import "PTFWResponseSecretKeyValidation.h"

#pragma mark - Merchant Info
#import "PTFWResponseFetchMerchantInfo.h"

#pragma mark - Transaction
#import "PTFWResponsePrepareTransaction.h"
#import "PTFWResponseTransactionVISAAuth.h"
#import "PTFWResponseTransactionMPGSAuth.h"
#import "PTFWResponseTransactionMIGSAuth.h"
#import "PTFWResponseTokenization.h"

#pragma mark - 3D Secure Card Verification
#import "PTFWResponse3DSecureCardVerification.h"

#endif /* PTFWResponseObjectsHeaders_h */
