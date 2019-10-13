//
//  PTFWOperationFetchMerchantInfo.h
//  paytabs-iOS
//
//  Created by PayTabs LLC on 15/12/17.
//  Copyright © 2017 PayTabs LLC. All rights reserved.
//

#import "PTFWNetworkOperationBase.h"

@class PTFWResponseFetchMerchantInfo;

@interface PTFWOperationFetchMerchantInfo : PTFWNetworkOperationBase

#pragma mark - Properties
@property (nonatomic, copy, nullable) NSString *secretKey;
@property (nonatomic, copy, nullable) NSString *merchantEmail;
@property (nonatomic, copy, nullable) NSString *currencyCode;
@property (nonatomic, assign) float amount;
@property (nonatomic, assign) BOOL isTokenization;
@property (nonatomic, assign) BOOL isExistingCustomer;
@property (nonatomic, copy, nullable) NSString *paytabsToken;
@property (nonatomic, copy, nullable) NSString *customerEmail;
@property (nonatomic, copy, nullable) NSString *customerPassword;

#pragma mark - Callbacks
@property (nonatomic, copy, nullable) void(^didFinishSuccessfullyCallback)(PTFWResponseFetchMerchantInfo *__nonnull responseObject);

@end
