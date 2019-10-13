//
//  PTFWNetworkConstants.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 10/8/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PTFWStatusCodes) {
    // Connectivity issues
    PTFWNoInternetAccess                                               = -1004,
    PTFWTimedOut                                                       = -1001,
    PTFWFailingURL                                                     = -999,
    // Bad request
    PTFWStatusBadRequest                                               = 2000,
    PTFWStatusBadRequestDeviceKeyIsMissing                             = 2001,
    PTFWStatusBadRequestUserKeyIsMissing                               = 2002,
    PTFWStatusBadRequestAppVersionIsMissing                            = 2003,
    PTFWStatusBadRequestUDIDMissing                                    = 2005,
    // Useless
    PTFWStatusInvalidLoginCredentials                                  = 2104,
    PTFWStatusInvalidEmailAddress                                      = 2105,
    PTFWStatusEmailAddressAlreadyInUse                                 = 2109,
    PTFWStatusHarmfulInputDetected                                     = 9999,
    // Bad request
    PTFWValidSecretKey                                                 = 4000,
    PTFWInvalidSecretKey                                               = 4002,
    // Transactions
    PTFWSuccessfulTransaction                                          = 100,
    PTFWSuccessfulAutorization                                         = 111,
    PTFWNon3DsAmexTransaction                                          = 474,
    PTFWForceAcceptTransaction                                         = 475,
    PTFWRejectedTransaction                                            = 481,
    PTFWPaytabsRequestError1                                           = 700,
    PTFWPaytabsRequestError2                                           = 800,
    PTFWPaytabsRetryTransaction                                        = 150,
    PTFWInvalidCurrencyTransaction                                     = 804,
    PTFWRejectedCardTransaction                                        = 810,
    PTFWVISATransaction                                                = 900,
    PTFWMPGSTransaction                                                = 910,
    PTFWMIGSTransaction                                                = 909,
    PTFWNoPermissionTransaction                                        = 4404,
    PTFWPreAuthNotEnabledTransaction                                   = 4047
};

FOUNDATION_EXTERN NSString *__nonnull const kPTFWNetworkAPIBaseURL;
FOUNDATION_EXTERN NSString *__nonnull const kPTFWNetworkWebBaseURL;

FOUNDATION_EXTERN NSString *__nonnull PTFWNetworkUserCallCreate(NSString *__nonnull call);

extern const struct PTFWNetworkUserCalls {
    __unsafe_unretained NSString * __nonnull validateSecretKey;
    __unsafe_unretained NSString * __nonnull getMerchantInfo;
    __unsafe_unretained NSString * __nonnull prepareTransaction;
    __unsafe_unretained NSString * __nonnull prepareTransactionApplePay;
    __unsafe_unretained NSString * __nonnull payerAuthComplete;
 } PTFWNetworkUserCalls;

